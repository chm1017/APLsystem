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

	$(function(){
		pageList(1,3);
		//为创建按钮绑定事件，打开添加操作的模态窗口
		$("#addBtn").click(function () {
			$(".time").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "bottom-left"
			});
			//走后台，目的是为了取得用户信息列表，为所有者下拉框铺值
			$.ajax({
				url : "workbench/merchant/getUserList.do",
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
					$("#createMerchantModal").modal("show");
				}
			})
		})
		//为保存按钮绑定事件，执行添加操作
		$("#saveBtn").click(function () {
			$.ajax({
				url : "workbench/merchant/save.do",
				data : {
					"createBy" : $.trim($("#create-createBy").val()),
					"mname" : $.trim($("#create-mname").val()),
					"mage" : $.trim($("#create-mage").val()),
					"madress" : $.trim($("#create-maddress").val()),
					"memail" : $.trim($("#create-memail").val()),
					"mphone" : $.trim($("#create-mphone").val()),
					"company" : $.trim($("#create-company").val()),
					"createDate" : $.trim($("#create-createDate").val()),
					"description" : $.trim($("#create-description").val())
				},
				type : "post",
				dataType : "json",
				success : function (data) {
					if(data.success){
						pageList(1,$("#merchantPage").bs_pagination('getOption', 'rowsPerPage'));
						$("#merchantAddForm")[0].reset();
						//闭添加操作的模态窗口
						$("#createMerchantModal").modal("hide");
					}else{
						alert("添加商户信息失败");
					}
				}
			})
		})

		//为查询按钮绑定事件，触发pageList方法
		$("#searchBtn").click(function () {
			/*
				点击查询按钮的时候，我们应该将搜索框中的信息保存起来,保存到隐藏域中
			 */
			$("#hidden-mname").val($.trim($("#search-mname").val()));
			$("#hidden-mphone").val($.trim($("#search-mphone").val()));
			$("#hidden-maddress").val($.trim($("#search-maddress").val()));
			$("#hidden-description").val($.trim($("#search-description").val()));
			pageList(1,5);

		})

		//为全选的复选框绑定事件，触发全选操作
		$("#qx").click(function () {
			$("input[name=xz]").prop("checked",this.checked);
		})
		$("#merchantBody").on("click",$("input[name=xz]"),function () {
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
					url : "workbench/merhchant/getMerchantById.do",
					data : {
						"mid" : id
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
						$("#edit-mid").val(data.a.mid);
						$("#edit-createBy").val(data.a.createBy);
						//处理单条activity
						$("#edit-mname").val(data.a.mname);
						$("#edit-mage").val(data.a.mage);
						$("#edit-maddress").val(data.a.maddress);
						$("#edit-memail").val(data.a.memail);
						$("#edit-mphone").val(data.a.mphone);
						$("#edit-company").val(data.a.company);
						$("#edit-description").val(data.a.description);
						//所有的值都填写好之后，打开修改操作的模态窗口
						$("#editMerchantModal").modal("show");
					}
				})
			}
		})
		//为保存按钮绑定事件，执行添加操作
		$("#updateBtn").click(function () {
			$.ajax({
				url : "workbench/merchant/update.do",
				data : {
					"mid" : $.trim($("#edit-mid").val()),
					"createBy" : $.trim($("#edit-createBy").val()),
					"mname" : $.trim($("#edit-mname").val()),
					"mage" : $.trim($("#edit-mage").val()),
					"madress" : $.trim($("#edit-maddress").val()),
					"memail" : $.trim($("#edit-memail").val()),
					"mphone" : $.trim($("#edit-mphone").val()),
					"company" : $.trim($("#edit-company").val()),
					"description" : $.trim($("#edit-description").val())
				},
				type : "post",
				dataType : "json",
				success : function (data) {
					if(data.success){
						pageList(1,$("#merchantPage").bs_pagination('getOption', 'rowsPerPage'));
						//关闭添加操作的模态窗口
						$("#editMerchantModal").modal("hide");
					}else{
						alert("修改商户信息失败");
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
						url : "workbench/merchant/delete.do",
						data : param,
						type : "post",
						dataType : "json",
						success : function (data) {
							if(data.success){
								pageList(1,$("#merchantPage").bs_pagination('getOption', 'rowsPerPage'));
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
		// //查询前，将隐藏域中保存的信息取出来，重新赋予到搜索框中
		$("#search-mname").val($.trim($("#hidden-mname").val()));
		$("#search-mphone").val($.trim($("#hidden-mphone").val()));
		$("#search-maddress").val($.trim($("#hidden-maddress").val()));
		$("#search-description").val($.trim($("#hidden-description").val()));
		$.ajax({
			url : "workbench/merchant/pageList.do",
			data : {
				"pageNo" : pageNo,
				"pageSize" : pageSize,
				"mname" : $.trim($("#search-mname").val()),
				"mphone" : $.trim($("#search-mphone").val()),
				"maddress" : $.trim($("#search-maddress").val()),
				"description" : $.trim($("#search-description").val())
			},
			type : "get",
			dataType : "json",
			success : function (data) {
				var html = "";
				//每一个n就是每一个市场活动对象
				$.each(data.dataList,function (i,n) {
					html += '<tr class="active">';
					html += '<td><input type="checkbox" name="xz" value="'+n.mid+'"/></td>';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/merchant/detail.do?id='+n.mid+'\';">'+n.mname+'</a></td>';
					html += '<td>'+n.mphone+'</td>';
					html += '<td>'+n.maddress+'</td>';
					html += '<td>'+n.description+'</td>';
					html += '<td>'+n.createDate+'</td>';
					html += '</tr>';
				})
				$("#merchantBody").html(html);
				//计算总页数
				var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;
				//数据处理完毕后，结合分页查询，对前端展现分页信息
				$("#merchantPage").bs_pagination({
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

<input type="hidden" id="hidden-mname"/>
<input type="hidden" id="hidden-mphone"/>
<input type="hidden" id="hidden-maddress"/>
<input type="hidden" id="hidden-description"/>
<input type="hidden" id="edit-mid"/>
	<!-- 创建商户活动的模态窗口 -->
	<div class="modal fade" id="createMerchantModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建商户</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form" id="merchantAddForm">
					
						<div class="form-group">
							<label for="create-createBy" class="col-sm-2 control-label">创建人<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-createBy">

								</select>
							</div>
                            <label for="create-mname" class="col-sm-2 control-label">商户姓名<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-mname">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-mage" class="col-sm-2 control-label">年龄</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-mage">
							</div>
							<label for="create-maddress" class="col-sm-2 control-label">园区地址</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-maddress">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-memail" class="col-sm-2 control-label">邮件</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-memail">
                            </div>
							<label for="create-mphone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
							    <input type="text" class="form-control" id="create-mphone">
							</div>
                        </div>
						<div class="form-group">
						    <label for="create-company" class="col-sm-2 control-label">公司</label>
						    <div class="col-sm-10" style="width: 300px;">
						        <input type="text" class="form-control" id="create-company">
						    </div>
							<label for="create-createDate" class="col-sm-2 control-label ">创建时间</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-createDate">
							</div>
						</div>
						<div class="form-group">
							<label for="create-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal" >关闭</button>
					<button type="button" class="btn btn-primary" id="saveBtn">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editMerchantModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改商户</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-createBy" class="col-sm-2 control-label">创建者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-createBy">

								</select>
							</div>
                            <label for="edit-mname" class="col-sm-2 control-label">商户姓名<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-mname">
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-mage" class="col-sm-2 control-label">年龄</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mage" >
							</div>
							<label for="edit-maddress" class="col-sm-2 control-label">园区地址</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-maddress" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-memail" class="col-sm-2 control-label">邮件</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-memail" >
							</div>
							<label for="edit-mphone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-company" class="col-sm-2 control-label">公司</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-company">
							</div>
							
						</div>
						
						<div class="form-group">
							<label for="edit-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-description"></textarea>
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
				<h3>商户资料列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">姓名</div>
				      <input class="form-control" type="text" id="search-mname">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">电话</div>
				      <input class="form-control" type="text" id="search-mphone">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">园区地址</div>
					  <input class="form-control" type="text" id="search-maddress" />
				    </div>
				  </div>
				 <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">描述</div>
					  <input class="form-control" type="text" id="search-description">
				    </div>
				  </div>
				  
				  <button type="button" class="btn btn-default" id="searchBtn">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary"  id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editBtn"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteBtn"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx"/></td>
							<td>姓名</td>
                            <td>电话</td>
							<td>园区地址</td>
							<td>描述</td>
							<td>创建时间</td>
						</tr>
					</thead>
					<tbody id="merchantBody">

					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;" id="merchantPage">

			</div>
			
		</div>
		
	</div>
</body>
</html>