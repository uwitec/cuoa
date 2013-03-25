<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>
		<script type="text/javascript">
		
	var grid = null;
	var toolbar = {
		items : [
					{ text: '增加', click: f_add , icon:'add'},
					{ line:true },
	                { text: '导出Excel', click: excel,icon:'outbox' },
	                { line:true },
	                { text: '一并导出', click: excel_all,icon:'outbox' }   
	            ]
	};
	function f_add(){
		var win = {
				title : "增加特殊课次",
				width : 850,
				url : contextPath + "/py-speciallesson/speciallesson!toAdd.action",
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
		};
		showWindow(win);
	}
    function excel(item) {
        alert(item.text);
    }
    function excel_all() {
    	alert();
    }
	$(function() {
		var g = {
			gridid : "maingrid",
			conditon : "condition",
			url : contextPath + "/py-speciallesson/speciallesson!data.action",
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			toolbar : toolbar,
			checkbox : false,
			columns : [{display : '确认年月', minWidth:60,  name : 'confirmDate',isSort:false}, 
			           { display: '分校', name: 'name',isSort:false,
			           	    render:function(item){
			           		    if((item.course) && (item.course.location) && (item.course.location.city)){
			           			    return item.course.location.city.name;
			           		    }
			           	    }
			            },
						{ display : '老师姓名',minWidth:60, name : 'realName',isSort:false,
			            	 render:function(item){
				           		 if((item.curriculum) && (item.curriculum.teacher)){
				           			 return item.curriculum.teacher.realName;
				           		 }
				           	 }
				         },
				         { display : '系统姓名',minWidth:60, name : 'name',isSort:false,
			            	 render:function(item){
				           		 if((item.curriculum) && (item.curriculum.teacher)){
				           			 return item.curriculum.teacher.name;
				           		 }
				           	 }
				         },
				         { display : '教师编号',minWidth:60, name : 'code',isSort:false,
			            	 render:function(item){
				           		 if((item.curriculum) && (item.curriculum.teacher)){
				           			 return item.curriculum.teacher.code;
				           		 }
				           	 }
				         },
				         { display : '班主任',minWidth:60, name : 'headteacherName',isSort:false,
			            	 render:function(item){
				           		 if(item.course){
				           			 return item.course.headteacherName;
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
				         { display : '服务中心', minWidth:60,name : 'servicecenterName',isSort:false,
			            	 render:function(item){
				           		 if(item.course && item.course.location){
				           			 return item.course.location.servicecenterName;
				           		 }
				           	 }
				         },
				         { display : '教室', minWidth:70,name : 'classroomName',isSort:false,
			            	 render:function(item){
				           		 if(item.course && item.course.location){
				           			 return item.course.location.classroomName;
				           		 }
				           	 }
				         },
				         { display : '上课时间', minWidth:120,name : 'classroomName',isSort:false,
			            	 render:function(item){
				           		 if(item.curriculum && item.curriculum.coursetime){
				           			 return item.curriculum.coursetime.timeName;
				           		 }
				           	 }
				         },
				         { display : '课时', minWidth:40,name : 'hours',isSort:false,
			            	 render:function(item){
				           		 if(item.course){
				           			 return item.course.hours;
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
				         { display : '所结课次',minWidth:60, name : 'verifyNo',isSort:false},
				         { display : '代课课次',minWidth:60, name : '',isSort:false},
				         { display : '是否为班主任',minWidth:85, name : '',isSort:false,
				        	 render:function(item) {
				        		 if (item.isHeadteacher) {
				        			 if (item.isHeadteacher == 1) {
				        				 return "是";
				        			 } else {
				        				 return "否";
				        			 }
				        		 }
				        	 }
				         }
						]
		};
		grid = showGrid(g);
	});
	function f_search() {
		grid.loadData();
	}

	function f_edit(id) {
		var win = {
			title : "编辑课程小类",
			width : 850,
			url : "${basePath}basic/coursetype-child!toEdit.action?coursetype.id="
					+ id,
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
		};
		showWindow(win);
	}

	function f_delete(id) {
		confirm("删除操作", "确认删除吗？", function() {
			$.getJSON(
					"${basePath}basic/coursetype-child!delete.action?coursetype.id="
							+ id, function(json) {
						if (json.success) {
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
							原上课日期
						</label>
						<input id="systemLessonDate_start" name="condition.systemLessonDateStart" type="text"
							class="input-text" />
						<img onclick="WdatePicker({el:'systemLessonDate_start'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							至
						</label>
						<input id="systemLessonDate_end" name="condition.systemLessonDateEnd" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'systemLessonDate_end'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							系统导入时间
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
							类别
						</label>
						<select id="specialType" name="condition.specialType" class="input-select">
							<option value="">请选择</option>
							<option value="修改上课老师">
								修改上课老师
							</option>
							<option value="修改上课时间">
								修改上课时间
							</option>
						</select>
					</li>
				</ul>
				<ul>
					<li>
						<label>
							是否修改
						</label>
						<select id="idModified" name="condition.idModified" class="input-select">
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
							是否作废
						</label>
						<select id="idDeleted" name="condition.isDeleted" class="input-select">
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
						<input type="button" id="queryButton" value="查询" class="l-button" onclick="f_search()"/>
						<input type="reset"" id="resetButton" value="重置" class="l-button" />
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
