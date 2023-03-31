<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/";
%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
<meta charset="UTF-8">

<link href="jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
		pageList();
		pageList2();

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
	});
	function pageList() {
		$.ajax({
			url : "workbench/car/transHistory.do",
			data : {
				"cid" : "${c.cid}"
			},
			type : "get",
			dataType : "json",
			success : function (data) {
				var html = "";
				//每一个n就是每一个市场活动对象
				$.each(data,function (i,n) {
					html += '<tr class="active">';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/transaction/detail.do?id='+n.id+'\';">'+n.name+'</a></td>';
					html += '<td>'+n.createDate+'</td>';
					html += '<td>'+n.totalprice+'</td>';
					html += '<td>'+n.description+'</td>';
					html += '</tr>';
				})

				$("#transHistoryBody").html(html);
			}
		})
	}
	function pageList2() {

		$.ajax({
			url : "workbench/car/isTrans.do",
			data : {
				"cid" : "${c.cid}"
			},
			type : "get",
			dataType : "json",
			success : function (data) {
				var html = "";
				//每一个n就是每一个市场活动对象
				$.each(data,function (i,n) {
					html += '<tr class="active">';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/transaction/detail.do?id='+n.id+'\';">'+n.name+'</a></td>';
					html += '<td>'+n.createDate+'</td>';
					html += '<td>'+n.totalprice+'</td>';
					html += '<td>'+n.description+'</td>';
					html += '<td>'+n.stage+'</td>';
					html += '</tr>';
				})

				$("#isTrans").html(html);
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
			<h3>李四先生 <small> - 动力节点</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editContactsModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">车牌号</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${c.plateNo}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">车辆名称</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${c.cname}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">司机名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${c.did}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">车辆状态</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${c.stage}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">车辆所属网点</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${c.cplace}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">公司</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${c.company}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">核定载重</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${c.cload}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">发动机号</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${c.fdjId}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">保险号</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>baoxianId&nbsp;</b></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${c.description}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">创建人</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${c.createBy}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>

	
	<!-- 交易 -->
	<div>
		<div style="position: relative; top: 20px; left: 40px;">
			<div class="page-header">
				<h4>交易中</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable3" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>订单名称</td>
							<td>开始日期</td>
							<td>订单价格</td>
							<td>描述</td>
							<td>交易状态</td>
						</tr>
					</thead>
					<tbody id="isTrans">

					</tbody>
				</table>
			</div>

		</div>
	</div>
	
	<!-- 运输历史 -->
	<div>
		<div style="position: relative; top: 60px; left: 40px;">
			<div class="page-header">
				<h4>运输历史</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>订单名称</td>
							<td>开始日期</td>
							<td>订单价格</td>
							<td>描述</td>

						</tr>
					</thead>
					<tbody id="transHistoryBody">

					</tbody>
				</table>
			</div>

		</div>
	</div>
	
	
	<div style="height: 200px;"></div>
</body>
</html>