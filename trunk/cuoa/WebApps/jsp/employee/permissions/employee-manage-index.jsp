<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>
		<script type="text/javascript">
		
	var grid = null;
	var toolbar = {items : [{ text: '导出', click: excel,icon:'outbox' }]};
	
  	function excel(item) {
        exportData("/py-curriculum/curriculum-finance!exportFinance.action", [0,1]);
    }
  
  
	$(function() {
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/permissions/employeeManage!data.action",
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			toolbar : toolbar,
			checkbox : true,
			rownumbers:false,
			columns : [
						{display : '员工登录名', minWidth:60,  name : 'loginName',isSort:false}, 
						{display : '员工姓名', minWidth:60,  name : 'name',isSort:false}, 
						{display : '编号', minWidth:60,  name : 'serial',isSort:false}, 
						{display : '权限角色', minWidth:60,  name : 'roleName',isSort:false}, 
						{display : '创建人', minWidth:60,  name : 'createrName',isSort:false}, 
						{display : '创建时间', minWidth:60,  name : 'createrDate',isSort:false}, 
						{display : '修改人', minWidth:60,  name : 'modifierName',isSort:false}, 
						{display : '修改时间', minWidth:60,  name : 'modifyDate',isSort:false}, 
						{display : '操作', minWidth:60,  name : '',isSort:false}
					  ]
		};
		grid = showGrid(g);
	});
	function f_search() {
		grid.loadData();
	}
</script>
	</head>
	<body>
			<form id="conditionForm">
			<div class="content">
				<ul>
					<li>
						<label>
							员工登录名
						</label>
						<input type="text" name="condition.loginName" id="loginName" class="input-text" />
					</li>
					<li>
						<label>
							员工姓名
						</label>
						<input type="text" name="condition.name" id="name" class="input-text" />
					</li>
					<li>
						<input type="button" id="queryButton" value="查询" class="l-button" onclick="f_search()"/>
						<input type="reset" id="resetButton" value="重置" class="l-button" />
					</li>
				</ul>
			</div>
				
			</form>
				
			</div>
			<div id="maingrid" class="grid">
			</div>


		<div style="display: none;">

		</div>

	</body>

</html>
