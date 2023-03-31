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
	<link href="jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

	<script type="text/javascript" src="jquery/jquery-1.11.1-min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){



		$.ajax({
			url : "workbench/product/getProductHistory.do",
			data : {
				"pid" : "${p.pid}"
			},
			type : "get",
			dataType : "json",
			success : function (data) {
				var html = "";
				//每一个n就是每一个市场活动对象
				$.each(data,function (i,n) {
					html += '<tr class="active">';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/transaction/detail.do?id='+n.oid+'\';">'+n.oname+'</a></td>';
					html += '<td>'+n.pnumber+'</td>';
					html += '<td>'+n.createDate+'</td>';
					html += '<td>'+n.stage+'</td>';
					html += '</tr>';
				})

				$("#productHistoryBody").html(html);
			}
		})


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
			<h3>农产品详情页</h3>
		</div>
		<div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editClueModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${p.pname}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">所属商户</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${p.mid}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">产地</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${p.paddress}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">创建人</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${p.createBy}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">当前库存</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${p.repertory}</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">产品售价</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${p.price}</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>


		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">生产日期</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;">${p.createDate}</div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">过期日期</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${p.endDate}</b><small style="font-size: 10px; color: gray;"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					${p.description}
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>

	</div>
	

	
	<!-- 市场活动 -->
	<div>
		<div style="position: relative; top: 60px; left: 40px;">
			<div class="page-header">
				<h4>下单历史</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>订单名称</td>
							<td>下单数量</td>
							<td>下单日期</td>
							<td>订单状态</td>
						</tr>
					</thead>
					<tbody id="productHistoryBody">

					</tbody>
				</table>
			</div>

		</div>
	</div>
	
	
	<div style="height: 200px;"></div>
</body>
</html>