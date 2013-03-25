<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>
		<script type="text/javascript">
		
	var grid = null;

	$(function() {
		var path = contextPath + "/py-attendsummary/attendSummary!searchRange.action";
		var g = {
			gridid : "maingrid",
			condition : "condition",
			url : path,
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			checkbox : false,
			rownumbers:false,
			columns : [{ display: "操作", minWidth:50, name: "id",
	         		render: function(item){
	         			var html = "";
	         			if (item.isOperate != 1) {
	                    	html = html + "<a href='javascript:f_edit(\""+item.id+"\", 0)' class='linkbutton'>修改</a>";
	         			}
	                    return html;
	               }
	           },
	           { display: '考勤年月',minWidth:92, name: 'verifyYearMonth',isSort:false},
	           { display: '考勤开始日期', minWidth:151, name: '',isSort:false,
	        	   render: function(item){
                       	return format_date(item.startDate, "yyyy-MM-dd");
                   }
	           },
	           { display: '考勤结束日期', minWidth:151, name: '',isSort:false,
	        	   render: function(item){
                       	return format_date(item.endDate, "yyyy-MM-dd");
                   }
	           }
			  ]
		};
		grid = showGrid(g);
	});
	function f_search() {
		grid.loadData();
	}
	
	function f_edit(id, operate) {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-attendsummary/attendSummary!toEditRange.action?range.id=" + id,
	    	width: 380,
	    	height: 310,
	    	title: operate == 0 ? "更改月考勤时间段" : "新增月考勤时间段"
	    });
	}
	
</script>
	</head>
	</head>
	<body>
			<form id="conditionForm">
			<div class="content">
				<ul>
					<li>
						<input type="button" id="queryButton" value="新增" class="l-button" onclick="f_edit('', 1)"/>
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
