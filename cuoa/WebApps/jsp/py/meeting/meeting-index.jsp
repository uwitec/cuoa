<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>
<script src="<%=contextPath %>/js/jsp/py/meeting.js" type="text/javascript"></script>		
<script type="text/javascript">
			
	var role = "${role}";
	var toolbar = {items : [{ text: '导出', click: excel,icon:'outbox' }]};

	function excel(item) {
	    exportData("/py-meeting/meeting!export.action", [0,1], "${role}");
	}
</script>
	</head>
	<body>
			<form id="conditionForm">
			<div class="content">
				<!-- 载入班级基本信息联动 -->
				<ul id="basicLinkage">
				</ul>
				<ul>
					<li>
						<label>
							会议名称
						</label>
						<input type="text" name="condition.meetingName" id="teacher" class="input-text" />
					</li>
					<li>
						<label>
							教师姓名
						</label>
						<input type="text" name="condition.teacherName" id="headteacher" class="input-text" />
					</li>
				</ul>
				<ul>
					<li>
						<label>
							会议日期
						</label>
						<input id="startDate_start" name="condition.meetingStartDate" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'startDate_start'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							至
						</label>
						<input id="startDate_end" name="condition.meetingEndDate" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'startDate_end'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							补看录像截止日期
						</label>
						<input id="endDate_start" name="condition.deadlineStartDate" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'endDate_start'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							至
						</label>
						<input id="endDate_end" name="condition.deadlineEndDate" type="text" class="input-text" />
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
							是否取消全勤
						</label>
						<select id="isPerfectAttenisCancel" name="condition.isCancelPerfectAttendance" class="input-select">
							<option value="">请选择</option>
							<option value=0>否</option>
							<option value=1>是</option>
						</select>
					</li>
					<li>
		    			<label>确认年月</label>
		    			<select id="verify_year" name="condition.verifyYear"  class="input-select">
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
						<select id="verify_month" name="condition.verifyMonth"  class="input-select">
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
						<input type="button" id="queryButton" value="查询" class="l-button" onclick="f_search()"/>
						<input type="reset"" id="resetButton" value="重置" class="l-button" />
						
						<s:if test="role==1">
							<input type="button" id="addButton" value="新增" class="l-button" onclick="f_add()"/>
							<input type="button" id="exportButton" value="导入" class="l-button" onclick="f_import()"/>
							<input type="button" id="importButton" value="导入日志" class="l-button" onclick="f_import_log()" />
						</s:if>
						<s:elseif test="role==2">
							<input type="button" id="recoverButton" value="批量锁定" class="l-button" onclick="f_batch_isLock()"/>
							<input type="button" id="recoverButton" value="批量提交" class="l-button" onclick="f_batch_submit()"/>
						</s:elseif>
						<s:elseif test="role==3">
							<input type="button" id="recoverButton" value="批量审批" class="l-button" onclick="f_batch_audit()"/>
						</s:elseif>
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
