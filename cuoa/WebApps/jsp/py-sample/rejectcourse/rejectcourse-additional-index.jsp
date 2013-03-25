<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>
<script src="<%=contextPath %>/js/jsp/py/rejectcourseadditional.js" type="text/javascript"></script>		
<script type="text/javascript">
			
	var role = "${role}";
	var leaveTypes = ${leaveTypes};//请假/甩班原因分类
	var toolbar = {items : [{ text: '导出', click: excel,icon:'outbox' }]};

	function excel(item) {
	    exportData("/py-courseleave/rejectcourseadditional!export.action", [0,1], "${role}");
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
						<input type="text" name="condition.rejectingTeacherName" id="teacher" class="input-text" />
					</li>
					<li>
						<label>
							班主任
						</label>
						<input type="text" name="condition.rejectingHeadteacherName" id="headteacher" class="input-text" />
					</li>
					<li>
						<label>
							是否为班主任
						</label>
						<select id="isHeadTeacher" name="condition.isHeadTeacher" class="input-select">
							<option value="" x1>请选择</option>
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
							是否取消全勤
						</label>
						<select id="isPerfectAttenisCancel" name="condition.isCancelPerfectAttendance" class="input-select">
							<option value="">请选择</option>
							<option value=0>否</option>
							<option value=1>是</option>
						</select>
					</li>
					<li>
						<label>
							是否取消工资晋升资格
						</label>
						<select id="isCancelPromoteSalary" name="condition.isCancelPromoteSalary" class="input-select">
							<option value="">请选择</option>
							<option value=0>否</option>
							<option value=1>是</option>
						</select>
					</li>
				</ul>
				<ul>
					<li>
						<label>
							是否作废
						</label>
						<select id="isDeleted" name="condition.isDeleted" class="input-select">
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
							操作类型
						</label>
						<select id="status" name="condition.status" class="input-select">
							<option value="">请选择</option>
							<option value="1">正常</option>
							<option value="2">待审核</option>
							<option value="3">已驳回</option>
							<option value="4">已审核</option>
							<option value="5">反审核</option>
						</select>
					</li>
					<li>
						<label>
							是否修改
						</label>
						<select id="isModify" name="condition.isModify" class="input-select">
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
							是否修正
						</label>
						<select id="isRevise" name="condition.isRevise" class="input-select">
							<option value="">请选择</option>
							<option value="1">
								是
							</option>
							<option value="0">
								否
							</option>
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
						<label>
							导入系统时间
						</label>
						<input id="importTime_start" name="condition.importTimeStart" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'importTime_start'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							至
						</label>
						<input id="importTime_end" name="condition.importTimeEnd" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'importTime_end'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
				</ul>				
				<ul>
					<li>
						<label>
							开班日期
						</label>
						<input id="courseDate_start" name="condition.courseDateStart" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'courseDate_start'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							至
						</label>
						<input id="courseDate_end" name="condition.courseDateEnd" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'courseDate_end'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							甩班日期
						</label>
						<input id="rejectDate_start" name="condition.rejectDateStart" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'rejectDate_start'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							至
						</label>
						<input id="rejectDate_end" name="condition.rejectDateEnd" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'rejectDate_end'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
				</ul>
				<ul>
					<li>
						<label>
							甩班类型
						</label>
						<select id="rejectCourseType" name="condition.rejectCourseType" class="input-select">
							<option value="">请选择</option>
							<option value="1">续报周之后至开课之前21（不含）天甩班</option>
							<option value="2">开课前21（含）天甩班</option>
							<option value="3">开课后甩班</option>
						</select>
					</li>
					<li>
						<label>
							甩班原因分类
						</label>
					    <select  name = "condition.sortOfReasonId" id="sortOfReasonId" class="input-select" onchange="queryLeaveTypeById('sortOfReasonId','specificSortOfReasonId');" >
							<option value="">请选择</option>
						</select>
					    
					 </li>
					 <li>   
					 	<label>
							具体原因分类
						</label>
						<select  name = "condition.specificSortOfReasonId" class="input-select" id="specificSortOfReasonId"  >
							<option value="">请选择</option>
						</select>	
					</li>					
				</ul>
				<ul>
					<li>
						<input type="button" id="queryButton" value="查询" class="l-button" onclick="f_search()"/>
						<input type="reset"" id="resetButton" value="重置" class="l-button" />
						<s:if test="role == 2">
							<input type="button" value="导入" class="l-button" onclick="f_import()"/>
						</s:if>
						
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
