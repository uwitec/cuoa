<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>
		<script type="text/javascript">
		
	var grid = null;
	$(function() {
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/py-crossarea/crossarea!queryCrossAreaLog.action",
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			checkbox : false,
			rownumbers:true,
			columns : [
			           {display : '确认年月', minWidth:60,  name : 'verifyYearMonth',isSort:false}, 
			           { display: '分校',minWidth:60, name: 'cityName',isSort:false},
			           { display : '班级名称',minWidth:60, name : 'courseName',isSort:false},
			           { display : '班主任',minWidth:60, name : 'headteacherName',isSort:false},
				       { display : '学期',minWidth:60, name : 'termName',isSort:false},
				       { display : '年部', minWidth:60,name : 'gtName',isSort:false},
				       { display : '年级', minWidth:60,name : 'gradeName',isSort:false},
				       { display : '学科', minWidth:60,name : 'subjectNames',isSort:false},
				       { display : '班次', minWidth:60, name : 'classlevelName',isSort:false},
			           
				       { display : '地区', minWidth:60,name : 'areaName',isSort:false},
				       { display : '服务中心', minWidth:60,name : 'servicecenterName',isSort:false},
				       { display : '教学点', minWidth:60,name : 'venueName',isSort:false},
				       { display : '教室', minWidth:60,name : 'classroomName',isSort:false},
				       
				       { display : '教师',minWidth:60, name: 'teacherNames',isSort:false},
				       { display : '班主任',minWidth:60, name : 'headteacherName',isSort:false},
			       		{ display : '上课日期', minWidth:80,name : 'courseDate',isSort:false},
				       { display : '上课时间',minWidth:80, name : 'courseTime',isSort:false},
				       { display : '开课日期', minWidth:60,name : 'startDate',isSort:false},
				       { display : '结课日期', minWidth:60,name : 'endDate',isSort:false},
				       
				       { display : '课次', minWidth:60,name : 'lessonNo',isSort:false},
						
				       { display : '跨点原因', minWidth:60,name : 'reasonForCross',isSort:false},
				       { display : '通知教学点', minWidth:60,name : 'ifNoticeToVenueStr',isSort:false},
				       { display : '通知督查', minWidth:60,name : 'ifNoticeToSuperviseStr',isSort:false},
				       { display : '记录人', minWidth:60,name : 'recorderName',isSort:false},
				       { display : '是否为班主任', minWidth:100,name : 'isHeadTeacherStr',isSort:false},
				       { display : '备注', minWidth:60,name : 'remark',isSort:false},
				        { display : '修改原因',minWidth:60, name : 'reasonForModify',isSort:false},	       
				        { display : '修改操作人',minWidth:60, name : 'modifierName',isSort:false},
				        { display : '是否作废',minWidth:60, name : 'isDeletedStr',isSort:false}
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
				<input  type="hidden" name="crossAreaLogCondition.crossAreaId" value="<s:property value='crossAreaLogCondition.crossAreaId'/>" />
			</form>
				
			</div>
			<div id="maingrid" class="grid">
			</div>


		<div style="display: none;">

		</div>

	</body>

</html>
