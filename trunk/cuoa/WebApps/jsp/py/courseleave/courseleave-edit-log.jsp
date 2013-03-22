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
			url : contextPath + "/py-courseleave/courseleave!queryLeaveLog.action",
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			checkbox : false,
			rownumbers:false,
			columns : [
			           {display : '确认年月', minWidth:60,  name : 'verifyYearMonth',isSort:false}, 
			           { display: '分校',minWidth:60, name: 'cityName',isSort:false},
 					   { display: '系统姓名',minWidth:60, name: 'leaveTeacherName',isSort:false},
			           { display : '教师姓名',minWidth:60, name : 'leaveTeacherName',isSort:false},
			           { display : '教师编号',minWidth:60, name : 'leaveTeacherCode',isSort:false},				       { display : '班主任',minWidth:60, name : 'headteacherName',isSort:false},
				       { display : '学期',minWidth:60, name : 'termName',isSort:false},
				       { display : '年部', minWidth:60,name : 'gtName',isSort:false},
				       { display : '年级', minWidth:80,name : 'gradeName',isSort:false},
				       { display : '学科', minWidth:60,name : 'subjectNames',isSort:false},
				       { display : '班次', minWidth:100, name : 'classlevelName',isSort:false},
				       { display : '班级名称',minWidth:150, name : 'courseName',isSort:false},
				       { display : '开班日期',minWidth:80, name : 'createTime',isSort:false},
				       { display : '开课日期', minWidth:80,name : 'startDate',isSort:false},
				       { display : '结课日期', minWidth:80,name : 'endDate',isSort:false},
				       { display : '总课次', minWidth:60,name : 'lessonCount',isSort:false},
				       { display : '已上课次',minWidth:60, name : 'passedLessonCount',isSort:false},
				       { display : '剩余课次',minWidth:60, name : 'remainCount',isSort:false},
				       { display : '限额人数', minWidth:60,name : 'limitNumberOfStudent',isSort:false},
				       { display : '地区', minWidth:100,name : 'areaName',isSort:false},
				       { display : '服务中心', minWidth:100,name : 'servicecenterName',isSort:false},
				       { display : '教学点', minWidth:100,name : 'venueName',isSort:false},
				       { display : '教室', minWidth:100,name : 'classroomName',isSort:false},
				       { display : '上课日期', minWidth:80,name : 'createTime',isSort:false},
				       { display : '上课时间', minWidth:80,name : 'courseTime',isSort:false},
						{ display : '课时', minWidth:60,name : 'hours',isSort:false},
						{ display : '缺勤课次',minWidth:60, name : 'lessonNo',isSort:false},
						{ display : '缺勤日期',minWidth:80, name : 'leaveDate',isSort:false},
						{ display : '请假时间',minWidth:120, name : 'dateOfAskForLeave',isSort:false},
						{ display : '请假类型',minWidth:100, name : 'typeStr',isSort:false},
						{ display : '请假原因',minWidth:120, name : 'reason',isSort:false},
						{ display : '替课老师',minWidth:60, name : 'replaceTeacherName',isSort:false},
						{ display : '班级组备注',minWidth:80, name : 'remarkStr',isSort:false},
				         { display : '修改原因',minWidth:120, name : 'reasonForModify',isSort:false},
				         { display : '请假原因分类',minWidth:150, name : 'sortOfReasonName',isSort:false},
				         { display : '具体原因分类',minWidth:150, name : 'specificSortOfReasonName',isSort:false},
				         { display : '缺勤次数',minWidth:60, name : 'remark',isSort:false},
				         { display : '本学期请假次数',minWidth:120, name : 'leaveTimesOfTerm',isSort:false},
				         { display : '另扣课时',minWidth:60, name : 'deductHours',isSort:false},
				         { display : '扣课时规则',minWidth:120, name : 'deductRule',isSort:false},
				         { display : '最终扣课时',minWidth:60, name : 'finalDeductHours',isSort:false},
				         { display : '修正原因',minWidth:120, name : 'reasonForRevise',isSort:false},
				         { display : '是否为班主任',minWidth:80, name : 'isHeadTeacherStr',isSort:false},
				         { display : '是否取消全勤',minWidth:130, name : 'isCancelPerfectAttendanceStr',isSort:false},
				         { display : '状态',minWidth:80, name : 'statusStr',isSort:false},
				         { display : '课时修正人',minWidth:120, name : 'reviseEmployeeName',isSort:false},
				         { display : '修改操作人',minWidth:120, name : 'modifierName',isSort:false},
				         { display : '审核人',minWidth:120, name : 'auditorName',isSort:false},
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
				<input  type="hidden" name="leaveLogCondition.leaveId" value="<s:property value='leaveLogCondition.leaveId'/>" />
			</form>
				
			</div>
			<div id="maingrid" class="grid">
			</div>


		<div style="display: none;">

		</div>

	</body>

</html>
