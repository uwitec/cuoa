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
        exportData("/py-attendsummary/attendSummary!export.action", [0]);
    }

	$(function() {
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/py-attendsummary/attendSummary!data.action",
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			toolbar : toolbar,
			checkbox : true,
			rownumbers:false,
			columns : [{ display : '确认年月', minWidth:60,  name : 'verifyYearMonth',isSort:false},
			           { display : '教师姓名',minWidth:60, name : 'realName',isSort:false},
			           { display : '教师系统姓名',minWidth:85, name : 'teacherName',isSort:false},
			           { display : '教师编号',minWidth:60, name : 'teacherCode',isSort:false},
				       { display : '班主任',minWidth:60, name : 'headteacherName',isSort:false},
				       { display : '班级名称',minWidth:150, name : 'courseName',isSort:false,
				    	   render: function(item){
				    		   var html = "";
				    		   html = html + "<a href='javascript:queryClassDetails(\""+item.courseId+"\")' class='linkbutton'>"+item.courseName+"</a>";
				    		   return html;
				    	   }
				       },
			           { display : '学期',minWidth:60, name : 'termName',isSort:false},
				       { display : '年部', minWidth:60,name : 'gtName',isSort:false},
				       { display : '年级', minWidth:60,name : 'gradeName',isSort:false},
				       { display : '学科', minWidth:60,name : 'subjectNames',isSort:false},
				       { display : '班次', minWidth:60, name : 'classlevelName',isSort:false},
				       { display : '地区', minWidth:60,name : 'areaName',isSort:false},
				       { display : '服务中心', minWidth:60,name : 'servicecenterName',isSort:false},
				       { display : '教学点', minWidth:60,name : 'venueName',isSort:false},
				       { display : '教室', minWidth:60,name : 'classroomName',isSort:false},
				       { display : '上课时间', minWidth:60,name : 'courseTimeNames',isSort:false},
					   { display : '课时', minWidth:60,name : 'hours',isSort:false},
					   { display : '开班日期', minWidth:60,name : 'createTime',isSort:false},
				       { display : '开课日期', minWidth:60,name : 'startDate',isSort:false},
				       { display : '结课日期', minWidth:60,name : 'endDate',isSort:false},
				       { display : '总课次', minWidth:60,name : 'lessonCount',isSort:false},
				       { display : '已上课次', minWidth:60,name : 'passedLessonCount',isSort:false},
				       { display : '剩余课次', minWidth:60,name : 'remainCount',isSort:false},
				       { display : '限额人数', minWidth:60,name : 'limitNumberOfStudent',isSort:false},
				       { display : '结课人数', minWidth:60,name : 'finishNumberOfStudent',isSort:false},
					   { display : '所结课次', minWidth:60,name : 'summaryCourseNumbers',isSort:false},
					   { display : '所结课次数量', minWidth:85,name : 'summaryCourseNumbersCount',isSort:false},
					   { display : '代课次数', minWidth:60,name : 'replaceTimes',isSort:false},
					   { display : '上课课时', minWidth:60,name : 'courseHours',isSort:false},
					   { display : '请假次数', minWidth:60,name : 'leaveTimes',isSort:false},
					   { display : '请假另扣课时', minWidth:85,name : 'deductHoursForLeave',isSort:false},
					   { display : '例会缺勤次数', minWidth:85,name : 'meetingAbsenceTimes',isSort:false},
					   { display : '例会应扣课时', minWidth:85,name : 'deductHoursForMeetingAbsence',isSort:false},
					   { display : '课前迟到', minWidth:60,name : 'lateTimesBeforeLesson',isSort:false},
					   { display : '课后迟到', minWidth:60,name : 'lateTimesAfterLesson',isSort:false},
					   { display : '迟到应扣课时', minWidth:85,name : 'deductHoursForLate',isSort:false},
					   { display : '本学期迟到次数', minWidth:100,name : 'lateTimesThisTerm',isSort:false},
					   { display : '甩班次数', minWidth:60,name : 'rejectCourseTimes',isSort:false},
					   { display : '甩班应扣课时', minWidth:85,name : 'deductHoursForRejectCourse',isSort:false},
					   { display : '实计课时', minWidth:60,name : 'actualHours',isSort:false},
					   { display : '上课总次数', minWidth:72,name : 'lessonTimes',isSort:false},
					   { display : '本学期请假课次', minWidth:100,name : 'courseNumbersForLeaveThisTerm',isSort:false},
					   { display : '班次类型', minWidth:60,name : 'classlevelTypeName',isSort:false},
					   { display : '考勤类型', minWidth:60,name : 'attendTypeName',isSort:false},
					   { display : '是否为班主任', minWidth:85,name : 'isHeadteacherStr',isSort:false}
						]
		};
		grid = showGrid(g);
	});
	function f_search() {
		grid.loadData();
	}
	
	
	//编辑 
	function to_generate() {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-attendsummary/attendSummary!toGenerate.action",
	    	width: 500,
	    	height: 280,
	    	title: "生成考勤"
	    });
	}
	
	
	function to_record() {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-attendsummary/attendSummary!toRecord.action",
	    	width: 550,
	    	height: 450,
	    	title: "考勤生成记录"
	    });
	}
	
	function to_range() {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-attendsummary/attendSummary!toRangePage.action",
	    	width: 650,
	    	height: 450,
	    	title: "月考勤时间段"
	    });
	}
	
