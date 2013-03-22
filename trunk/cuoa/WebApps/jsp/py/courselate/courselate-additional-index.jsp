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
        exportData("/py-courselate/courselateadditional!export.action", [0,1], "${role}");
    }
    
    function f_import(id) {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-courselate/courselateadditional!toImportAdditional.action?importAction=/py-courselate/courselateadditional!importAdditional.action",
	    	width: 550,
	    	height: 180,
	    	title: "导入补差"
	    });
	}
	$(function() {
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/py-courselate/courselateadditional!data.action?role=${role}",
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			toolbar : toolbar,
			checkbox : true,
			rownumbers:false,
			columns : [{ display: "操作", minWidth:170, name: "id",
		             		render: function(item){
		             			var html = "";
		             			//如果已做过考勤，不允许做任何操作
		             			if (item.isCheckAttendance != 0) {
		             				return html;
		             			}
		             			if ("${role}" == "2") {
		             				if (item.status == 1 || item.status == 3 || item.status == 5) { //状态为正常或已驳回或已反审核时可修改和提交
			             				html = html + "<a href='javascript:f_revise(\""+item.id+"\")' class='linkbutton'>修正</a>";
					             		html = html + "<a href='javascript:f_submit(\""+item.id+"\")' class='linkbutton'>提交</a>";
		             				}
		             			} else if ("${role}" == "3") {
		             				if (item.status == 2) { //状态为待审核时可审核和驳回
					             		html = html + "<a href='javascript:f_audit(\""+item.id+"\",\"4\")' class='linkbutton'>审核</a>";
					             		html = html + "<a href='javascript:f_audit(\""+item.id+"\",\"3\")' class='linkbutton'>驳回</a>";
		             				} else if (item.status == 4) //状态为已审核时可反审核
				             		html = html + "<a href='javascript:f_audit(\""+item.id+"\",\"5\")' class='linkbutton'>反审核</a>";
		             			}
			                    return html;
			               }
			           },
			           {display : '补录扣课时数', minWidth:85,  name : 'addHours',isSort:false},
			           {display : '补录扣课时原因', minWidth:125,  name : 'addReason',isSort:false},
			           {display : '补录人', minWidth:85,  name : 'addEmployeeName',isSort:false},
			           {display : '补录时间', minWidth:135,  name : 'addTime',isSort:false},
			           {display : '最后修改补录人', minWidth:125,  name : 'modifyAddEmployeeName',isSort:false},
			           {display : '最后修改补录时间', minWidth:135,  name : 'modifyAddTime',isSort:false},
			           {display : '补录指向日期', minWidth:125,  name : 'addTargetDate',isSort:false},
			           
			           {display : '确认年月', minWidth:60,  name : 'verifyYearMonth',isSort:false}, 
			           { display: '分校',minWidth:60, name: 'cityName',isSort:false},
			           { display : '学期',minWidth:60, name : 'termName',isSort:false},
				       { display : '年部', minWidth:60,name : 'gtName',isSort:false},
				       { display : '年级', minWidth:60,name : 'gradeName',isSort:false},
				       { display : '学科', minWidth:60,name : 'subjectNames',isSort:false},
				       { display : '班次', minWidth:60, name : 'classlevelName',isSort:false},
				       { display : '班级名称',minWidth:60, name : 'courseName',isSort:false,
				    	   render: function(item){
				    		   var html = "";
				    		   html = html + "<a href='javascript:queryClassDetails(\""+item.courseId+"\")' class='linkbutton'>"+item.courseName+"</a>";
				    		   return html;
				    	   }
				       },
				       { display : '班主任',minWidth:60, name : 'headteacherName',isSort:false},
				       { display : '地区', minWidth:60,name : 'areaName',isSort:false},
				       { display : '服务中心', minWidth:60,name : 'servicecenterName',isSort:false},
				       { display : '教学点', minWidth:60,name : 'venueName',isSort:false},
				       { display : '教室', minWidth:60,name : 'classroomName',isSort:false},
				       { display : '总课次', minWidth:60,name : 'lessonCount',isSort:false},
					   { display : '课时', minWidth:60,name : 'hours',isSort:false},
				       { display : '上课时间', minWidth:60,name : 'timeName',isSort:false},
				       { display : '开课日期', minWidth:60,name : 'startDate',isSort:false},
				       { display : '结课日期', minWidth:60,name : 'endDate',isSort:false},
				       { display : '迟到类型',minWidth:60, name : 'lateType',isSort:false},
				       { display : '上课教师',minWidth:60, name : 'teacherName',isSort:false},
				       { display : '教师编号',minWidth:60, name : 'teacherCode',isSort:false},
				       { display : '课次上课日期', minWidth:85,name : 'lessonDate',isSort:false},
				       { display : '课次上课时间', minWidth:85,name : 'lessonTime',isSort:false},
				       { display : '迟到时间', minWidth:85,name : 'actualTime',isSort:false},
				       { display : '课次',minWidth:60, name : 'lessonNo',isSort:false},
				       { display : '迟到原因',minWidth:60, name : 'reason',isSort:false},
				       { display : '创建时间',minWidth:60, name : 'createTime',isSort:false},
				       { display : '应扣课时',minWidth:60, name : 'deductHours',isSort:false},
				       { display : '扣课时规则',minWidth:60, name : 'deductRule',isSort:false},
				       { display : '最终扣课时',minWidth:60, name : 'finalDeductHours',isSort:false},
				       { display : '是否修正课时',minWidth:80, name : 'isRevisedStr',isSort:false},
				       { display : '修正原因',minWidth:60, name : 'reasonForRevise',isSort:false},
				       { display : '课时修正人',minWidth:60, name : 'reviseEmployeeName',isSort:false},
				       { display : '是否修改',minWidth:80, name : 'isModifiedStr',isSort:false},
				       { display : '修改原因',minWidth:80, name : 'reasonForModify',isSort:false},
				       { display : '修改操作人',minWidth:80, name : 'modifierName',isSort:false},
				       { display : '状态',minWidth:80, name : 'statusStr',isSort:false},
				       { display : '审核人',minWidth:80, name : 'auditorName',isSort:false},
				       { display : '是否为班主任',minWidth:80, name : 'isHeadteacherStr',isSort:false},
				       { display : '是否取消全勤',minWidth:80, name : 'isCancelPerfectAttendance',isSort:false},
				       { display : '是否作废',minWidth:80, name : 'isDeletedStr',isSort:false}
						]
		};
		grid = showGrid(g);
	});
	function f_search() {
		grid.loadData();
	}
	
	
	//修正 
	function f_revise(id) {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-courselate/courselateadditional!toEdit.action?additional.id=" + id+"&timeStamp="+new Date().getTime(),
	    	width: 750,
	    	height: 310,
	    	title: "修正补差"
	    });
	}
	
	
	
	//提交
	function f_submit(ids) {
		if (ids == null || ids == "") {
			alert("请至少选择一项");
			return;
		}
		confirm("提交操作", "确认提交吗？", function() {
		$.getJSON(
			contextPath+"/py-courselate/courselateadditional!submit.action?ids=" + ids + "&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alertt(json.message,"success");
					grid.loadData();
				}else
				{
					alertt(json.message,"warn");
				}
			});
		});
	}
	

	
	//审核,驳回，反审核
	function f_audit(ids, type) {
		if (ids == null || ids == "") {
			alert("请至少选择一项");
			return;
		}
		var label = "";
		var message = "";
		var method = "";
		if(type == "3") {
			label = "驳回操作";
			message = "确认驳回吗？";
			method = "reject";
		} else if(type == "4") {
			label = "审核操作";
			message = "确认审核通过吗？";
			method = "audit";
		} else if(type == "5") {
			label = "反审核操作";
			message = "确认反审核吗？";
			method = "reverseAudit";
		} else {
			return;
		}
	
		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-courselate/courselateadditional!" + method + ".action?ids="+ids + "&timeStamp=" +new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}else
				{
					alertt(json.message,"warn");
				}
			});
		});
	}
	
	
	//确认/取消全勤
	function IsPerfect (id,value)
	{
		var label = "";
		var message = "";
		if(value = "1")
		{
			label = "确认全勤操作";
			message = "确认全勤吗？";
		}	
		else if(value = "0")
		{
			label = "取消全勤操作";
			message = "确认取消全勤吗？";
		}	
		else
		 return;
	
		confirm(label, message, function() {
		$.getJSON(
			contextPath+"/py-courseleave/courseleave!isPerfect.action?ids="+id+"&value="+value+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message,"success");
					grid.loadData();
				}else
				{
					alertt(json.message,"warn");
				}
			});
		});
	}
	
	
	function f_edit_log(id)
	{
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-courseleave/courseleave!toQueryLeaveLog.action?id=" + id+"&timeStamp="+new Date().getTime(),
	    	width: 950,
	    	height: 650,
	    	title: "修改记录",
	    	buttons : [{
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
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
							是否修改
						</label>
						<select id="isModified" name="condition.isModified" class="input-select">
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
							是否已锁定
						</label>
						<select id="isLocked" name="condition.isLocked" class="input-select">
							<option value="">请选择</option>
							<option value="1">已锁定</option>
							<option value="0">未锁定</option>
						</select>
					</li>	
					<li>
						<label>
							是否取消全勤
						</label>
						<select id="isPerfectAttendance" name="condition.isCancelPerfectAttendance" class="input-select">
							<option value="">请选择</option>
							<option value="1">否</option>
							<option value="0">是</option>
						</select>
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
							迟到类型
						</label>
						<select id="lateType" name="condition.lateType" class="input-select">
							<option value="">请选择</option>
							<option value="1">课前迟到</option>
							<option value="2">课后迟到</option>
							<option value="3">缺勤</option>
						</select>
					</li>
					<li>
						<label>
							状态
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
