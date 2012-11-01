var grid = null;
$(function() {
	var g = {
		gridid : "maingrid",
		conditon : "condition",
		url : contextPath + "/py-courselate/courselate!data.action?role="+role,
		formid:"conditionForm",
		frozen: true,
		showToggleColBtn: false,
		toolbar : toolbar,
		checkbox : true,
		rownumbers:true,
		columns : [{ display: "操作", minWidth:170, name: "id",
	             		render: function(item){
	             			var html = "";
	           
             				if(role =="1"&&item.isCheckAttendance==0)
             				{	           
             					if(item.isLocked == 0)
             					{
			             			html = html + "<a href='javascript:f_edit(\""+item.id+"\")' class='linkbutton'>修改</a>";  
			             			if(item.isDeleted == 1)       						
			             				html = html + "<a href='javascript:f_is_delete(\""+item.id+"\",\"0\")' class='linkbutton'>启用</a>";					             			
				             		else
				             			html = html + "<a href='javascript:f_is_delete(\""+item.id+"\",\"1\")' class='linkbutton'>作废</a>";
		             			}
             				}
	             				
	             			else if(role =="2"&&item.isCheckAttendance==0){
	             				if(item.status != 2 &&item.status != 4&&item.isDeleted == 0)
	             				{
		             				if(item.isLocked==0)
	             						html = html + "<a href='javascript:f_is_lock(\""+item.id+"\",\"1\")' class='linkbutton'>锁定</a>";
	             					else
	             					{
	             						html = html + "<a href='javascript:f_revise(\""+item.id+"\",\""+item.deductId+"\")' class='linkbutton'>修正</a>";
			             				html = html + "<a href='javascript:f_submit(\""+item.id+"\")' class='linkbutton'>提交</a>";
			             				html = html + "<a href='javascript:f_audit_delete(\""+item.id+"\",\""+item.isCheckAttendance+"\")' class='linkbutton'>解锁</a>";
	             					}
	             				}
	             			}
	             			else if(role =="2"&&item.isCheckAttendance==1)
	             			{
	             				html = html + "<a href='javascript:f_audit_delete(\""+item.id+"\",\""+item.isCheckAttendance+"\")' class='linkbutton'>废除</a>";				
	             			}		             			
	             			else if(role =="3"&&item.isCheckAttendance==0){
	             			    if(item.status == 4&&item.isDeleted == 0)
	             					html = html + "<a href='javascript:f_audit(\""+item.id+"\",\"5\")' class='linkbutton'>反审核</a>";
	             				else if(item.status == 2&&item.isDeleted == 0)
	             				{	
	             					html = html + "<a href='javascript:f_audit(\""+item.id+"\",\"4\")' class='linkbutton'>审核</a>";
			             			html = html + "<a href='javascript:f_audit(\""+item.id+"\",\"3\")' class='linkbutton'>驳回</a>";
		             			}
	             			}
		             	//	html = html + "<a href='javascript:f_edit_log(\""+item.id+"\")' class='linkbutton'>修改记录</a>";
		                    return html;
		               }
		           },
		           {display : '确认年月', minWidth:60,  name : 'verifyYearMonth',isSort:false}, 
		           { display: '分校',minWidth:60, name: 'cityName',isSort:false},
		           { display : '学期',minWidth:60, name : 'termName',isSort:false},
			       { display : '年部', minWidth:60,name : 'gtName',isSort:false},
			       { display : '年级', minWidth:60,name : 'gradeName',isSort:false},
			       { display : '学科', minWidth:60,name : 'subjectNames',isSort:false},
			       { display : '班次', minWidth:60, name : 'classlevelName',isSort:false},
			       { display : '班级名称',minWidth:120, name : 'courseName',isSort:false},
			       { display : '班主任',minWidth:60, name : 'headteacherName',isSort:false},
			       { display : '地区', minWidth:80,name : 'areaName',isSort:false},
			       { display : '服务中心', minWidth:80,name : 'servicecenterName',isSort:false},
			       { display : '教学点', minWidth:80,name : 'venueName',isSort:false},
			       { display : '教室', minWidth:80,name : 'classroomName',isSort:false},
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
			       { display : '是否修正课时',minWidth:80, name : 'isReviseStr',isSort:false,
		         	render: function(item){
		         		var html = "";
			         	if(item.isRevise == 1)
			         		html = html + "<a href='javascript:f_revise_log(\""+item.deductId+"\")' class='linkbutton'>修正记录</a>";
			         	else
			         		html = html+"否";
			         	return html
		         	} 
		         },
			       { display : '修正原因',minWidth:60, name : 'reasonForRevise',isSort:false},
			       { display : '课时修正人',minWidth:60, name : 'reviseEmployeeName',isSort:false},
			       { display : '是否修改',minWidth:80, name : 'isModifiedStr',isSort:false,
		         	render: function(item){
		         		var html = "";
		         			if(item.isModified == 1)
		         				html = html + "<a href='javascript:f_edit_log(\""+item.id+"\")' class='linkbutton'>是</a>";
		         			else
		         				html = html+"否";
		         			
			         	return html
		         	}
		         },
			       { display : '修改原因',minWidth:80, name : 'reasonForModify',isSort:false},
			       { display : '修改操作人',minWidth:80, name : 'modifierName',isSort:false},
			       { display : '状态',minWidth:80, name : 'statusStr',isSort:false},
			       { display : '审核人',minWidth:80, name : 'auditorName',isSort:false},
			       { display : '是否为班主任',minWidth:80, name : 'isHeadteacherStr',isSort:false},
			       { display : '是否取消全勤',minWidth:150, name : 'isCancelPerfectAttendanceStr',isSort:false,
		         	render: function(item, rowindex, value, column){
			         	var html = "";
		         		//是否考勤主管查看
		         		if(role =="3"||item.isCheckAttendance!=0)
		         		{	
		         			if(item.isCancelPerfectAttendanceStr) html = html+item.isCancelPerfectAttendanceStr;
		         		}	
		         		else
		         		{
				         	html = html +	"<select id='perfectAttendance"+rowindex+"'  class='input-select'  onchange='isPerfect_onChange(\""+item.id+"\",\"perfectAttendance"+rowindex+"\")'> ";
							html = html +	"	<option value=1  ";
							if(item.isCancelPerfectAttendance==1)
								html =  html + "  selected='selected' "
							html = html +	" >是</option>";
							html = html +	"	<option value=0 ";
							if(item.isCancelPerfectAttendance==0)
								html =  html + "  selected='selected' ";
							html = html +" >否</option>";
							html = html +	"	</select>";
		         		}	
		         	return html;
		         	}
		         },
			       { display : '是否作废',minWidth:80, name : 'isDeletedStr',isSort:false}
					]
	};
	grid = showGrid(g);
});
function f_search() {
	grid.loadData();
}


