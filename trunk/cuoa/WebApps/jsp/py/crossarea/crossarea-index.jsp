<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>
<script src="<%=contextPath %>/js/jsp/py/crossarea.js" type="text/javascript"></script>
<script type="text/javascript">
var toolbar = {items : [{ text: '导出', click: excel,icon:'outbox' }]};

function excel(item) {
    exportData("/py-crossarea/crossarea!export.action", [0,1], "${role}");
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
						<select id="isHeadTeacher" name="condition.isHeadTeacher" class="input-select">
							<option value="" x1>请选择</option>
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
					</li>
					<li>
						<label>
							是否修改
						</label>
						<select id="isModify" name="condition.isModify" class="input-select">
							<option value="">请选择</option>
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
					</li>
	
					<li>
						<label>
							是否作废
						</label>
						<select id="isDeleted" name="condition.isDeleted" class="input-select">
							<option value="">请选择</option>
							<option value="1">是</option>
							<option value="0">否</option>
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
							上课日期
						</label>
						<input id="lessonDate_start" name="condition.lessonDateStart" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'lessonDate_start'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							至
						</label>
						<input id="lessonDate_end" name="condition.lessonDateEnd" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'lessonDate_end'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
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
						<label>确认年月</label>
			    			<select id="verify_year" name="condition.verifyYear" class="input-select">
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
							<select id="verify_month" name="condition.verifyMonth" class="input-select">
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
					<li>
							<label>
								通知教学点
							</label>
							<select id="ifNoticeToVenue" name="condition.ifNoticeToVenue" class="input-select">
								<option value="">请选择</option>
								<option value="1">已通知</option>
								<option value="0">未通知</option>
							</select>
					</li>
					<li>
							<label>
								通知督查
							</label>
							<select id="ifNoticeToSupervise" name="condition.ifNoticeToSupervise" class="input-select">
								<option value="">请选择</option>
								<option value="1">已通知</option>
								<option value="0">未通知</option>
							</select>
					</li>							
				</ul>								
				<ul>
					<li>
						<input type="button" id="queryButton" value="查询" class="l-button" onclick="f_search()"/>
						<input type="reset"" id="resetButton" value="重置" class="l-button" />					
						<input type="button" id="addButton" value="新增" class="l-button" onclick="f_add()"/>
						<input type="button" id="exportButton" value="导入" class="l-button" onclick="f_import()"/>
						<input type="button" id="importButton" value="导入日志" class="l-button" onclick="f_import_log()" />
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
