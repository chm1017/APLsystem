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

	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

<script type="text/javascript">

	$(function(){

		pageList(1, 2);
		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });
		//为创建按钮绑定事件，打开添加操作的模态窗口
		$("#addBtn").click(function () {
			//走后台，目的是为了取得用户信息列表，为所有者下拉框铺值
			$.ajax({
				url : "workbench/driver/getUserList.do",
				type : "get",
				dataType : "json",
				success : function (data) {
					var html = "<option></option>";
					//遍历出来的每一个n，就是每一个user对象
					$.each(data,function (i,n) {

						html += "<option value='"+n.id+"'>"+n.name+"</option>";

					})
					$("#create-createBy").html(html);

					//取得当前登录用户的id
					//在js中使用el表达式，el表达式一定要套用在字符串中
					var id = "${user.id}";
					$("#create-createBy").val(id);
					//所有者下拉框处理完毕后，展现模态窗口
					$("#createDriverModal").modal("show");

				}
			})
		})
		//为保存按钮绑定事件，执行添加操作
		$("#saveBtn").click(function () {

			$.ajax({

				url : "workbench/driver/save.do",
				data : {

					"createBy" : $.trim($("#create-createBy").val()),
					"dname" : $.trim($("#create-dname").val()),
					"dage" : $.trim($("#create-dage").val()),
					"dphone" : $.trim($("#create-dphone").val()),
					"daddress" : $.trim($("#create-daddress").val()),
					"idNumber" : $.trim($("#create-idNumber").val()),
					"dplace" : $.trim($("#create-dplace").val()),
					"driveId" : $.trim($("#create-driveId").val()),
					"stage" : $.trim($("#create-stage").val())
				},
				type : "post",
				dataType : "json",
				success : function (data) {
					if(data.success){

						pageList(1,$("#driverPage").bs_pagination('getOption', 'rowsPerPage'));

						$("#driverAddForm")[0].reset();

						//关闭添加操作的模态窗口
						$("#createDriverModal").modal("hide");
						// alert("添加陈工")

					}else{
						alert("添加商户信息失败");
					}

				}
			})

		})
		//为全选的复选框绑定事件，触发全选操作
		$("#qx").click(function () {

			$("input[name=xz]").prop("checked",this.checked);

		})
		$("#productBody").on("click",$("input[name=xz]"),function () {

			$("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);

		})
		$("#editBtn").click(function () {
			var $xz = $("input[name=xz]:checked");

			if($xz.length==0){

				alert("请选择需要修改的记录");

			}else if($xz.length>1){

				alert("只能选择一条记录进行修改");

				//肯定只选了一条
			}else{

				var id = $xz.val();

				$.ajax({

					url : "workbench/driver/getDriverById.do",
					data : {
						"did" : id
					},
					type : "get",
					dataType : "json",
					success : function (data) {

						//处理所有者下拉框
						var html = "<option></option>";

						$.each(data.uList,function (i,n) {

							html += "<option value='"+n.id+"'>"+n.name+"</option>";

						})
						$("#edit-createBy").html(html);
						$("#edit-did").val(data.a.did);
						$("#edit-createBy").val(data.a.createBy);
						//处理单条activity
						$("#edit-dname").val(data.a.dname);
						$("#edit-dage").val(data.a.dage);
						$("#edit-daddress").val(data.a.daddress);
						$("#edit-idNumber").val(data.a.idNumber);
						$("#edit-dphone").val(data.a.dphone);
						$("#edit-dplace").val(data.a.dplace);
						$("#edit-driveId").val(data.a.driveId);
						$("#edit-stage").val(data.a.stage);
						//所有的值都填写好之后，打开修改操作的模态窗口
						$("#editDriverModal").modal("show");
					}
				})
			}
		})
		//为保存按钮绑定事件，执行添加操作
		$("#updateBtn").click(function () {

			$.ajax({

				url : "workbench/driver/update.do",
				data : {
					"did" : $.trim($("#edit-did").val()),
					"createBy" : $.trim($("#edit-createBy").val()),
					"dname" : $.trim($("#edit-dname").val()),
					"dage" : $.trim($("#edit-dage").val()),
					"daddress" : $.trim($("#edit-daddress").val()),
					"dphone" : $.trim($("#edit-dphone").val()),
					"idNumber" : $.trim($("#edit-idNumber").val()),
					"dplace" : $.trim($("#edit-dplace").val()),
					"driveId" : $.trim($("#edit-driveId").val()),
					"stage" : $.trim($("#edit-stage").val())
				},
				type : "post",
				dataType : "json",
				success : function (data) {
					if(data.success){

						pageList(1,$("#driverPage").bs_pagination('getOption', 'rowsPerPage'));



						//关闭添加操作的模态窗口
						$("#editDriverModal").modal("hide");
						// alert("添加陈工")


					}else{
						alert("修改司机信息失败");
					}

				}
			})

		})
		$("#deleteBtn").click(function () {
			var $xz = $("input[name=xz]:checked");
			if($xz.length==0){
				alert("请选择需要删除的记录");
			}else{
				if(confirm("确定删除所选中的记录吗？")){
					var param = "";
					for(var i=0;i<$xz.length;i++){
						param += "id="+$($xz[i]).val();
						if(i<$xz.length-1){
							param += "&";
						}
					}
					$.ajax({
						url : "workbench/driver/delete.do",
						data : param,
						type : "post",
						dataType : "json",
						success : function (data) {
							if(data.success){
								pageList(1,$("#driverPage").bs_pagination('getOption', 'rowsPerPage'));
							}else{
								alert("删除市场活动失败");
							}
						}
					})
				}
			}
		})

	});
	function pageList(pageNo,pageSize) {

		//将全选的复选框的√干掉
		$("#qx").prop("checked",false);

		$.ajax({

			url : "workbench/driver/pageList.do",
			data : {

				"pageNo" : pageNo,
				"pageSize" : pageSize

			},
			type : "get",
			dataType : "json",
			success : function (data) {

				var html = "";
				//每一个n就是每一个市场活动对象
				$.each(data.dataList,function (i,n) {
					html += '<tr class="active">';
					html += '<td><input type="checkbox" name="xz" value="'+n.did+'"/></td>';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/driver/detail.do?id='+n.did+'\';">'+n.dname+'</a></td>';
					html += '<td>'+n.dage+'</td>';
					html += '<td>'+n.dphone+'</td>';
					html += '<td>'+n.daddress+'</td>';
					html += '<td>'+n.dplace+'</td>';
					html += '</tr>';

				})
				// alert(html);

				$("#driverBody").html(html);

				//计算总页数
				var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;
				//数据处理完毕后，结合分页查询，对前端展现分页信息
				$("#driverPage").bs_pagination({
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
<input type="hidden" id="edit-did">

	<!-- 创建司机的模态窗口 -->
	<div class="modal fade" id="createDriverModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建司机</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="driverAddForm">
					
						<div class="form-group">
							<label for="create-createBy" class="col-sm-2 control-label">创建人<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-createBy">

								</select>
							</div>
							<label for="create-dname" class="col-sm-2 control-label">司机姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-dname">
							</div>
						</div>
						
						<div class="form-group">
                            <label for="create-dage" class="col-sm-2 control-label">年龄</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-dage">
                            </div>
							<label for="create-dphone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-dphone">
							</div>
						</div>
						<div class="form-group">
							<label for="create-daddress" class="col-sm-2 control-label">住址</label>
							<div class="col-sm-10" style="width: 300px;">
							    <input type="text" class="form-control" id="create-daddress">
							</div>
							<label for="create-idNumber" class="col-sm-2 control-label">身份证号</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-idNumber">
							</div>
						</div>
					
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                        <div style="position: relative;top: 15px;">
                            <div class="form-group">
                                <label for="create-dplace" class="col-sm-2 control-label">所属网点</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" id="create-dplace"></textarea>
                                </div>
                            </div>
						                         
                        </div>
						<!-- <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div> -->
						
						
						<div style="position: relative;top: 30px;">
						    <label for="create-driveId" class="col-sm-2 control-label">驾驶证号</label>
						    <div class="col-sm-10" style="width: 300px;">
						        <input type="text" class="form-control" id="create-driveId">
						    </div>
						    <label for="create-stage" class="col-sm-2 control-label">状态</label>
						    <div class="col-sm-10" style="width: 300px;">
						    	<select class="form-control" id="create-stage">

						    	</select>
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
	
	<!-- 修改客户的模态窗口 -->
	<div class="modal fade" id="editDriverModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改客户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-createBy" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-createBy">

								</select>
							</div>
							<label for="edit-dname" class="col-sm-2 control-label">司机名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-dname" >
							</div>
						</div>
						
						<div class="form-group">
                            <label for="edit-dage" class="col-sm-2 control-label">年龄</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-dage" >
                            </div>
							<label for="edit-dphone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-dphone" >
							</div>
						</div>
						<div class="form-group">
							<label for="edit-daddress" class="col-sm-2 control-label">住址</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-daddress">
							</div>
							<label for="edit-idNumber" class="col-sm-2 control-label">身份证号</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-idNumber" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-dplace" class="col-sm-2 control-label">所属网点</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-dplace"></textarea>
							</div>
						</div>
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                        <div style="position: relative;top: 15px;">

                            <div class="form-group">
                                <label for="edit-driveId" class="col-sm-2 control-label">驾驶证号</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" id="edit-driveId">
                                </div>
								<label for="edit-stage" class="col-sm-2 control-label">状态</label>
								<div class="col-sm-10" style="width: 300px;">
									<select class="form-control" id="edit-stage">

									</select>
								</div>
                            </div>
                        </div>

					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateBtn">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>司机列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover" >
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx" /></td>
							<td>姓名</td>
							<td>年龄</td>
							<td>电话</td>
							<td>地址</td>
							<td>司机所属网点</td>
						</tr>
					</thead>
					<tbody id="driverBody">

					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;" id="driverPage">

			</div>
			
		</div>
		
	</div>
</body>
</html>