//编辑 
function f_edit(id) {
	dialog = $.ligerDialog.open({ 
    	url: contextPath + "/py-courselate/courselate!toEdit.action?late.id=" + id+"&timeStamp="+new Date().getTime(),
    	width: 850,
    	height: 550,
    	title: "更改请假信息"
    });
}

//修正
function f_revise(entityId,deductId)
{
	
	var url = contextPath + "/common/revise!toRevise.action";
	url = url + "?modifyDeductLessonCondition.entityId="+entityId;
	url = url + "&modifyDeductLessonCondition.deductId="+deductId;
	url = url + "&modifyDeductLessonCondition.type="+0;
	url = url + "&timeStamp="+new Date().getTime();
	
	dialog = $.ligerDialog.open({ 
    	url: url,
    	width: 650,
    	height: 400,
    	title: "教师迟到扣课时修正",
    	buttons : [{
			text : "取消",
			onclick : function(item, dialog) {
				dialog.close();
			}
		} ]
    });
}

//是否作废
function f_is_delete(ids, type) {
	if (ids == null || ids == "") {
		alertt("请至少选择一项");
		return;
	}
	var label = (type == 1 ? "作废操作" : "启用操作");
	var message = (type == 1 ? "确认作废吗？" : "确认启用吗？");

	confirm(label, message, function() {
		$.getJSON(
			contextPath + "/py-courselate/courselate!" + (type == 1 ? "cancelLate" : "resumeLate") + ".action?ids=" + ids +"&timeStamp=" + new Date().getTime(), 
			function(json) {
				if (json.success) {
					alert(json.message, "success");
					grid.loadData();
				}else
				{
					alert(json.message,"warn");
				}
			});
	});
}


	
//是否加锁
function f_is_lock(ids, type) {
	if (ids == null || ids == "") {
		alertt("请至少选择一项");
		return;
	}
	var label = (type == 1 ? "加锁操作" : "解锁操作");
	var message = (type == 1 ? "确认加锁吗？" : "确认解锁吗？");

	confirm(label, message, function() {
	$.getJSON(
		contextPath + "/py-courselate/courselate!" + (type == 1 ? "lockLate" : "unLockLate") + ".action?ids=" + ids + "&timeStamp=" + new Date().getTime(), 
		function(json) {
			if (json.success) {
				alert(json.message, "success");
				grid.loadData();
			}else
			{
				alert(json.message,"warn");
			}
		});
	});
}


