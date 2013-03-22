<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
<script src="<%=contextPath %>/ligerui/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
<script src="<%=contextPath %>/js/class.js" type="text/javascript"></script>
    <script type="text/javascript">

	var grid = null;

	$(function() {
	
		var path = contextPath +"<s:property value='#parameters.importAction'/>" ;
		var g = {
			gridid : "importLogMaingrid",
			condition : "importLogCondition",
			url : path,
			formid:"importLogConditionForm",
			frozen: true,
			showToggleColBtn: false,
			checkbox : false,
			rownumbers:false,
			columns : [
			  	{ display : '记录',minWidth:100, name : 'content',isSort:false},
		        { display : '操作人',minWidth:50, name : 'createName',isSort:false}
			  ]
		};
		grid = showGrid_top(g);
	});


	function f_search() {
		grid.loadData();
	}

    </script>
</head>

<body>
 <form id="importLogConditionForm">
 	<div class="content">
 				<ul>
 					<li>
						<label>
							导入时间
						</label>
						<input id="importTime_start" name="importLogCondition.importTimeStart" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'importTime_start'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							至
						</label>
						<input id="importTime_end" name="importLogCondition.importTimeEnd" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'importTime_end'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							记录人
						</label>
						<input type="text" name="importLogCondition.importName" id="teacher" class="input-text" />
					</li>
					<li>
						<input type="button" id="queryButton" value="查询" class="l-button" onclick="f_search()"/>
					</li>
				</ul>
 	</div>
 </form>
    
    <div id="importLogMaingrid" class="grid">
	</div>
</body>
</html>