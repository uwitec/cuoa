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
			url : contextPath + "/py-meeting/meeting!queryMeetingLog.action?id="+"<s:property value='meetingLogCondition.meetingId'/>",
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			checkbox : false,
			rownumbers:false,
			columns : [
						{display : '确认年月', minWidth:60,  name : 'verifyYearMonth',isSort:false}, 
						{ display : '学期',minWidth:60, name : 'termName',isSort:false},
						{ display : '年部', minWidth:60,name : 'gtName',isSort:false},
						{ display : '年级', minWidth:60,name : 'gradeName',isSort:false},
						{ display : '学科', minWidth:60,name : 'subjectName',isSort:false},
						{ display : '老师名称',minWidth:60, name : 'teacherName',isSort:false},
						{ display : '会议名称',minWidth:60, name : 'meetingName',isSort:false},
						{ display : '会议日期', minWidth:60,name : 'startDate',isSort:false},
						{ display : '补看录像截止日期', minWidth:100,name : 'reviewVideoDeadline',isSort:false},
						{ display : '例会缺勤原因', minWidth:100,name : 'reasonForAbsence',isSort:false},
						{ display : '未补看录像原因', minWidth:100,name : 'reasonForNoReview',isSort:false},
						{ display : '班级组备注',minWidth:60, name : 'remarkStr',isSort:false},
						{ display : '缺勤次数', minWidth:60,name : 'remark',isSort:false},
						{ display : '另扣课时',minWidth:60, name : 'deductHours',isSort:false},
						{ display : '扣课时规则',minWidth:60, name : 'deductRule',isSort:false},
						{ display : '最终扣课时',minWidth:60, name : 'finalDeductHours',isSort:false},
						{ display : '修正原因',minWidth:60, name : 'reasonForRevise',isSort:false},
						{ display : '课时修正人',minWidth:60, name : 'reviseEmployeeName',isSort:false},
						{ display : '修改原因',minWidth:60, name : 'reasonForNoReview',isSort:false},
						{ display : '修改操作人',minWidth:60, name : 'modifierName',isSort:false},
						{ display : '状态',minWidth:60, name : 'statusStr',isSort:false},
						{ display : '审核人',minWidth:60, name : 'auditorName',isSort:false},      
				        { display : '是否取消全勤',minWidth:150, name : 'isCancelPerfectAttendanceStr',isSort:false},
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
			</form>
				<input type="hidden" name="meetingLogCondition.meetingId" value="<s:property value='meetingLogCondition.meetingId'/>" />
			</div>
			<div id="maingrid" class="grid">
			</div>


		<div style="display: none;">

		</div>

	</body>

</html>