</script>
	</head>
	<body>
			<form id="conditionForm">
			<div class="content">
				<!-- 载入班级基本信息联动 -->
				<ul id="basicLinkage">
				</ul>
				<!-- 载入班级上课地点联动信息 -->
				<ul id="locationLinkage">
				</ul>
				<ul>
					<li>
						<label>
							教师
						</label>
						<input type="text" name="condition.teacherName" id="teacher" class="input-text" />
					</li>
					<li>
						<label>
							班主任
						</label>
						<input type="text" name="condition.headteacherName" id="headteacher" class="input-text" />
					</li>
					<li>
						<label>
							是否为班主任
						</label>
						<select id="isHeadteacher" name="condition.isHeadteacher" class="input-select">
							<option value="">请选择</option>
							<option value="1">
								是
							</option>
							<option value="0">
								否
							</option>
						</select>
					</li>
					<li>
						<label>
							班次类型
						</label>
						<select id="classlevelTypeId" name="condition.classlevelTypeId" class="input-select">
							<option value="">请选择</option>
							<s:iterator value="classlevelTypes">
								<option value="<s:property value='id'/>"><s:property value="name"/></option>
							</s:iterator>
						</select>
					</li>
					<li>
						<label>
							班次类型
						</label>
						<select id="attendTypeId" name="condition.attendTypeId" class="input-select">
							<option value="">请选择</option>
							<s:iterator value="attendTypes">
								<option value="<s:property value='id'/>"><s:property value="name"/></option>
							</s:iterator>
						</select>
					</li>
					<li>
						<label>确认年月</label>
		    			<select id="verify_year_start" name="condition.verifyYearStart" class="input-select">
							<option value="">请选择</option>
							<option value="2010">2010年</option>
							<option value="2011">2011年</option>
							<option value="2012">2012年</option>
							<option value="2013">2013年</option>
							<option value="2014">2014年</option>
							<option value="2015">2015年</option>
							<option value="2016">2016年</option>
							<option value="2017">2017年</option>
							<option value="2018">2018年</option>
							<option value="2019">2019年</option>
							<option value="2020">2020年</option>
							<option value="2021">2021年</option>
							<option value="2022">2022年</option>
						</select>
						<select id="verify_month_start" name="condition.verifyMonthStart" class="input-select">
							<option value="">请选择</option>
							<option value="01">1月</option>
							<option value="02">2月</option>
							<option value="03">3月</option>
							<option value="04">4月</option>
							<option value="05">5月</option>
							<option value="06">6月</option>
							<option value="07">7月</option>
							<option value="08">8月</option>
							<option value="09">9月</option>
							<option value="10">10月</option>
							<option value="11">11月</option>
							<option value="12">12月</option>
						</select>
						<label>至</label>
		    			<select id="verify_year_end" name="condition.verifyYearEnd" class="input-select">
							<option value="">请选择</option>
							<option value="2010">2010年</option>
							<option value="2011">2011年</option>
							<option value="2012">2012年</option>
							<option value="2013">2013年</option>
							<option value="2014">2014年</option>
							<option value="2015">2015年</option>
							<option value="2016">2016年</option>
							<option value="2017">2017年</option>
							<option value="2018">2018年</option>
							<option value="2019">2019年</option>
							<option value="2020">2020年</option>
							<option value="2021">2021年</option>
							<option value="2022">2022年</option>
						</select>
						<select id="verify_month_end" name="condition.verifyMonthEnd" class="input-select">
							<option value="">请选择</option>
							<option value="01">1月</option>
							<option value="02">2月</option>
							<option value="03">3月</option>
							<option value="04">4月</option>
							<option value="05">5月</option>
							<option value="06">6月</option>
							<option value="07">7月</option>
							<option value="08">8月</option>
							<option value="09">9月</option>
							<option value="10">10月</option>
							<option value="11">11月</option>
							<option value="12">12月</option>
						</select>
					</li>
				</ul>
				<ul>
					<li>
						<label>
							开课日期
						</label>
						<input id="startDate_start" name="condition.startDateStart" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'startDate_start'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							至
						</label>
						<input id="startDate_end" name="condition.startDateEnd" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'startDate_end'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							结课日期
						</label>
						<input id="endDate_start" name="condition.endDateStart" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'endDate_start'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							至
						</label>
						<input id="endDate_end" name="condition.endDateEnd" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'endDate_end'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
				</ul>
					
				<ul>
					<li>
						<input type="button" id="queryButton" value="查询" class="l-button" onclick="f_search()"/>
						<input type="reset" id="resetButton" value="重置" class="l-button" />
						<input type="button" id="resetButton" value="生成考勤" class="l-button" onclick="to_generate()"/>
						<input type="button" id="resetButton" value="查看生成记录" style="width:110px;" class="l-button" onclick="to_record()"/>
						<input type="button" id="resetButton" value="设置月考勤时间段" style="width:130px;" class="l-button" onclick="to_range()"/>
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
