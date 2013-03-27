<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>
		<script type="text/javascript">
		
	var grid = null;
	var toolbar = {items : [{ text: '导出', click: excel,icon:'outbox' },
	                        { text: '新增', click: add,icon:'add' }]};
	
  	function excel(item) {
        exportData("/py-curriculum/curriculum-finance!exportFinance.action", [0,1]);
    }
  
  	function add() {
  		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/permissions/permissionManage!toAddRoleIndex.action",
	    	width: 360,
	    	height: 160,
	    	title: "编辑角色信息",
	    	buttons : [ {
				text : "确定",
				onclick : function(item, dialog) {
				if(typeof dialog.frame.f_submit != 'undefined')
					dialog.frame.f_submit();
				}
			}, {
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
	    });
  	}
  
	$(function() {
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/permissions/permissionManage!data.action",
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			toolbar : toolbar,
			checkbox : true,
			rownumbers:false,
			columns : [
						{display : '角色名', minWidth:60,  name : 'name',isSort:false}, 
						{display : '创建人', minWidth:60,  name : 'createrName',isSort:false}, 
						{display : '创建时间', minWidth:60,  name : 'createDate',isSort:false}, 
						{display : '修改人', minWidth:60,  name : 'modifierName',isSort:false}, 
						{display : '修改时间', minWidth:60,  name : 'modifyDate',isSort:false}, 
						{display : '操作', minWidth:60,  name : 'createrDate',isSort:false,
							render: function(item){
				    		   var html = "";
				    		   if (item.id != "0") {
				    			   html = html + "<a href='javascript:modifyRole(\"" + item.id + "\")' class='linkbutton'>编辑</a>";
				    			   html = html + "<a href='javascript:modifyRolePermission(\"" + item.id + "\")' class='linkbutton'>权限设置</a>";
				    		   }
				    		   return html;
					    	}	
						}
					  ]
		};
		grid = showGrid(g);
	});
	function f_search() {
		grid.loadData();
	}
	
	var modifyRole = function(roleId) {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/permissions/permissionManage!toModifyRoleIndex.action?role.id=" + roleId,
	    	width: 360,
	    	height: 160,
	    	title: "编辑角色信息",
	    	buttons : [ {
				text : "确定",
				onclick : function(item, dialog) {
				if(typeof dialog.frame.f_submit != 'undefined')
					dialog.frame.f_submit();
				}
			}, {
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
	    });
	};

	var modifyRolePermission = function(roleId) {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/permissions/permissionManage!toResourceTree.action?role.id=" + roleId,
	    	width: 850,
	    	height: 550,
	    	title: "权限设置",
	    	buttons : [ {
				text : "确定",
				onclick : function(item, dialog) {
				if(typeof dialog.frame.modifyPermission != 'undefined')
					dialog.frame.modifyPermission();
				}
			}, {
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
	    });
	};
</script>
	</head>
	<body>
			<form id="conditionForm">
			<div class="content">
				<ul>
					<li>
						<label>
							角色名
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
