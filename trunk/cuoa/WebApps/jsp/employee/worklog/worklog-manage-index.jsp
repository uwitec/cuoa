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
			url : contextPath + "/worklog/worklogManage!data.action",
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			toolbar : toolbar,
			checkbox : true,
			rownumbers:false,
			columns : [
						{display : '员工姓名', minWidth:60,  name : 'employeeName',isSort:false}, 
						{display : '日志日期', minWidth:60,  name : 'logDate',isSort:false}, 
						{display : '日志标题', minWidth:60,  name : 'caption',isSort:false}, 
						{display : '创建人', minWidth:60,  name : 'createrName',isSort:false}, 
						{display : '创建时间', minWidth:60,  name : 'createrDate',isSort:false}, 
						{display : '操作', minWidth:60,  name : '',isSort:false,
							render: function(item){
				    		   var html = "";
			    			   html = html + "<a href='javascript:modifyRole(\"" + item.id + "\")' class='linkbutton'>编辑</a>";
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
</script>
	</head>
	<body>
			<form id="conditionForm">
			<div class="content">
				<ul>
					<li>
						<label>
							日志标题
						</label>
						<input type="text" name="condition.caption" id="caption" class="input-text" />
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
