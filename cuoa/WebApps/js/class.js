  
var classDialog ; //班级消息框
var teacherDialog;	//教师消息框  


//弹出消息框，查询教师信息
//回调 fetch_return_value(teacherId, techerName, isHeadteacher)
function f_seachTeacher(isHeadteacher) {
	    var path;
	    var caption;
	    if (isHeadteacher == 0) {
	    	path = contextPath + "/common/common!toSearchTeacher.action";
	    	caption = "查找老师系统姓名";
	    } else {
	    	path = contextPath + "/common/common!toSearchHeadteacher.action";
	    	caption = "查找班主任系统姓名";
	    }
		teacherDialog = $.ligerDialog.open({ 
	    	url: path,
	    	height:450,
	    	width: 630,
	    	title: caption,
	    	buttons:[  {
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
	    });
  }

//弹出消息框，查询班级信息
//回调 function fetch_return_class_value(courseId)
function f_seachClass()
{
  var path = contextPath +"/common/common!toSearchCourse.action";
	var caption = "查找班级信息";
	classDialog = $.ligerDialog.open({ 
	    	url: path,
	    	height:600,
	    	width: 800,
	    	title: caption,
	    	buttons:[  {
				text : "取消",
				onclick : function(item, dialog) {
					dialog.close();
				}
			} ]
	    });
}



/**
 * 构建课次下拉框
 * num : 课次数
 * id : 控件id
 */
function newLessonNo(num,id)
{
	$("#"+id).empty();
	$("#"+id).append("<option value=''>请选择</option>");
	for(var i =1 ;i<=num;i++)
	{
		$("#"+id).append("<option value="+i+">第 "+i+" 次</option>");
	}
}


/**
 * 查询课次信息
 * 
 * @param param  例如：{"condition.courseId":courseId,"condition.courseNum":courseNum}
 * @param curriculumId  最终课表空间Id
 * @param curriculumValue 最终课表值 ，用于初始化
 */
function lessonNoOnchange_deal(param,curriculumId,curriculumValue)
{
	if(param)
  	{
    	$.getJSON(contextPath + "/py-curriculum/curriculum-summary!data.action", param, function(json){
			if(json)
			{
				s_currInfo(json,curriculumId,curriculumValue);
			}else{
				alert("error");
			}				
		});
	}		
}


//班级返回结果处理



/**
 * 班级返回结果处理
 * @param param  json对象
 * @param courseName  班级控件ID
 * @param CourseId  课程控件ID
 * @param value 通用值
 * @param type 通用类型  1 ：课程控件ID  2: 班级Id 
 */
function fetch_return_class_value_deal(param,initJson) {
  	$.getJSON(contextPath + "/common/common!searchCourse.action", param, function(json){
		if(json)
		{
			var course = (json.data)[0];
			    $("#"+initJson.courseNameCt).val(course.name);
	          	$("#"+initJson.courseIdCt).val(course.id)
	          	
	          	if(initJson.type == 1)
	          	{
		          	//控制下拉框
		          	newLessonNo(course.passedLessonCount,initJson.lessonNoCt);
		          	s_classInfo(course);
	          	}
	          	else if(initJson.type == 2)
	          	{
	          		s_classInfo_choose_teacher(course,initJson.teacherId);
	          	}
	          	
	          	else
	          	{
	          		alert("错误"); 
	          		return;
				}
	          	if(classDialog)
	          	classDialog.close();
		}else{
				if(classDialog)
				classDialog.close();
				alert("error");
		}				
	});
}




//显示班级信息
  function s_classInfo(course)
  {
          	var html = "";
          	html = html + "<li>";
		   	html = html + "<label>班级信息</label>";
		  	html = html + "<table width='100%' border='1' cellspacing='1' cellpadding='1' style=' font-family: 宋体, Arial; font-size: 12px;' >";
		  	html = html + "	<tr>";
		  	html = html + "		<td > <label>班级名称</label></td>";
	    	if(course.courseName)
			  	html = html + "		<td colspan='3'> "+course.courseName+"</td>";
	    	else
	    		html = html + "		<td colspan='3'></td>";		  	
		  	html = html + "	</tr>";
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>学期</label></td>";
	    	if(course.termName)
	    		html = html + "		<td>"+course.termName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	html = html + "		<td><label>教师</label></td>";
	    	if(course.teacherNames)
			  	html = html + "		<td>"+course.teacherNames+"</td>";
	    	else
	    		html = html + "		<td ></td>";			  	
		  	html = html + "	</tr>";
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>学部</label></td>";
	    	if(course.gtName)
			  	html = html + "		<td>"+course.gtName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>班主任</label></td>";
	    	if(course.headteacherName)
			  	html = html + "		<td>"+course.headteacherName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";	    		
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>年级</label></td>";
	    	if(course.gradeName)
			  	html = html + "		<td>"+course.gradeName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>地区</label></td>";
	    	if(course.areaName)
			  	html = html + "		<td>"+course.areaName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>学科</label></td>";
	    	if(course.subjectNames)
			  	html = html + "		<td>"+course.subjectNames+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>服务中心</label></td>";
	    	if(course.servicecenterName)
			  	html = html + "		<td>"+course.servicecenterName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";	    		
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>班次</label></td>";
	    	if(course.classlevelName)
			  	html = html + "		<td>"+course.classlevelName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>教学点</label></td>";
	    	if(course.venueName)
			  	html = html + "		<td>"+course.venueName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>开班时间</label></td>";		  	
	    	if(course.createTime)
			  	html = html + "		<td>"+course.createTime+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>教室</label></td>";
	    	if(course.classroomName)
			  	html = html + "		<td>"+course.classroomName+"</td>";
	    	else
	    		html = html + "		<td ></td>";		  	
		  	html = html + "	</tr>";	    		
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>开课日期</label></td>";	  	
	    	if(course.startDate)
			  	html = html + "		<td>"+course.startDate+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>总课次</label></td>";
	    	if(course.lessonCount)
			  	html = html + "		<td>"+course.lessonCount+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>结课日期</label></td>";	  	
	    	if(course.endDate)
			  	html = html + "		<td>"+course.endDate+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>已上课次</label></td>";
	    	if(course.passedLessonCount)
			  	html = html + "		<td>"+course.passedLessonCount+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";	    		
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>限额人数</label></td>";	  	
	    	if(course.passedLessonCount)
			  	html = html + "		<td>"+course.passedLessonCount+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>剩余课次</label></td>";
	    	if(course.remainCount)
			  	html = html + "		<td>"+course.remainCount+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>课时</label></td>";
		  	html = html + "		<td>"+course.hours+"</td>";	  	
	    	if(course.hours)
			  	html = html + "		<td>"+course.hours+"</td>";
	    	else
	    		html = html + "		<td ></td>";		  	
		  	html = html + "		<td><label>上课时间</label></td>";
		  	html = html + "		<td></td>";
		  	html = html + "	</tr>";	    			    			    			    		
		  	html = html + "</table>";
		  	html = html + "</li>";
		  	html = html + "<li id = 'currInfoLI' >";
			html = html + "</li>";
		  	
          $("#classInfoUL").html("");
          $("#classInfoUL").html(html);
     }
  
//显示班级信息
  function s_classInfo_choose_teacher(course,teacherId)
  {
          	var html = "";
          	html = html + "<li>";
		   	html = html + "<label>班级信息</label>";
		  	html = html + "<table width='100%' border='1' cellspacing='1' cellpadding='1' style=' font-family: 宋体, Arial; font-size: 12px;' >";
		  	html = html + "	<tr>";
		  	html = html + "		<td > <label>班级名称</label></td>";
	    	if(course.courseName)
			  	html = html + "		<td colspan='3'> "+course.courseName+"</td>";
	    	else
	    		html = html + "		<td colspan='3'></td>";		  	
		  	html = html + "	</tr>";
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>学期</label></td>";
	    	if(course.termName)
	    		html = html + "		<td>"+course.termName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	html = html + "		<td><label>教师</label></td>";
	    	if(course.teacherNames)
			  	html = html + "		<td>"+course.teacherNames+"</td>";
	    	else
	    		html = html + "		<td ></td>";			  	
		  	html = html + "	</tr>";
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>学部</label></td>";
	    	if(course.gtName)
			  	html = html + "		<td>"+course.gtName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>班主任</label></td>";
	    	if(course.headteacherName)
			  	html = html + "		<td>"+course.headteacherName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";	    		
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>年级</label></td>";
	    	if(course.gradeName)
			  	html = html + "		<td>"+course.gradeName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>地区</label></td>";
	    	if(course.areaName)
			  	html = html + "		<td>"+course.areaName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>学科</label></td>";
	    	if(course.subjectNames)
			  	html = html + "		<td>"+course.subjectNames+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>服务中心</label></td>";
	    	if(course.servicecenterName)
			  	html = html + "		<td>"+course.servicecenterName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";	    		
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>班次</label></td>";
	    	if(course.classlevelName)
			  	html = html + "		<td>"+course.classlevelName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>教学点</label></td>";
	    	if(course.venueName)
			  	html = html + "		<td>"+course.venueName+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>开班时间</label></td>";		  	
	    	if(course.createTime)
			  	html = html + "		<td>"+course.createTime+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>教室</label></td>";
	    	if(course.classroomName)
			  	html = html + "		<td>"+course.classroomName+"</td>";
	    	else
	    		html = html + "		<td ></td>";		  	
		  	html = html + "	</tr>";	    		
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>开课日期</label></td>";	  	
	    	if(course.startDate)
			  	html = html + "		<td>"+course.startDate+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>总课次</label></td>";
	    	if(course.lessonCount)
			  	html = html + "		<td>"+course.lessonCount+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>结课日期</label></td>";	  	
	    	if(course.endDate)
			  	html = html + "		<td>"+course.endDate+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>已上课次</label></td>";
	    	if(course.passedLessonCount)
			  	html = html + "		<td>"+course.passedLessonCount+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";	    		
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>限额人数</label></td>";	  	
	    	if(course.passedLessonCount)
			  	html = html + "		<td>"+course.passedLessonCount+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "		<td><label>剩余课次</label></td>";
	    	if(course.remainCount)
			  	html = html + "		<td>"+course.remainCount+"</td>";
	    	else
	    		html = html + "		<td ></td>";	
		  	
		  	html = html + "	</tr>";
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>课时</label></td>";
		  	html = html + "		<td>"+course.hours+"</td>";	  	
	    	if(course.hours)
			  	html = html + "		<td>"+course.hours+"</td>";
	    	else
	    		html = html + "		<td ></td>";		  	
		  	html = html + "		<td><label>上课时间</label></td>";
		  	html = html + "		<td></td>";
		  	html = html + "	</tr>";
		  	html = html + "	<tr>";
		  	html = html + "		<td><label>请选择老师</label></td>";
		  	html = html + "		<td colspan='3'>";
		  	
		  	//添加班主任选项
		  	if(course.headteacherId)
		  	{
    			html = html +	"<input name='teacherId' type='radio' value='"+course.headteacherId+","+course.headteacherName+",1'  " ;
				if(course.headteacherId == teacherId) html = html + " checked='checked' " ;
				html = html	+"/>"+course.headteacherName+"(班主任)";
		  	}
				
		  //添加老师选项
		  	if(course.teacherIds&&course.teacherNames)	
		  		var teacherIds = course.teacherIds.split(",");
		  		var teacherNames = course.teacherNames.split(",");
		  		
		  		for(var i=0 ; i<teacherIds.length;i++)
		  		{
	    			html = html +	"<input name='teacherId' type='radio' value='"+teacherIds[i]+","+teacherNames[i]+",0'  " ;
	    			if(teacherId == teacherIds[i]) html = html + " checked='checked' " ;
	    			html = html	+"/>"+teacherNames[i]+"(教师)";
		  		}		  	
		  	html = html + 		"</td>";
		  	html = html + "	</tr>";	  
		  	html = html + "</table>";
		  	html = html + "</li>";
		  	html = html + "<li id = 'currInfoLI' >";
			html = html + "</li>";
		  	
          $("#classInfoUL").html("");
          $("#classInfoUL").html(html);
     }  
  
  
  
  /**
   * 构建课次信息 和教师多选
   * @param currJson 所有最终课表集合
   * @param curriculumId  	课表ID，单选初始化
   * @param curriculumValue 课表值，单选初始化
   */
  function s_currInfo(currJson,curriculumId,curriculumValue)
  {
	 var data = currJson.data;
	 var curr = data[0];
	 
	 var html = "";
  			html = html + "<label>课次信息</label>";
		  	html = html + "<table width='100%' border='1' cellspacing='2' cellpadding='2' style=' font-family: 宋体, Arial; font-size: 12px;' >";
	    	html = html + "	<tr>";
	    	html = html + "		<td><label>上课日期</label></td>";
	    	
	    	if(curr.courseDate)
	    		html = html + "		<td>"+curr.courseDate+"</td>";
	    	else
	    		html = html + "		<td></td>";
	    	
	    	html = html + "		<td><label>教师</label></td>";
	    	
	    	if(curr.teacherName)
	    		html = html + "		<td>"+curr.teacherName+"</td>";
	    	else
	    		html = html + "		<td></td>";
	    	
	    	html = html + "	</tr>";
	    	html = html + "	<tr>";
	    	html = html + "		<td><label>上课时间</label></td>";
	    	
	    	if(curr.courseTime)
	    		html = html + "		<td colspan='3'>"+curr.courseTime+"</td>";
	    	else
	    		html = html + "		<td colspan='3'></td>";
	    	
	    	html = html + "	</tr>";	    		
	    	html = html + "	<tr>";
	    	html = html + "		<td><label>教室</label></td>";
	    	
	    	if(curr.classroomName)
	    		html = html + "		<td>"+curr.classroomName+"</td>";
	    	else
	    		html = html + "		<td></td>";
	    		
	    	html = html + "		<td><label>班主任</label></td>";
	    	
	    	if(curr.headteacherName)
	    		html = html + "		<td>"+curr.headteacherName+"</td>";
	    	else
	    		html = html + "		<td></td>";
	    	
	    	html = html + "	</tr>";	
	    	html = html + "	<tr>";
	    		
	    	html = html + "		<td><label>确认考勤课次</label></td>";
	    	html = html + "		<td  colspan='3'>";
	    	
	    	
	    	for(var i = 0 ;i<data.length;i++ )
	    	{
	    		if(data[i].isHeadteacher == 1&&data[i].headteacherName)
	    		{
	    			html = html +	"<input name='"+curriculumId+"' type='radio' value='"+data[i].id+"'  " ;
	    			if(curriculumValue == data[i].id) html = html + " checked='checked' " ;
	    			html = html	+"/>"+data[i].headteacherName+"(班主任)";
	    		}	
	    		else(data[i].isHeadteacher == 0&&data[i].teacherName)
	    		{
	    			html = html +	"<input name='"+curriculumId+"' type='radio' value='"+data[i].id+"'  " 
	    			if(curriculumValue == data[i].id) html = html + " checked='checked' " ;
	    			html = html	+	"/>"+data[i].teacherName+"(老师)";
	    		}	
	    	}
	    	
	    	html = html + "		</td>";
	    	html = html + "	</tr>";
	    	html = html + "</table>";
           
            $("#currInfoLI").html("");
 			$("#currInfoLI").html(html);       
  }