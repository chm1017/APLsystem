<%@ page import="com.cm.APL.workbench.domain.Orderform" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cm.APL.settings.domain.DicType" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
	List<DicType> dicTypeList = (List<DicType>) application.getAttribute("dic");
%>

<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">
	<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>


<style type="text/css">
.mystage{
	font-size: 20px;
	vertical-align: middle;
	cursor: pointer;
}
.closingDate{
	font-size : 15px;
	cursor: pointer;
	vertical-align: middle;
}
</style>


<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});

		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});

		$(".remarkDiv").mouseover(function(){
			$(this).children("div").children("div").show();
		});

		$(".remarkDiv").mouseout(function(){
			$(this).children("div").children("div").hide();
		});

		$(".myHref").mouseover(function(){
			$(this).children("span").css("color","red");
		});

		$(".myHref").mouseout(function(){
			$(this).children("span").css("color","#E6E6E6");
		});

		showRemarkList();

		$("#remarkBody").on("mouseover",".remarkDiv",function(){
			$(this).children("div").children("div").show();
		})
		$("#remarkBody").on("mouseout",".remarkDiv",function(){
			$(this).children("div").children("div").hide();
		})


		//阶段提示框
		$(".mystage").popover({
			trigger:'manual',
			placement : 'bottom',
			html: 'true',
			animation: false
		}).on("mouseenter", function () {
			var _this = this;
			$(this).popover("show");
			$(this).siblings(".popover").on("mouseleave", function () {
				$(_this).popover('hide');
			});
		}).on("mouseleave", function () {
			var _this = this;
			setTimeout(function () {
				if (!$(".popover:hover").length) {
					$(_this).popover("hide")
				}
			}, 100);
		});


		//为保存按钮绑定事件，执行备注添加操作
		$("#saveRemarkBtn").click(function () {

			$.ajax({

				url : "workbench/transaction/saveRemark.do",
				data : {
					"noteContent" : $.trim($("#remark").val()),
					"orderFormId" : "${o.id}",
					"createBy" : "${user.id}"
				},
				type : "post",
				dataType : "json",
				success : function (data) {
					if(data.success){

						//添加成功

						//textarea文本域中的信息清空掉
						$("#remark").val("");

						//在textarea文本域上方新增一个div
						var html = "";

						html += '<div id="'+data.or.id+'" class="remarkDiv" style="height: 60px;">';
						html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
						html += '<div style="position: relative; top: -40px; left: 40px;" >';
						html += '<h5>'+data.or.noteContent+'</h5>';
						html += '<font color="gray">市场活动</font> <font color="gray">-</font> <b>${o.name}</b> <small style="color: gray;" >'+data.or.createDate+' 由 '+data.or.createBy +'</small>';
						html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
						html += '<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
						html += '&nbsp;&nbsp;&nbsp;&nbsp;';
						html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+data.or.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
						html += '</div>';
						html += '</div>';
						html += '</div>';

						$("#remarkDiv").before(html);


					}else{

						alert("添加备注失败");

					}


				}

			})

		})



		pageList();


	});
	function deleteRemark(id) {

		$.ajax({

			url : "workbench/transaction/deleteRemark.do",
			data : {

				"id" : id

			},
			type : "post",
			dataType : "json",
			success : function (data) {
				if(data.success){
					$("#"+id).remove();
				}else{
					alert("删除备注失败");
				}


			}

		})

	}


	function pageList() {
		//将全选的复选框的√干掉
		$.ajax({

			url : "workbench/transaction/getorderListById.do",
			data : {
				"oid" : "${o.id}"
			},
			type : "get",
			dataType : "json",
			success : function (data) {
				var html = "";
				//每一个n就是每一个市场活动对象
				$.each(data,function (i,n) {
					html += '<tr class="active">';
					html += '<td>'+n.pname+'</td>';
					html += '<td>'+n.createDate+'</td>';
					html += '<td>'+n.mname+'</td>';
					html += '<td>'+n.paddress+'</td>';
					html += '<td>'+n.price+'</td>';
					html += '<td>'+n.count+'</td>';
					html += '<td>'+n.totalprice+'</td>';
					html += '</tr>';
				})

				$("#orderBody").html(html);
			}
		})

	}

	function changeStage(stage, i) {
		$.ajax({
			url : "workbench/transaction/changeStage.do",
			data : {
				"cname" : "${o.carid}",
				"id" : "${o.id}",
				"stage" : stage
			},
			type : "post",
			dataType : "json",
			success : function (data) {
				$("#create-stage").html(stage);
				changeIcon(stage, i);
			}
		})
	}

	function changeIcon(stage, index1) {
		var currentStage = stage;
		var index = index1;
		for (var i = 0; i <<%=dicTypeList.size()%>; i++) {
			if (i == index) {
				//绿色标记--------------------------
				$("#"+i).removeClass();
				$("#"+i).addClass("glyphicon glyphicon-map-marker mystage");
				$("#"+i).css("color","#90F790");
			}else if (i < index) {
				//绿圈------------------------------
				$("#" + i).removeClass();
				$("#" + i).addClass("glyphicon glyphicon-ok-circle mystage");
				$("#" + i).css("color", "#90F790");
			} else {
				//黑圈-------------------------------
				$("#"+i).removeClass();
				$("#"+i).addClass("glyphicon glyphicon-record mystage");
				$("#"+i).css("color","#000000");
			}
		}
	}

	function showRemarkList() {

		$.ajax({

			url : "workbench/transaction/getRemarkListById.do",
			data : {
				"id" : "${o.id}"
			},
			type : "get",
			dataType : "json",
			success : function (data) {

				var html = "";

				$.each(data,function (i,n) {
					/*
						javascript:void(0);
							将超链接禁用，只能以触发事件的形式来操作
					 */
					html += '<div id="'+n.id+'" class="remarkDiv" style="height: 60px;">';
					html += '<img title="zhangsan" src="image/user-thumbnail.png" style="width: 30px; height:30px;">';
					html += '<div style="position: relative; top: -40px; left: 40px;" >';
					html += '<h5 id="e'+n.id+'">'+n.noteContent+'</h5>';
					html += '<font color="gray">市场活动</font> <font color="gray">-</font> <b>${o.name}</b> <small style="color: gray;" >'+n.createDate+' 由 '+n.createBy +'</small>';
					html += '<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">';
					html += '<a class="myHref" href="javascript:void(0);" onclick="editRemark(\''+n.id+'\')"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #FF0000;"></span></a>';
					html += '&nbsp;&nbsp;&nbsp;&nbsp;';
					html += '<a class="myHref" href="javascript:void(0);" onclick="deleteRemark(\''+n.id+'\')"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #FF0000;"></span></a>';
					html += '</div>';
					html += '</div>';
					html += '</div>';

				})

				$("#remarkDiv").before(html);

			}

		})

	}




