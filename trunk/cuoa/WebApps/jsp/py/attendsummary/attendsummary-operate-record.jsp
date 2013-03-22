<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>
		<script type="text/javascript">
		
	var grid = null;

	$(function() {
		var path = contextPath + "/py-attendsummary/attendSummary!searchRecord.action";
		var g = {
			gridid : "maingrid",
			condition : "condition",
			url : path,
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			checkbox : false,
			rownumbers:true,
			columns : [
	           { display: '考勤生成时时间范围', minWidth:482, name: '',isSort:false,
	        	   render: function(item){
                       	return format_date(item.startDate, "yyyy-MM-dd") + " 至 " + format_date(item.endDate, "yyyy-MM-dd");
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
			</form>
				
			</div>
			<div id="maingrid" class="grid">
			</div>


		<div style="display: none;">

		</div>

	</body>

</html>
