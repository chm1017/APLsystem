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

			pageList(1,5);

			$(".time").datetimepicker({
				minView: "month",
				language:  'zh-CN',
				format: 'yyyy-mm-dd',
				autoclose: true,
				todayBtn: true,
				pickerPosition: "bottom-left"
			});


			$.ajax({
				url : "workbench/product/getMerchantList.do",
				type : "get",
				dataType : "json",
				success : function (data) {
					var html = "<option></option>";
					//遍历出来的每一个n，就是每一个user对象
					$.each(data,function (i,n) {

						html += "<option value='"+n.mid+"'>"+n.mname+"</option>";

					})
					$("#create-merchant").html(html);
					$("#search-selectMerchant").html(html);

					//取得当前登录用户的id
					//在js中使用el表达式，el表达式一定要套用在字符串中
					<%--var id = "${user.id}";--%>
					<%--$("#create-createBy").val(id);--%>
					//所有者下拉框处理完毕后，展现模态窗口
				}
			})

			//为创建按钮绑定事件，打开添加操作的模态窗口
			$("#addBtn").click(function () {



				//走后台，目的是为了取得用户信息列表，为所有者下拉框铺值
				$.ajax({
					url : "workbench/product/getUserList.do",
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
						$("#createProjectModal").modal("show");

					}
				})
			})
			//为保存按钮绑定事件，执行添加操作
			$("#saveBtn").click(function () {

				$.ajax({

					url : "workbench/project/save.do",
					data : {

						"createBy" : $.trim($("#create-createBy").val()),
						"pname" : $.trim($("#create-pname").val()),
						"createDate" : $.trim($("#create-createDate").val()),
						"endDate" : $.trim($("#create-endDate").val()),
						"paddress" : $.trim($("#create-paddress").val()),
						"price" : $.trim($("#create-price").val()),
						"number" : $.trim($("#create-number").val()),
						"mid" : $.trim($("#create-merchant").val()),
						"description" : $.trim($("#create-description").val())

					},
					type : "post",
					dataType : "json",
					success : function (data) {
						if(data.success){

							pageList(1,$("#productPage").bs_pagination('getOption', 'rowsPerPage'));

							$("#projectAddForm")[0].reset();

							//关闭添加操作的模态窗口
							$("#createProjectModal").modal("hide");
							// alert("添加陈工")


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
			$("#hidden-pname").val($.trim($("#search-pname").val()));
			$("#hidden-paddress").val($.trim($("#search-paddress").val()));
			$("#hidden-selectMerchant").val($.trim($("#search-selectMerchant").val()));
			$("#hidden-createDate").val($.trim($("#search-createDate").val()));
			$("#hidden-endDate").val($.trim($("#search-endDate").val()));

			pageList(1,5);

		})



		//为全选的复选框绑定事件，触发全选操作
		$("#qx").click(function () {

			$("input[name=xz]").prop("checked",this.checked);

		})
		$("#productBody").on("click",$("input[name=xz]"),function () {

			$("#qx").prop("checked",$("input[name=xz]").length==$("input[name=xz]:checked").length);

		})


		
	});


	function pageList(pageNo,pageSize) {

		//将全选的复选框的√干掉
		$("#qx").prop("checked",false);

		// //查询前，将隐藏域中保存的信息取出来，重新赋予到搜索框中
		$("#search-pname").val($.trim($("#hidden-pname").val()));
		$("#search-paddress").val($.trim($("#hidden-paddress").val()));
		$("#search-selectMerchant").val($.trim($("#hidden-selectMerchant").val()));
		$("#search-createDate").val($.trim($("#hidden-createDate").val()));
		$("#search-endDate").val($.trim($("#hidden-endDate").val()));

		$.ajax({

			url : "workbench/product/pageList.do",
			data : {

				"pageNo" : pageNo,
				"pageSize" : pageSize,
				"pname" : $.trim($("#search-pname").val()),
				"paddress" : $.trim($("#search-paddress").val()),
				"mid" : $.trim($("#search-selectMerchant").val()),
				"createDate" : $.trim($("#search-createDate").val()),
				"endDate" : $.trim($("#search-endDate").val())
			},
			type : "get",
			dataType : "json",
			success : function (data) {

				var html = "";
				//每一个n就是每一个市场活动对象
				$.each(data.dataList,function (i,n) {
					html += '<tr class="active">';
					html += '<td><input type="checkbox" name="xz" value="'+n.pid+'"/></td>';
					html += '<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href=\'workbench/activity/detail.do?id='+n.mid+'\';">'+n.pname+'</a></td>';
					html += '<td>'+n.paddress+'</td>';
					html += '<td>'+n.mid+'</td>';
					html += '<td>'+n.createDate+'</td>';
					html += '<td>'+n.endDate+'</td>';
					html += '<td>'+n.number+'</td>';
					html += '<td>'+n.price+'</td>';
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

<input type="hidden" id="hidden-pname"/>
<input type="hidden" id="hidden-paddress"/>
<input type="hidden" id="hidden-selectMerchant"/>
<input type="hidden" id="hidden-createDate"/>
<input type="hidden" id="hidden-endDate"/>


	<!-- 创建农产品的模态窗口 -->
	<div class="modal fade" id="createProjectModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">添加产品</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="projectAddForm">
					
						<div class="form-group">
							<label for="create-createBy" class="col-sm-2 control-label">创建人<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-createBy">

								</select>
							</div>
							<label for="create-pname" class="col-sm-2 control-label">产品名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-pname">
							</div>
						</div>
						
						
						<div class="form-group">
							<label for="create-createDate" class="col-sm-2 control-label">生产日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-createDate">
							</div>
							<label for="create-endDate" class="col-sm-2 control-label">有效期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-endDate">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-paddress" class="col-sm-2 control-label">生产园区</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-paddress">
							</div>
							<label for="create-price" class="col-sm-2 control-label">售价</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-price">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-number" class="col-sm-2 control-label">添加数量</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-number">
							</div>
							<label for="create-merchant" class="col-sm-2 control-label">所属商户</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-merchant">

								</select>
							</div>
						</div>					
					
						<div class="form-group">
							<label for="create-description" class="col-sm-2 control-label">产品描述</label>
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
	
	<!-- 修改线索的模态窗口 -->
	<div class="modal fade" id="editClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改线索</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-clueOwner">
								  <option>zhangsan</option>
								  <option>lisi</option>
								  <option>wangwu</option>
								</select>
							</div>
							<label for="edit-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-company" value="动力节点">
							</div>
						</div>
						
						<div class="form-group">
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
							<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-surname" value="李四">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job" value="CTO">
							</div>
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email" value="lisi@bjpowernode.com">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone" value="010-84846003">
							</div>
							<label for="edit-website" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-website" value="http://www.bjpowernode.com">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone" value="12345678901">
							</div>
							<label for="edit-status" class="col-sm-2 control-label">线索状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-status">
								  <option></option>
								  <option>试图联系</option>
								  <option>将来联系</option>
								  <option selected>已联系</option>
								  <option>虚假线索</option>
								  <option>丢失线索</option>
								  <option>未联系</option>
								  <option>需要条件</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-source" class="col-sm-2 control-label">线索来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-source">
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
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe">这是一条线索的描述信息</textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-contactSummary">这个线索即将被转换</textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-nextContactTime" value="2017-05-01">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address">北京大兴区大族企业湾</textarea>
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
				<h3>产品列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">产品名称</div>
				      <input class="form-control" type="text" id="search-pname">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">生产园区</div>
				      <input class="form-control" type="text" id="search-paddress">
				    </div>
				  </div>
				  


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所属商户</div>
					  <select class="form-control" id="search-selectMerchant">

					  </select>
				    </div>
				  </div>

					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">生产日期</div>
							<input class="form-control time" type="text" id="search-createDate">
						</div>
					</div>

					<div class="form-group">
						<div class="input-group">
							<div class="input-group-addon">结束日期</div>
							<input class="form-control time" type="text" id="search-endDate">
						</div>
					</div>



				  <button type="button" class="btn btn-default" id="searchBtn">查询</button>
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" id="addBtn"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" data-toggle="modal" data-target="#editClueModal"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 50px;">
				<table class="table table-hover">
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
						</tr>
					</thead>
					<tbody id="productBody">

					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 60px;" id="productPage">

			</div>
			
		</div>
		
	</div>
</body>
</html>