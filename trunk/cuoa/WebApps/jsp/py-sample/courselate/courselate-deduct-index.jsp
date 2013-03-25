<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>
		<script type="text/javascript">
		
		
		var lateId = "<s:property value='condition.ids'/>";
		
		 //提交
         function f_submit(){
         
         	var  url = contextPath;
         	var check = "<s:property value='condition.isCheckAttendance'/>"
         	var label = "";
			var message = "";
         	if(check == "1")
         	{
         		url = url + "/py-courselate/courselate!auditDelete.action"
         		label = "废除操作";
				message = "确认废除吗？";
         	}
         	else if(check == "0")
         	{
         		url = url + "//py-courselate/courselate!unLockLate.action"
         		label = "解锁操作";
				message = "确认解锁吗？";
         	}	
         	else
         		return;
         
         	confirm(label, message, function() {
		        	var param={ids:"<s:property value='condition.ids'/>"};
		        	$.post(url, param, function(json){
						if(json.success){
							alert(json.message,"success");
						  	home_fresh();
						  	closeWindow();
						}else{
							alert(json.message,"error");
						}
					});
				}); 
          }
		
		
		
	var grid = null;
	$(function() {
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/py-courselate/courselate!dataForDeduct.action",
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			checkbox : false,
			rownumbers:false,
			columns : [
						{ display : '考勤状态',minWidth:60, name : 'isModifyStr',isSort:false,
				         	render: function(item){
				         		var html = "";

				         			if(item.id == lateId)
				         			{
				         				html = html + "<font color='red'>";
				         				html = html +  item.isCheckAttendanceStr;
				         				html = html + "</font >";
				         			}	
				         			else 
				         				html = html + item.isCheckAttendanceStr;
					         	return html
				         	}
				         },			
			           {display : '确认年月', minWidth:60,  name : 'verifyYearMonth',isSort:false}, 
			           { display: '分校',minWidth:60, name: 'cityName',isSort:false},
			           { display : '学期',minWidth:60, name : 'termName',isSort:false},
				       { display : '年部', minWidth:60,name : 'gtName',isSort:false},
				       { display : '年级', minWidth:60,name : 'gradeName',isSort:false},
				       { display : '学科', minWidth:60,name : 'subjectNames',isSort:false},
				       { display : '班次', minWidth:60, name : 'classlevelName',isSort:false},
				       { display : '班级名称',minWidth:60, name : 'courseName',isSort:false},
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
	
	
	
	
	
	
</script>
	</head>
	<body>
			<form id="conditionForm">
				<input  type="hidden" name="condition.ids" value="<s:property value='condition.ids'/>" />
			</form>
				
			</div>
			<div id="maingrid" class="grid">
			</div>


	<div class="content">
			<ul>
		   		<li>
		   			<input type="button" id="queryButton" value="确认" class="l-button"  onclick="f_submit()"/>
					<input type="button"" id="resetButton" value="取消" class="l-button" onclick="closeWindow();" />
		   		</li>
		   	</ul>
		</div>

	</body>

</html>