//提交
function f_submit(ids) {
	if (ids == null || ids == "") {
		alertt("请至少选择一项");
		return;
	}
	confirm("提交操作", "确认提交吗？", function() {
	$.getJSON(
		contextPath+"/py-courselate/courselate!submitLate.action?ids=" + ids + "&timeStamp="+new Date().getTime(), 
		function(json) {
			if (json.success) {
				alert(json.message,"success");
				grid.loadData();
			}else
			{
				alert(json.message,"warn");
			}
		});
	});
}



//审核
function f_audit(ids, type) {
	if (ids == null || ids == "") {
		alertt("请至少选择一项");
		return;
	}
	var label = "";
	var message = "";
	var method = "";
	if(type == "3") {
		label = "驳回操作";
		message = "确认驳回吗？";
		method = "rejectLate";
	} else if(type == "4") {
		label = "审核操作";
		message = "确认审核通过吗？";
		method = "auditLate";
	} else if(type == "5") {
		label = "反审核操作";
		message = "确认反审核吗？";
		method = "reverseAuditLate";
	} else {
		return;
	}

	confirm(label, message, function() {
	$.getJSON(
		contextPath+"/py-courselate/courselate!" + method + ".action?ids= "+ids + "&timeStamp=" +new Date().getTime(), 
		function(json) {
			if (json.success) {
				alert(json.message,"success");
				grid.loadData();
			}else
			{
				alert(json.message,"warn");
			}
		});
	});
}

//已考勤后，废除或解锁
function f_audit_delete(id,value)
{
	dialog = $.ligerDialog.open({ 
    	url: contextPath+"/py-courselate/courselate!toIndexForDeduct.action?late.id="+id+"&late.isCheckAttendance="+value+"&timeStamp="+new Date().getTime(), 
    	width: 650,
    	height: 400,
    	title: "相关请假信息",
    	buttons : [ {
			text : "取消",
			onclick : function(item, dialog) {
				dialog.close();
			}
		} ]
   	 });
} 


//确认/取消全勤
function isPerfect_onChange (ids,valueId)
{
	var value = $("#"+valueId).val();
	
	var label = "";
	var message = "";
	if(value == "0")
	{
		label = "确认全勤操作";
		message = "确认全勤吗？";
	}	
	else if(value == "1")
	{
		label = "取消全勤操作";
		message = "确认取消全勤吗？";
	}	
	else
	 return;

	confirm(label, message, function() {
	$.getJSON(
		contextPath+"/py-courselate/courselate!" + (value == "0" ? "isPerfect" : "unIsPerfect") + ".action?ids=" + ids + "&timeStamp=" + new Date().getTime(),
		function(json) {
			if (json.success) {
				alert(json.message,"success");
				grid.loadData();
			}else
			{
				alert(json.message,"warn");
			}
		});
	});
}


function f_edit_log(id)
{
	dialog = $.ligerDialog.open({ 
    	url: contextPath + "/py-courselate/courselate!toQueryLateLog.action?late.id=" + id+"&timeStamp="+new Date().getTime(),
    	width: 650,
    	height: 400,
    	title: "修改记录",
    	buttons : [{
			text : "取消",
			onclick : function(item, dialog) {
				dialog.close();
			}
		} ]
    });

}


//修正记录
function f_revise_log(id)
{
		if(id == '')
		{
			alert("id:"+id);
			return;
		}
			
		dialog = $.ligerDialog.open({ 
    	url: contextPath + "/common/revise!toQueryReviseLog.action?id=" + id+"&timeStamp="+new Date().getTime(),
    	width: 650,
    	height: 400,
    	title: "教师请假修正记录",
    	buttons : [{
			text : "取消",
			onclick : function(item, dialog) {
				dialog.close();
			}
		} ]
    });
}
