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
        exportData("/py-curriculum/curriculum-summary!export.action", [0,1]);
    }

    function excel_all() {
    	alert();
    }
	$(function() {
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/py-curriculum/curriculum-summary!data.action",
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			toolbar : toolbar,
			checkbox : true,
			rownumbers:false,
			columns : [{display : '确认年月', minWidth:60,  name : 'verifyYearMonth',isSort:false}, 
			           { display: '分校', name: 'cityName',isSort:false},
			           { display : '系统姓名',minWidth:60, name : 'teacherName',isSort:false},
			           { display : '教师编号',minWidth:60, name : 'teacherCode',isSort:false},
				       { display : '班主任',minWidth:60, name : 'headteacherName',isSort:false},
				       { display : '学期',minWidth:50, name : 'termName',isSort:false},
				       { display : '年部', minWidth:40,name : 'gtName',isSort:false},
				       { display : '年级', minWidth:100,name : 'gradeName',isSort:false},
				       { display : '学科', minWidth:40,name : 'subjectNames',isSort:false},
				       { display : '班次', minWidth:90, name : 'classlevelName',isSort:false},
				       { display : '班级名称',minWidth:300, name : 'courseName',isSort:false,
				    	   render: function(item){
				    		   var html = "";
				    		   html = html + "<a href='javascript:queryClassDetails(\""+item.courseId+"\")' class='linkbutton'>"+item.courseName+"</a>";
				    		   return html;
				    	   }
				       },
				       { display : '考勤类型',minWidth:300, name : 'attendTypeName',isSort:false},
				       { display : '开班日期',minWidth:300, name : 'createTime',isSort:false},
			           { display : '开课日期', minWidth:90,name : 'startDate',isSort:false},
			           { display : '结课日期', minWidth:90,name : 'endDate',isSort:false},
			           { display : '总课次', minWidth:50,name : 'lessonCount',isSort:false},
			           { display : '已上课次',minWidth:60, name : 'passedLessonCount',isSort:false},
				       { display : '剩余课次',minWidth:60, name : 'remainCount',isSort:false},
				       { display : '限额人数', minWidth:60,name : 'limitNumberOfStudent',isSort:false},
				       { display : '地区', minWidth:60,name : 'areaName',isSort:false},
				       { display : '服务中心', minWidth:60,name : 'servicecenterName',isSort:false},
				       { display : '教学点', minWidth:70,name : 'venueName',isSort:false},
				       { display : '教室', minWidth:70,name : 'classroomName',isSort:false},
				       { display : '上课日期', minWidth:120,name : 'courseDate',isSort:false},
			           { display : '上课时间', minWidth:120,name : 'courseTime',isSort:false},
				       { display : '课时', minWidth:120,name : 'hours',isSort:false},
				       { display : '所结课次',minWidth:60, name : 'courseNum',isSort:false},
				       { display : '是否为班主任',minWidth:85, name : 'isHeadteacherStr',isSort:false},
				       { display : '修改类型', minWidth:70,name : 'modifyTypeName',isSort:false},
				       { display : '修改原因',minWidth:60, name : 'reason',isSort:false},
				       { display : '修改次数',minWidth:70, name : 'modifyTimes',isSort:false},
				       { display : '是否代课',minWidth:70, name : 'isSubstitution',isSort:false},
				       { display : '是否为额外补课',minWidth:120, name : 'isExtraStr',isSort:false},
				       { display : '是否停课',minWidth:70, name : 'isSuspendStr',isSort:false},
				       { display : '审核状态',minWidth:85, name : 'statusStr',isSort:false},
				       { display : '汇总人',minWidth:70, name : '',isSort:false},
				       { display : '审核人',minWidth:70, name : 'auditorName',isSort:false},
				       { display : '操作人',minWidth:70, name : 'modifierName',isSort:false}
			           
			           
			           
			           
			           
			           
			           
			           
			           
			           
			           
			           
			           
			           
			           
			           
			           
			           
/*			           {display : '确认年月', minWidth:60,  name : 'verifyYearMonth',isSort:false},
			           { display: '分校', minWidth:45, name: '',isSort:false,
			           	    render:function(item){
			           		    if(item.location && item.location.city){
			           			    return item.location.city.name;
			           		    }
			           	    }
			            },
			            { display : '系统姓名',minWidth:60, name : '',isSort:false,
			            	render:function(item) {
			            		if(item.teacher) {
			            			return item.teacher.name;
			            		}	
			            	}
			            },
			            { display : '教师编号',minWidth:60, name : '',isSort:false,
			            	render:function(item) {
			            		if(item.teacher) {
			            			return item.teacher.code;
			            		}	
			            	}
			            },
				         { display : '班主任',minWidth:60, name : '',isSort:false,
			            	 render:function(item){
				           		 if(item.headteacher){
				           			 return item.headteacher.name;
				           		 }
				           	 }
				         },
				         { display : '学期',minWidth:50, name : 'termName',isSort:false,
			            	 render:function(item){
				           		 if(item.course && item.course.basic){
				           			 return item.course.basic.termName;
				           		 }
				           	 }
				         },
				         { display : '年部', minWidth:40,name : 'gtName',isSort:false,
			            	 render:function(item){
				           		 if(item.course && item.course.basic){
				           			 return item.course.basic.gtName;
				           		 }
				           	 }
				         },
				         { display : '年级', minWidth:100,name : 'gradeName',isSort:false,
			            	 render:function(item){
				           		 if(item.course && item.course.basic){
				           			 return item.course.basic.gradeName;
				           		 }
				           	 }
				         },
				         { display : '学科', minWidth:40,name : 'subjectNames',isSort:false,
			            	 render:function(item){
				           		 if(item.course && item.course.basic){
				           			 return item.course.basic.subjectNames;
				           		 }
				           	 }
				         },
				         { display : '班次', minWidth:90, name : 'classlevelName',isSort:false,
			            	 render:function(item){
				           		 if(item.course && item.course.basic){
				           			 return item.course.basic.classlevelName;
				           		 }
				           	 }
				         },
				         { display : '班级名称',minWidth:300, name : 'name',isSort:false,
			            	 render:function(item){
				           		 if(item.course){
				           			 return item.course.name;
				           		 }
				           	 }
				         },
				         { display : '考勤类型',minWidth:75, name : '',isSort:false,
			            	 render:function(item){
				           		 if(item.attendType){
				           			 return item.attendType.name;
				           		 }
				           	 }
				         },
				         { display : '开班日期',minWidth:90, name : '',isSort:false,
				        	 render:function(item){
				           		 if(item.course){
				           			 return format_date(item.course.createTime, "yyyy-MM-dd");
				           		 }
				           	 }
				         },
			            
				         { display : '开课日期', minWidth:90,name : 'startDate',isSort:false,
			            	 render:function(item){
				           		 if(item.course){
				           			 return format_date(item.course.startDate, "yyyy-MM-dd");
				           		 }
				           	 }
				         },
				         { display : '结课日期', minWidth:90,name : 'endDate',isSort:false,
			            	 render:function(item){
			            		 if(item.course){
				           			 return format_date(item.course.endDate, "yyyy-MM-dd");
				           		 }
				           	 }
				         },
				         { display : '总课次', minWidth:50,name : 'lessonCount',isSort:false,
			            	 render:function(item){
				           		 if(item.course){
				           			 return "" + item.course.lessonCount;
				           		 }
				           	 }
				         },
				         { display : '已上课次',minWidth:60, name : 'passedLessonCount',isSort:false,
			            	 render:function(item){
				           		 if(item.course){
				           			 return item.course.passedLessonCount;
				           		 }
				           	 }
				         },
				         { display : '剩余课次',minWidth:60, name : '',isSort:false,
			            	 render:function(item){
				           		 if(item.course){
				           			 if (item.course.lessonCount && item.course.passedLessonCount) {
				           			 	return "" + (parseInt(item.course.lessonCount) - parseInt(item.course.passedLessonCount));
				           			 }
				           		 }
				           	 }
				         },
				         { display : '限额人数', minWidth:60,name : 'passedLessonCount',isSort:false,
			            	 render:function(item){
				           		 if(item.course){
				           			 return "" + item.course.passedLessonCount;
				           		 }
				           	 }
				         },
				         { display : '地区', minWidth:60,name : 'areaName',isSort:false,
			            	 render:function(item){
				           		 if(item.location){
				           			 return item.location.areaName;
				           		 }
				           	 }
				         },
				         { display : '服务中心', minWidth:60,name : 'servicecenterName',isSort:false,
			            	 render:function(item){
				           		 if(item.location){
				           			 return item.location.servicecenterName;
				           		 }
				           	 }
				         },
				         { display : '教学点', minWidth:70,name : 'venueName',isSort:false,
			            	 render:function(item){
				           		 if(item.location){
				           			 return item.location.venueName;
				           		 }
				           	 }
				         },
				         { display : '教室', minWidth:70,name : 'classroomName',isSort:false,
			            	 render:function(item){
				           		 if(item.location){
				           			 return item.location.classroomName;
				           		 }
				           	 }
				         },
				         { display : '上课日期', minWidth:120,name : 'courseDate',isSort:false,
				        	 render:function(item){
			            		 if(item.courseDate){
				           			 return format_date(item.courseDate, "yyyy-MM-dd");
				           		 }
				           	 }
				         },
				         { display : '上课时间', minWidth:120,name : '',isSort:false,
			            	 render:function(item){

				           	 }
				         },
				         { display : '课时', minWidth:120,name : 'hours',isSort:false,
			            	 render:function(item){
				           		 if(item.course){
				           			 return item.course.hours;
				           		 }
				           	 }
				         },
				         { display : '所结课次',minWidth:60, name : 'courseNum',isSort:false},
				         { display : '是否为班主任',minWidth:85, name : '',isSort:false,
				        	 render:function(item) {
				        		 if (item.isHeadteacher && item.isHeadteacher == 1) {
			        				 return "是";
			        			 } else {
			        				 return "否";
				        		 }
				        	 }
				         },
				         { display : '修改类型', minWidth:70,name : 'classroomName',isSort:false,
			            	 render:function(item){
				           		 if(item.modifyType){
				           			 return item.modifyType.name;
				           		 }
				           	 }
				         },
				         { display : '修改原因',minWidth:60, name : 'reason',isSort:false},
				         { display : '修改次数',minWidth:70, name : 'modifyTimes',isSort:false,
				        	 render:function(item) {
				        		 if (item.modified) {
				        		 	return item.modified.modifyTimes;
				        		 }
				        	 }
				         },
				         { display : '是否代课',minWidth:70, name : '',isSort:false,
				        	 render:function(item) {
				        		 if (item.isSubstitution && item.isSubstitution == 1) {
			        				 return "是";
			        			 } else {
			        				 return "否";
				        		 }
				        	 }
				         },
				         { display : '是否为额外补课',minWidth:120, name : '',isSort:false,
				        	 render:function(item) {
				        		 if (item.isExtra == 1) {
			        				 return "是";
			        			 } else {
			        				 return "否";
				        		 }
				        	 }
				         },
				         { display : '是否停课',minWidth:70, name : '',isSort:false,
				        	 render:function(item) {
				        		 if (item.isSuspend == 1) {
			        				 return "是";
			        			 } else {
			        				 return "否";
				        		 }
				        	 }
				         },
				         { display : '审核状态',minWidth:85, name : '',isSort:false,
				        	 render:function(item) {
				        		 if (item.status == 1) {
			        				 return "正常";
			        			 } else if (item.status == 2){
			        				 return "待审核";
				        		 } else if (item.status == 3){
			        				 return "已驳回";
				        		 } else if (item.status == 4){
			        				 return "已审核通过";
				        		 } else if (item.status == 5){
			        				 return "已反审核";
				        		 }
				        	 }
				         },
				         { display : '汇总人',minWidth:70, name : '',isSort:false},
				         { display : '审核人',minWidth:70, name : 'auditorName',isSort:false},
				         { display : '操作人',minWidth:70, name : 'modifierName',isSort:false}
				         */
						]
		};
		grid = showGrid(g);
	});
	function f_search() {
		grid.loadData();
	}

	function f_edit(id) {
		dialog = $.ligerDialog.open({ 
	    	url: contextPath + "/py-curriculum/curriculum-modified!toEdit.action?id=" + id,
	    	width: 850,
	    	height: 550,
	    	title: "更改课表",
	    	buttons : [ {
				text : "确定",
				onclick : function(item, dialog) {
				if(typeof dialog.frame.f_submit != 'undefined' )
					dialog.frame.f_submit();
				}
			}, {
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
	    });
	}

	function f_delete(id) {
		confirm("删除操作", "确定删除吗？", function() {
			$.getJSON(
				contextPath + "/py-curriculum/curriculum-modified!delete.action?id="
						+ id, function(json) {
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
	function f_reverse_rejected(id) {
		confirm("反审核操作", "确定反审核吗？", function() {
			$.getJSON(
				contextPath + "/py-curriculum/curriculum-modified!reverseReject.action?id="
						+ id, function(json) {
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
	function f_audit(id) {
		confirm("审核操作", "确定审核吗？", function() {
			$.getJSON(
				contextPath + "/py-curriculum/curriculum-modified!audit.action?id="
						+ id, function(json) {
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
	function f_reject(id) {
		confirm("驳回操作", "确认驳回吗？", function() {
			$.getJSON(
				contextPath + "/py-curriculum/curriculum-modified!reject.action?id="
						+ id, function(json) {
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
							是否停课
						</label>
						<select id="isSuspend" name="condition.isSuspend" class="input-select">
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
						<input id="startDate_start" name="condition.startDateStart" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
					</li>
					<li>
						<label>
							至
						</label>
						<input id="startDate_end" name="condition.startDateEnd" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
					</li>
					<li>
						<label>
							结课日期
						</label>
						<input id="endDate_start" name="condition.endDateStart" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
					</li>
					<li>
						<label>
							至
						</label>
						<input id="endDate_end" name="condition.endDateEnd" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
					</li>
					<li>
						<label>
							导入系统时间
						</label>
						<input id="importTime_start" name="condition.importTimeStart" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
					</li>
					<li>
						<label>
							至
						</label>
						<input id="importTime_end" name="condition.importTimeEnd" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
					</li>
				</ul>
				<ul>
					<li>
						<label>
							上课日期
						</label>
						<input id="lessonDate_start" name="condition.lessonDateStart" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
					</li>
					<li>
						<label>
							至
						</label>
						<input id="lessonDate_end" name="condition.lessonDateEnd" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
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
						<input id="lessonTime_end" name="condition.lessonTimeEnd" type="text" class="Wdate"
						onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'HH:mm:ss'})"/>
					</li>
					<li>
						<label>
							考勤类型
						</label>
						<select id="attendType" name="condition.attendTypeId" class="input-select">
							<option value="">请选择</option>
							<s:iterator value="attendTypes">
								<option value="${id}">${name}</option>
							</s:iterator>
						</select>
					</li>
				</ul>
				<ul>
					<li>
						<label>修改次数</label>
						<input id="modifyTimes" name="condition.modifyTimes" type="text" class="input-text"/>
					</li>
					<li>
						<label>
							审核状态
						</label>
						<select id="status" name="condition.status" class="input-select">
							<option value="">请选择</option>
							<option value="1">正常</option>
							<option value="2">待审核</option>
							<option value="3">已驳回</option>
							<option value="4">已审核通过</option>
							<option value="5">已反审核</option>
						</select>
					</li>
					<li>
						<label>
							是否为额外补课
						</label>
						<select id="isExtra" name="condition.isExtra" class="input-select">
							<option value="">请选择</option>
							<option value="0">否</option>
							<option value="1">是</option>
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
						<input type="reset" id="resetButton" value="重置" class="l-button" />
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
