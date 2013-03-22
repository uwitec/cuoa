<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>
<script src="<%=contextPath %>/js/jsp/py/courseleaveadditional.js" type="text/javascript"></script>
<script type="text/javascript">
		
	
var role = "${role}";
var leaveTypes = ${leaveTypes};//请假/甩班原因分类
	
var toolbar = {items : [{ text: '导出', click: excel,icon:'outbox' }]};

function excel(item) {
    exportData("/py-courseleave/courseleaveadditional!export.action", [0,1], "${role}");
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
						<input type="text" name="condition.leaveTeacherName" id="teacher" class="input-text" />
					</li>
					<li>
						<label>
							班主任
						</label>
						<input type="text" name="condition.leaveHeadteacherName" id="headteacher" class="input-text" />
					</li>
					<li>
						<label>
							是否为班主任
						</label>
						<select id="isHeadteacher" name="condition.isHeadteacher" class="input-select">
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
							上课时间
						</label>
						<input id="lessonTime_start" name="condition.lessonTimeStart" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'HH:mm:ss'})"/>	
					</li>
					<li>
						<label>
							至
						</label>
						<input id="lessonTime_end" name="condition.lessonTimeEnd" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'lessonTime_end'})"
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
					<li>
						<label>
							是否作废
						</label>
						<select id="isDeleted" name="condition.isDeleted" class="input-select">
							<option value="">请选择</option>
							<option value=0>否</option>
							<option value=1>是</option>
						</select>
					</li>	
				</ul>	
				<ul>
					<li>
						<label>
							是否取消全勤
						</label>
						<select id="isCancelPerfectAttendance" name="condition.isCancelPerfectAttendance" class="input-select">
							<option value="">请选择</option>
							<option value=0>否</option>
							<option value=1>是</option>
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
							请假类型
						</label>
						<select id="type" name="condition.type" class="input-select">
							<option value="">请选择</option>
							<option value="1">开课前48小时（含48小时）以上</option>
							<option value="2">开课前24小时（含24小时）到48小时之间</option>
							<option value="3">课前24-12小时内请假</option>
							<option value="4">课前12-6小时内请假</option>
							<option value="5">课前6-2小时内请假</option>
							<option value="6">课前2小时内请假</option>
							<option value="0">未请假</option>
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