</script>

</head>
<body>
	
	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>${o.name}<small>￥${o.totalprice}</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" onclick="window.location.href='edit.html';"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>

	<!-- 阶段状态 -->
	<div style="position: relative; left: 40px; top: -50px;">
		阶段&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<%

			//准备当前阶段
			Orderform t = (Orderform)request.getAttribute("o");
			String currentStage = t.getStage();
			int index = 0;
			for (int i = 0; i <dicTypeList.size(); i++) {
				DicType dicType =dicTypeList.get(i);
				String stage = dicType.getType();
				if (stage.equals(currentStage)) {
					index = i;
					break;
				}
			}

			for (int i = 0; i <dicTypeList.size(); i++) {
				DicType dicType =dicTypeList.get(i);
				int k  = dicType.getId();
				String stage = dicType.getType();
				if (k == index) {
		%>

		<span id="<%=i%>" onclick="changeStage('<%=stage%>','<%=i%>')"
			  class="glyphicon glyphicon-map-marker mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dicType.getText()%>" style="color: #90F790;"></span>
		-----------

		<%
				} else if (i < index) {

		%>

		<span id="<%=i%>" onclick="changeStage('<%=stage%>','<%=i%>')"
			  class="glyphicon glyphicon-ok-circle mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dicType.getText()%>" style="color: #90F790;"></span>
		-----------

		<%
			}else {
		%>

		<span id="<%=i%>" onclick="changeStage('<%=stage%>','<%=i%>')"
			  class="glyphicon glyphicon-record mystage"
			  data-toggle="popover" data-placement="bottom"
			  data-content="<%=dicType.getText()%>" style="color: #000000;"></span>
		-----------
		<%
			}
			}

		%>

	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: 0px;">

		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${o.name}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">成交日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${o.createDate}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">车辆名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${o.carid}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">阶段</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="create-stage">${o.stage}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">车辆联系人名称</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${o.did}</b></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>


		<div style="position: relative; left: 40px; height: 30px; top: 80px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${o.description}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>

	</div>
	

	
	<!-- 阶段历史 -->
	<div>
		<div style="position: relative; top: 100px; left: 40px;">
			<div class="page-header">
				<h4>订单详情</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>产品名称</td>
							<td>生产日期</td>
							<td>所属商户</td>
							<td>园区地址</td>
							<td>产品售价</td>
							<td>下单数量</td>
							<td>总价</td>
						</tr>
					</thead>
					<tbody id="orderBody">

					</tbody>
				</table>
			</div>
			
		</div>
	</div>

	<div style="height: 20px;"></div>


	<!-- 备注 -->
	<div style="position: relative; top: 30px; left: 40px;" id="remarkBody">
		<div class="page-header">
			<h4>备注</h4>
		</div >



		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" class="btn btn-primary" id="saveRemarkBtn">保11存</button>
				</p>
			</form>
		</div>
	</div>
	<div style="height: 20px;"></div>
	

</body>
</html>