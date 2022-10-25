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

	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){


		$.ajax({
			url : "workbench/car/getCarList.do",
			type : "get",
			dataType : "json",
			success : function (data) {
				var html = "<option></option>";
				//遍历出来的每一个n，就是每一个user对象
				$.each(data,function (i,n) {

					html += "<option value='"+n.cid+"'>"+n.cname+"</option>";

				})
				$("#create-carid").html(html);
			}
		})

		pageList(1,5);
		pageList2(1,5);

		$("#addProductBtn").click(function () {

			var $xz = $("input[name=xz]:checked");

			if($xz.length==0 || $xz.length>1){

				alert("请选择只能选一条");

				//肯定选了，而且有可能是1条，有可能是多条
			}else{
				var pid = $($xz[0]).val();


			}
		})

		//为保存按钮绑定事件，执行添加操作
		$("#saveBtn").click(function () {

			$.ajax({

				url : "workbench/transaction/addProductToOrder.do",
				data : {
					"pid" : $.trim($("#create-pid").val()),
					"number" : $.trim($("#create-number").val()),
					"pname" : $.trim($("#create-pname").val()),
					"mname" : $.trim($("#create-mname").val()),
					"price" : $.trim($("#create-price").val()),
					"paddress" : $.trim($("#create-paddress").val()),
					"count" : $.trim($("#create-count").val()),
					"createDate" : $.trim($("#create-createDate").val()),
					"oid" : "${oid.id}"
				},
				type : "post",
				dataType : "json",
				success : function (data) {
					if(data.success){

						pageList2(1,$("#orderPage").bs_pagination('getOption', 'rowsPerPage'));

						$("#productAddForm")[0].reset();

						//关闭添加操作的模态窗口
						$("#createProductModal").modal("hide");
						pageList(1,5);

					}else{
						alert("添加失败");
					}

				}
			})

		})


		$("#jiesuanBtn").click(function () {

			$.ajax({

				url : "workbench/transaction/getSumByOrderId.do",
				data : {

					"oid" : "${oid.id}"
				},
				type : "post",
				dataType : "json",
				success : function (data) {
						$("#create-orderSum").val(data.totalprice);


				}
			})
		})


		//为保存按钮绑定事件，执行添加操作
		$("#saveOrderBtn").click(function () {

			$.ajax({

				url : "workbench/transaction/saveOrder.do",
				data : {
					"name" : $.trim($("#create-ordername").val()),
					"totalprice" : $.trim($("#create-orderSum").val()),
					"createBy" : "${user.id}",
					"paddress" : $.trim($("#create-paddress").val()),
					"carid" : $.trim($("#create-carid").val()),
					"stage" : $.trim($("#create-stage").val()),
					"description" : $.trim($("#create-description").val()),
					"oid" : "${oid.id}"
				},
				type : "post",
				dataType : "json",
				success : function (data) {
					if(data.success){
						window.location.href = "workbench/transaction/index.jsp";
					}else{
						alert("添加失败");
					}

				}
			})

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

	function addProductBtn1(e) {
		$.ajax({
			url : "workbench/transaction/getProductById.do",
			data : {"pid" : e},
			type : "get",
			dataType : "json",
			success : function (data) {
				$("#create-pid").val(e);
				$("#create-pname").val(data.pname);
				$("#create-mname").val(data.mid);
				$("#create-createDate").val(data.createDate);
				$("#create-paddress").val(data.paddress);
				$("#create-price").val(data.price);
				$("#create-number").val(data.repertory);
				//所有者下拉框处理完毕后，展现模态窗口
				$("#createProductModal").modal("show");
			}
		})
	}
	function pageList2(pageNo,pageSize) {
		//将全选的复选框的√干掉
		$("#qx2").prop("checked",false);
		$.ajax({
			url : "workbench/transaction/orderProductList.do",
			data : {
				"pageNo" : pageNo,
				"pageSize" : pageSize,
				"oid" : "${oid.id}"
			},
			type : "get",
			dataType : "json",
			success : function (data) {
				var html = "";
				//每一个n就是每一个市场活动对象
				$.each(data.dataList,function (i,n) {
					html += '<tr class="active">';
					html += '<td><input type="checkbox" name="xz2" value="'+n.id+'"/></td>';
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
				//计算总页数
				var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;
				//数据处理完毕后，结合分页查询，对前端展现分页信息
				$("#orderPage").bs_pagination({
					currentPage: pageNo, // 页码
					rowsPerPage: pageSize, // 每页显示的记录条数
					maxRowsPerPage: 20, // 每页最多显示的记录条数
					totalPages: totalPages, // 总页数
					totalRows: data.total, // 总记录条数

					visiblePageLinks: 3, // 显示几个卡片

					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,

					//该回调函数时在，点击分页组件的时候触发的
					onChangePage : function(event, data){
						pageList(data.currentPage , data.rowsPerPage);
					}
				});

			}
		})

	}


	function pageList(pageNo,pageSize) {

		//将全选的复选框的√干掉
		$("#qx").prop("checked",false);

		$.ajax({

			url : "workbench/product/pageList.do",
			data : {

				"pageNo" : pageNo,
				"pageSize" : pageSize

			},
			type : "get",
			dataType : "json",
			success : function (data) {

				var html = "";
				//每一个n就是每一个市场活动对象
				//农产品列表
				$.each(data.dataList,function (i,n) {
					html += '<tr class="active">';
					html += '<td><input type="checkbox" name="xz" value="'+n.pid+'"/></td>';
					html += '<td>'+n.pname+'</td>';
					html += '<td>'+n.paddress+'</td>';
					html += '<td>'+n.mid+'</td>';
					html += '<td>'+n.createDate+'</td>';
					html += '<td>'+n.endDate+'</td>';
					html += '<td>'+n.repertory+'</td>';
					html += '<td>'+n.price+'</td>';
					html += '<td><button type="button" class="btn btn-danger" value="'+n.pid+'" onclick="addProductBtn1(this.value)"><span class="glyphicon glyphicon-minus"></span>创建</button></td>';
					html += '</tr>';

				})
				// alert(html);

				$("#productBody").html(html);

				//计算总页数
				var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;
				//数据处理完毕后，结合分页查询，对前端展现分页信息
				$("#productPage").bs_pagination({
					currentPage: pageNo, // 页码
					rowsPerPage: pageSize, // 每页显示的记录条数
					maxRowsPerPage: 20, // 每页最多显示的记录条数
					totalPages: totalPages, // 总页数
					totalRows: data.total, // 总记录条数

					visiblePageLinks: 3, // 显示几个卡片

					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,

					//该回调函数时在，点击分页组件的时候触发的
					onChangePage : function(event, data){
						pageList(data.currentPage , data.rowsPerPage);
					}
				});

			}
		})

	}
	
</script>

</head>
<body>
<input type="hidden" id="create-pid">
	<!-- 往订单里添加产品的模态窗口 -->
	<div class="modal fade" id="createProductModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">创建商户</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="productAddForm">
					
						<div class="form-group">
							<label for="create-pname" class="col-sm-2 control-label">产品名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-pname">
							</div>
	                        <label for="create-mname" class="col-sm-2 control-label">商户姓名<span style="font-size: 15px; color: red;">*</span></label>
	                        <div class="col-sm-10" style="width: 300px;">
	                            <input type="text" class="form-control" id="create-mname">
	                        </div>
						</div>
						
						<div class="form-group">
							<label for="create-createDate" class="col-sm-2 control-label">生产日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-createDate">
							</div>
							<label for="create-paddress" class="col-sm-2 control-label">园区地址</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-paddress">
							</div>
						</div>
	                    
						<div class="form-group">

							<label for="create-price" class="col-sm-2 control-label">单价</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-price">
							</div>
						    <label for="create-count" class="col-sm-2 control-label">下单数量</label>
						    <div class="col-sm-10" style="width: 300px;">
						        <input type="text" class="form-control" id="create-count">
						    </div>
						</div>
						<div class="form-group">

							<label for="create-number" class="col-sm-2 control-label">库存</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-number">
							</div>

						</div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>订单中心</h3>
		</div>
	</div>
		                <form class="form-horizontal" role="form">
		                    <div class="form-group">
								<label for="create-ordername" class="col-sm-2 control-label">订单名称<span style="font-size: 15px; color: red;">*</span></label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-ordername" >

								</div>
		                        <label for="create-orderSum" class="col-sm-2 control-label">订单金额<span style="font-size: 15px; color: red;">*</span></label>
		                        <div class="col-sm-10" style="width: 300px;">
		                            <input type="text" class="form-control" id="create-orderSum" >
									<button type="button" class="btn btn-primary form-control" id="jiesuanBtn">结算</button>
		                        </div>
		                    </div>
							<div class="form-group">
							    <label for="create-carid" class="col-sm-2 control-label">分配车辆</label>
							    <div class="col-sm-10" style="width: 300px;">
							    	<select class="form-control" id="create-carid">

							    	</select>
							    </div>
								<label for="create-stage" class="col-sm-2 control-label">订单状态</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="create-stage">
									  <option></option>
									  <option>待付款</option>
									  <option>待发货</option>
									  <option>运输中</option>
									  <option>派送中</option>
									  <option>待收件</option>
									  <option>已签收</option>
									  <option>车辆空闲</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="create-description" class="col-sm-2 control-label">订单描述</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="2" id="create-description"></textarea>
								</div>
							</div>

		                </form>		   
		            <div class="modal-footer" style="width:500px;position: relative;top:-250px;left:800px; border: none" >
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="saveOrderBtn">保存123</button>
		            </div>
		    
	<!-- 展示订单列表 -->
	<div>
		<div style="position: relative; top: -80px; left: 40px; ">
			<div class="page-header">
				<h4>当前订单</h4>
				 <button type="button" class="btn btn-danger" style="position: relative;left: 800px; top: 0px;" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
			</div>

			<div style="position: relative;top: -20px;">
				<table id="activityTable2" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx2"/></td>
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
			<div style="height: 50px; position: relative;top: 20px;"  id="orderPage">


			</div>
			
			
		</div>
	</div>
	
	<!-- 农产品列表 -->
	<div>
		<div style="position: relative; top: 20px; left: 40px;">
			<div class="page-header">
				<h4>产品列表</h4>
				<button type="button" class="btn btn-danger" style="position: relative;left: 800px; top: -40px;" id="addProductBtn"><span class="glyphicon glyphicon-minus"></span>创建111</button>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox"  id="qx"/></td>
							<td>产品名称</td>
							<td>生产园区</td>
							<td>所属商户</td>
							<td>生产日期</td>
							<td>到期日期</td>
							<td>当前批次数量</td>
							<td>售价</td>
							<td>添加</td>
						</tr>
					</thead>
					<tbody id="productBody">

					</tbody>
				</table>
			</div>
			
			<div style="width:100%;height: 50px; position: relative;top: 20px;" id="productPage">


			</div>
			
			
		</div>
	</div>
	

</body>
</html>