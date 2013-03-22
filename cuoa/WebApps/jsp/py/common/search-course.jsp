<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%@include file="/include/header.inc"%>	
<script src="<%=contextPath %>/js/class.js" type="text/javascript"></script>		
		<script type="text/javascript">
		
	var grid = null;


	$(function() {
	
			//初始化联动空间的name值			
			$("#city").attr("name","queryCourseCondition.cityNo");
			$("#area").attr("name","queryCourseCondition.areaId");
			$("#serviceCenter").attr("name","queryCourseCondition.servicecenterId");
			$("#venue").attr("name","queryCourseCondition.venueId");
			$("#classroom").attr("name","queryCourseCondition.classroomId");
			
			$("#year").attr("name","queryCourseCondition.year");
			$("#term").attr("name","queryCourseCondition.termId");
			$("#gradeType").attr("name","queryCourseCondition.gtId");
			$("#grade").attr("name","queryCourseCondition.gradeId");
			$("#subject").attr("name","queryCourseCondition.subjectIds");
			$("#classLevel").attr("name","queryCourseCondition.classlevelId");
	
	
		var path = contextPath + "/common/common!searchCourse.action";;
		var g = {
			gridid : "maingrid",
			condition : "queryCourseCondition",
			url : path,
			formid:"conditionForm",
			frozen: true,
			showToggleColBtn: false,
			checkbox : false,
			rownumbers:false,
			columns : [{ display: "操作", minWidth:40, name: "",
					render: function(item) {
	         			if (item.isModified != 1) {
	                    	html ="<a href='javascript:link_event(\""+item.id+"\")' class='linkbutton'>选择</a>";
	         			}
	                    return html;
	               }
			   },
			  	{ display : '班级名称',minWidth:200, name : 'name',isSort:false},
		        { display : '老师',minWidth:60, name : 'teacherNames',isSort:false},
		        { display : '学期',minWidth:60, name : 'termName',isSort:false},
		         { display : '班主任', minWidth:60,name : 'headteacherName',isSort:false},
		         { display : '开课日期', minWidth:80,name : 'startDate',isSort:false},
		         { display : '结课日期', minWidth:80,name : 'endDate',isSort:false},
		         { display : '上课时间', minWidth:80,name : 'courseTimeNames',isSort:false}      
			  ]
		};
		grid = showGrid_top(g);
	});
	
	
			//查询班级
			function f_search() {
				 grid.loadData();
			}
	
		function link_event(id)
		{
			parent.fetch_return_class_value(id);
			var cc=$(".l-dialog-tc .l-dialog-close", window.parent.document).click();
		}
		
		
         function fetch_return_value(teacherId, techerName, isHeadteacher) {
       	  if (isHeadteacher == 0) {
	        	  $("#teacherIds").val(teacherId);
	        	  $("#teacherNames").val(techerName);
         	  } else {
         		  $("#headteacherId").val(teacherId);
        	  	  $("#teacherNames").val(techerName);
         	  }
         }
	
	     //查找老师
		function  f_seach_course_teacher ()
		{		
			f_seachTeacher($('input:radio[name="isHeadTeacher"]:checked').val());
		} 
	
		//是否班主任radio变动
        function   course_teacher_isHeadteacher_onchange()
        {
        	$("#headteacherId").val("");
	        $("#teacherIds").val("");
	        $("#teacherNames").val("");
        } 	
	
</script>
	</head>
	<body>
			<form id="conditionForm">
			<div class="content">
				<ul>
					<li>
						<input type="hidden" name="queryCourseCondition.teacherIds" id="teacherIds" />
						<input type="hidden" name="queryCourseCondition.headteacherId"  id="headteacherId" />
					</li>
				</ul>
				<ul>
					<li>
						<label>
							班级名称
						</label>
						<input type="text" name="queryCourseCondition.name" id="name" class="input-text" />
					
					<li>
						<label>
								教师:
						</label>
						<input type="text"  id="teacherNames" class="input-text" readonly="readonly"/>
	    				<input  type="radio" value=0 name="isHeadTeacher" onchange="course_teacher_isHeadteacher_onchange()"  checked="checked"> 普通老师
	    				<input  type="radio" value=1 name="isHeadTeacher" onchange="course_teacher_isHeadteacher_onchange()" > 班主任	
						<a href="javascript:f_seach_course_teacher()" >查找教师</a>
					</li>
				</ul>
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
						<input id="startDate_start" name="queryCourseCondition.startDateStart" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'startDate_start'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							至
						</label>
						<input id="startDate_end" name="queryCourseCondition.startDateEnd" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'startDate_end'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							结课日期
						</label>
						<input id="endDate_start" name="queryCourseCondition.endDateStart" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'endDate_start'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
					</li>
					<li>
						<label>
							至
						</label>
						<input id="endDate_end" name="queryCourseCondition.endDateEnd" type="text" class="input-text" />
						<img onclick="WdatePicker({el:'endDate_end'})"
							src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
							height="22" align="absmiddle">
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