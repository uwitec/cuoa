<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
<script src="<%=contextPath %>/ligerui/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
<script src="<%=contextPath %>/js/class.js" type="text/javascript"></script>
    <script type="text/javascript">

	var grid = null;

	$(function() {
		var path = contextPath + "<s:property value='#parameters.reviseLogAction'/> ";
		var g = {
			gridid : "deductMaingrid",
			condition : "queryDeductLessonLogCondition",
			url : path,
			formid:"deductConditionForm",
			frozen: true,
			showToggleColBtn: false,
			checkbox : false,
			rownumbers:false,
			columns : [
			  	{ display : '修正扣课时',minWidth:100, name : 'finalDeductHours',isSort:false},
		        { display : '修正原因',minWidth:50, name : 'reasonForRevise',isSort:false},
		        { display : '修正人', minWidth:40,name : 'reviseEmployeeName',isSort:false},      
		        { display : '修正时间', minWidth:40,name : 'reviseEmployeeDate',isSort:false}  
			  ]
		};
		grid = showGrid_top(g);
	});


    </script>
</head>

<body>
 <form id="deductConditionForm">
 	<input type="hidden" name="queryDeductLessonLogCondition.deductId" value="<s:property value='#parameters.deductId'/>"> 

    </form>
    
    <div id="deductMaingrid" class="grid">
	</div>
</body>
</html>