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
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<link rel="stylesheet" type="text/css" href="jquery/bs_pagination/jquery.bs_pagination.min.css">
	<script type="text/javascript" src="jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script type="text/javascript" src="jquery/bs_pagination/en.js"></script>

<script type="text/javascript">

	$(function(){

		pageList(1,3)
		$.ajax({
			url : "workbench/car/getDriverList.do",
			type : "get",
			dataType : "json",
			success : function (data) {
				var html = "<option></option>";
				//遍历出来的每一个n，就是每一个user对象
				$.each(data,function (i,n) {
					html += "<option value='"+n.did+"'>"+n.dname+"</option>";
				})
				$("#create-driver").html(html);
			}
		})

		
		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });
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
					$("#createCarModal").modal("show");

				}
			})
		})
		//为保存按钮绑定事件，执行添加操作
		$("#saveBtn").click(function () {

			$.ajax({

				url : "workbench/car/save.do",
				data : {

					"createBy" : $.trim($("#create-createBy").val()),
					"plateNo" : $.trim($("#create-plateNo").val()),
					"stage" : $.trim($("#create-stage").val()),
					"cplace" : $.trim($("#create-cplace").val()),
					"company" : $.trim($("#create-company").val()),
					"cload" : $.trim($("#create-cload").val()),
					"fdjId" : $.trim($("#create-fdjId").val()),
					"baoxianId" : $.trim($("#create-baoxianId").val()),
					"description" : $.trim($("#create-description").val()),
					"cname": $.trim($("#create-cname").val()),
					"did": $.trim($("#create-driver").val()),

				},
				type : "post",
				dataType : "json",
				success : function (data) {
					if(data.success){

						pageList(1,$("#carPage").bs_pagination('getOption', 'rowsPerPage'));

						$("#carAddForm")[0].reset();

						//关闭添加操作的模态窗口
						$("#createCarModal").modal("hide");
						// alert("添加陈工")

					}else{
						alert("添加商户信息失败");
					}

				}
			})

		})
		$("#qx").click(function () {

			$("input[name=xz]").prop("checked",this.checked);

		})
		$("#carBody").on("click",$("input[name=xz]"),function () {

			$("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);

		})
		
	});
	function pageList(pageNo,pageSize) {

		//将全选的复选框的√干掉
		$("#qx").prop("checked",false);

		$.ajax({

			url : "workbench/car/pageList.do",
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
					html += '<td><input type="checkbox" name="xz" value="'+n.cid+'"/></td>';
					html += '<td>'+n.plateNo+'</td>';
					html += '<td>'+n.cname+'</td>';
					html += '<td>'+n.did+'</td>';
					html += '<td>'+n.cplace+'</td>';
					html += '<td>'+n.cload+'</td>';
					html += '<td>'+n.baoxianId+'</td>';
					html += '<td>'+n.stage+'</td>';
					html += '</tr>';

				})
				// alert(html);

				$("#carBody").html(html);

				//计算总页数
				var totalPages = data.total%pageSize==0?data.total/pageSize:parseInt(data.total/pageSize)+1;
				//数据处理完毕后，结合分页查询，对前端展现分页信息
				$("#carPage").bs_pagination({
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

	
	<!-- 创建车辆的模态窗口 -->
	<div class="modal fade" id="createCarModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabelx">新添车辆信息</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="carAddForm">
					
						<div class="form-group">
							<label for="create-createBy" class="col-sm-2 control-label">创建人<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-createBy">

								</select>
							</div>
							<label for="create-plateNo" class="col-sm-2 control-label">车牌号</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-plateNo">
							</div>
						</div>

						<div class="form-group">
							<label for="create-cname" class="col-sm-2 control-label">车辆名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-cname">
							</div>
							<label for="create-driver" class="col-sm-2 control-label">司机</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-driver">

								</select>
							</div>

						</div>

						<div class="form-group">
							<label for="create-stage" class="col-sm-2 control-label">车辆状态<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-stage">
								  <option></option>
								  <option>广告</option>
								  <option>推销电话</option>
								  <option>员工介绍</option>
								</select>
							</div>
							
							<label for="create-cplace" class="col-sm-2 control-label">所属网点</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-cplace">
								  <option></option>
								  <option>先生</option>
								  <option>夫人</option>
								  <option>女士</option>
								  <option>博士</option>
								  <option>教授</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-company" class="col-sm-2 control-label">所属单位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-company">
							</div>

							<label for="create-baoxianId" class="col-sm-2 control-label">保险卡号</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-baoxianId">
							</div>

						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-cload" class="col-sm-2 control-label">核定载重</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-cload">
							</div>
							<label for="create-fdjId" class="col-sm-2 control-label">发动机号</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-fdjId">
							</div>
						</div>


						
						<div class="form-group" style="position: relative;">
							<label for="create-description" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-description"></textarea>
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
	
	<!-- 修改车辆的模态窗口 -->
	<div class="modal fade" id="editContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">修改联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-contactsOwner">
								  <option selected>zhangsan</option>
								  <option>lisi</option>
								  <option>wangwu</option>
								</select>
							</div>
							<label for="edit-clueSource1" class="col-sm-2 control-label">来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-clueSource1">
								  <option></option>
								  <option selected>广告</option>
								  <option>推销电话</option>
								  <option>员工介绍</option>
								  <option>外部介绍</option>
								  <option>在线商场</option>
								  <option>合作伙伴</option>
								  <option>公开媒介</option>
								  <option>销售邮件</option>
								  <option>合作伙伴研讨会</option>
								  <option>内部研讨会</option>
								  <option>交易会</option>
								  <option>web下载</option>
								  <option>web调研</option>
								  <option>聊天</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-surname" value="李四">
							</div>
							<label for="edit-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-call">
								  <option></option>
								  <option selected>先生</option>
								  <option>夫人</option>
								  <option>女士</option>
								  <option>博士</option>
								  <option>教授</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job" value="CTO">
							</div>
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone" value="12345678901">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email" value="lisi@bjpowernode.com">
							</div>
							<label for="edit-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-birth">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-customerName" placeholder="支持自动补全，输入客户不存在则新建" value="动力节点">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe">这是一条线索的描述信息</textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-nextContactTime">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address2" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address2">北京大兴区大族企业湾</textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>车辆列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">

			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editContactsModal"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 20px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="qx"/></td>
							<td>车牌号</td>
							<td>车辆名称</td>
							<td>司机</td>
							<td>所属网点</td>
							<td>核定载重</td>
							<td>保险卡号</td>
							<td>车辆状态</td>
						</tr>
					</thead>
					<tbody id="carBody">

					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 10px;" id="carPage">


			</div>
			
		</div>
		
	</div>
</body>
</html>