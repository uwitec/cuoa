<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
    <script type="text/javascript">
         function f_submit(){

			//验证输入值 
			if(!verify())
			return;  

        	if($("form.validate").valid()){
	        	var param=$("form.validate").serialize();        	
	        	$.post(contextPath + "/py-curriculum/curriculum-modified!editModified.action", param, function(json) {
					if(json.success){
						alert(json.message,"success");
					  	home_fresh();
					  	closeWindow();
					}else{
						alert(json.message,"error");
					}
				},
			'json');
			} 
          }
   	  	//把联动的数据保存到hidden
         function set_hidden_before_submit() {
        	 $("#areaId").val($("#area").val());
        	 $("#servicecenterId").val($("#serviceCenter").val());
        	 $("#venueId").val($("#venue").val());
        	 $("#classroomId").val($("#classroom").val());
         }
          $(document).ready(function(){
           	 var verifyYearMonth = "<s:property value='cmd.verifyYearMonth'/>";
           	 if (verifyYearMonth.length == 7) {
           		 $("#verify_year").val(verifyYearMonth.split("-")[0]);
           		 $("#verify_month").val(verifyYearMonth.split("-")[1]);
           	 }
          });
          $(document).ready(function(){
        	  load_location("<s:property value='cmd.location.cityNo'/>", 
        			  "<s:property value='cmd.location.areaId'/>", 
        			  "<s:property value='cmd.location.servicecenterId'/>", 
        			  "<s:property value='cmd.location.venueId'/>", 
        			  "<s:property value='cmd.location.classroomId'/>");
        	  $("#city").hide();
			  $("#modifyType").val("<s:property value='cmd.modifyTypeId'/>");
			  $("#reason").val("<%=request.getAttribute("cmd.reason")%>");
          });
          
          var teacherDialog;
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
        	    	height:380,
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
          function fetch_return_value(teacherId, techerName, isHeadteacher) {
        	  if (isHeadteacher == 0) {
	        	  $("#teacherId").val(teacherId);
	        	  $("#teacherName").val(techerName);
          	  } else {
          		  $("#headteacherId").val(teacherId);
	        	  $("#headteacherName").val(techerName);
          	  }
        	  
          }
          function f_clear_headteacher() {
        	  $("#headteacherId").val("");
        	  $("#headteacherName").val("");
          }
          
          
           //验证 
	     function verify()
	     {
	     	var reg = /^\s*$/; //不能为空 
		
			//确认年月验证
			var verify_year = $("#verify_year").val();
			var verify_month = $("#verify_month").val();
			if(verify_year == ""||verify_month == "")
			{	
				alert("请输入选择确认年月");
	    		return  false;
	    	}
	    	
	    	var teacherId = $("#teacherId").val();
			if(teacherId==""||reg.test(teacherId)){  alert("请选择老师！","warn");	return false;}  
	
	    	set_hidden_before_submit();
	    	
	    	var areaId = $("#areaId").val();
	    	if(areaId==""||reg.test(areaId)){  alert("请选择地区！","warn");	return false;}  
	    	
        	var servicecenterId = $("#servicecenterId").val();
        	if(servicecenterId==""||reg.test(servicecenterId)){  alert("请选择服务中心！","warn");	return false;}  
        	
        	var venueId = $("#venueId").val();
        	if(venueId==""||reg.test(venueId)){  alert("请选择教学点！","warn");	return false;}  
        	
        	var classroomId = $("#classroomId").val();
        	if(classroomId==""||reg.test(classroomId)){  alert("请选择教室！","warn");	return false;}  
	    	
	    	var courseDate = $("#courseDate").val();
        	if(courseDate==""||reg.test(courseDate)){  alert("请选择上课日期！","warn");	return false;}  
        	
        	var startTime = $("#startTime").val();
        	if(startTime==""||reg.test(startTime)){  alert("请选择开始的上课时间！","warn");	return false;}  
        	     	
        	var endTime = $("#endTime").val();
        	if(endTime==""||reg.test(endTime)){  alert("请选择结束的上课时间！","warn");	return false;}  
        	
        	var modifyType = $("#modifyType").val();
        	if(modifyType==""||reg.test(modifyType)){  alert("请选择修改类型！","warn");	return false;}  
    	
	    	var reason =  $("#reason").val();
			if(reason==""||reg.test(reason)){  alert("请填写修改原因！","warn");	return false;}  
			if(reason.length>200)  {  alert("修改原因应在200字符以内!","warn");	return false;}  
	    	
	    	return true;
         } 
          
    </script>
</head>

<body>
 <form class="l-form validate">
    <div class="content">
    	<ul>
    		<li>
    			<input type="hidden" name="cm.cmdId" value="<s:property value='cmd.id'/>">
    			<input type="hidden" name="cm.currId" value="<s:property value='cmd.curriculumId'/>">
    			<input type="hidden" name="cm.courseNum" value="<s:property value='cmd.courseNum'/>">
    			<input type="hidden" name="cm.courseId" value="<s:property value='cmd.courseId'/>">
    			<input type="hidden" name="cm.teacherId" id="teacherId" value="<s:property value='cmd.teacher.id'/>"/>
    			<input type="hidden" name="cm.headteacherId" id="headteacherId" value="<s:property value='cmd.headteacherId'/>"/>
    			<input type="hidden" id="isExtra" name="cm.isExtra" value="<s:property value='cmd.isExtra'/>"/>
    			<!-- 联动表单name属性不能更改，装载上课地点联动数据，需提交数据前设置 -->
				<input type="hidden" id="areaId" name="cm.areaId"/>
				<input type="hidden" id="servicecenterId" name="cm.servicecenterId"/>
				<input type="hidden" id="venueId" name="cm.venueId"/>
				<input type="hidden" id="classroomId" name="cm.classroomId"/>
				<input type="hidden" id="attendTypeId" name="cm.attendTypeId"/>
				<input type="hidden" id="isHeadteacher" name="cm.isHeadteacher"/>
				
    			<label>确认年月</label>
    			<input id="verify_year" name="cm.verifyYear" readonly class="no-border-year" />年
    			<input id="verify_month" name="cm.verifyMonth" readonly class="no-border-month" />月
    			<%--<select id="verify_year" name="cm.verifyYear" class="input-select">
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
				<select id="verify_month" name="cm.verifyMonth" class="input-select">
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
    		--%>
	    		<label>分校：</label>
	    		<s:property value="cmd.course.location.cityName"/>
    		</li>
    	</ul>
     	<ul>
    		<li>
	    		<label>针对老师职位：</label>
	    		<s:if test="cmd.isHeadteacher == 1">班主任</s:if>
	    		<s:else>老师</s:else>
    		</li>
    	</ul>      	
    	
    	<ul>
    		<li>
	    		<label>老师系统姓名</label>
	    		<input type="text"  name="" id="teacherName" value="<s:property value='cmd.teacher.name'/>" readonly class="required input-text" />
    			<a href="javascript:f_seachTeacher(0);">查找老师系统姓名</a>
    		</li>
    	</ul>
    	<ul>
    		<li>
    			<label>班级名称</label>
    			<s:property value="cmd.course.name"/>
    		</li>
    		<li>
    			<label>考勤类型</label> 
    			<s:property value="cmd.attendType.name"/>
    		</li>
    	</ul>
    	<ul>
    		<li>
	    		<label>班主任系统姓名</label>
	    		<input type="text"  name="" id="headteacherName" value="<s:property value='cmd.headteacher.name'/>" readonly class="input-text" />
    			<a href="javascript:f_seachTeacher(1);">查找班主任系统姓名</a>
    			<a href="javascript:f_clear_headteacher();">清空</a>
    		</li>
    	</ul>
		<ul>
			<li>
				<label>学期</label>
				<s:property value="cmd.course.basic.termName"/>
				<label>学部</label>
				<s:property value="cmd.course.basic.gtName"/>
				<label>年级</label>
				<s:property value="cmd.course.basic.gradeName"/>
				<label>学科</label>
				<s:property value="cmd.subject.name"/>
				<label>班次</label>
				<s:property value="cmd.course.basic.classlevelName"/>
			</li>
		</ul>
		<!-- 载入班级上课地点联动信息 -->
		<ul id="locationLinkage" class="load">
		</ul>
		<ul>
			<li>
				<label>上课日期</label>
				<input id="courseDate" name="cm.courseDate" type="text" class="Wdate" value="<fmt:formatDate value='${cmd.courseDate}' pattern='yyyy-MM-dd'/>"
				onFocus="WdatePicker({isShowClear:false,readOnly:true});changeVerifyYearMonth(this, 'verify_year', 'verify_month');"/>
			</li>
			<li>
				<label>上课时间</label>
				<input id="startTime" name="cm.startTime" type="text" class="Wdate" value="<fmt:formatDate value='${cmd.startTime}' pattern='HH:mm:ss'/>"
				onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'HH:mm:ss'})"/>
			</li>
			<li>
				<label>到</label>
				<input id="endTime" name="cm.endTime" type="text" class="Wdate" value="<fmt:formatDate value='${cmd.endTime}' pattern='HH:mm:ss'/>"
				onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'HH:mm:ss'})"/>
			</li>
		</ul>
		<s:if test="cm.isExtra==1">
			<ul>
				<li>
					<label>修改类型：额外补课</label>
				</li>
			</ul>
		</s:if>
		<s:else>
			<ul>
				<li>
					<label>修改类型</label>
					<select id="modifyType" name="cm.modifyType">
						<s:iterator value="modifyTypes">
							<s:if test="isDeleted == 0">
								<option value="<s:property value='id'/>"><s:property value="name"/></option>
							</s:if>
						</s:iterator>
					</select>
				</li>
			</ul>
		</s:else>
		<ul>
			<li>
				<label>开班日期</label>
				<fmt:formatDate value='${cmd.course.createTime}' pattern='yyyy-MM-dd'/>
			</li>
			<li>
				<label>开课日期</label>
				<fmt:formatDate value='${cmd.course.startDate}' pattern='yyyy-MM-dd'/>
			</li>
			<li>
				<label>结课日期</label>
				<fmt:formatDate value='${cmd.course.endDate}' pattern='yyyy-MM-dd'/>
			</li>
		</ul>
		<ul>
			<li>
				<label>总课次</label>
				<s:property value="cmd.course.lessonCount"/>
			</li>
			<li>
				<label>已上课次</label>
				<s:property value="cmd.course.passedLessonCount"/>
			</li>
			<li>
				<label>剩余课次</label>
				<s:property value="cmd.course.lessonCount-cmd.course.passedLessonCount"/>
			</li>
			<li>
				<label>限额人数</label>
				<s:property value="cmd.course.limitNumberOfStudent"/>
			</li>
		</ul>
		<ul>
			<li>
				<label>所结课次</label>
				<s:property value="cmd.courseNum"/>
			</li>
			<li>
				<label>课时</label>
				<s:property value="cmd.course.hours"/>
			</li>
		</ul>
    	<ul>
    		<li>
    			<span style="font-weight: bold; vertical-align: top;">修改原因</span>
    			<textarea id="reason" name="cm.reason" rows="11" cols="100"></textarea>
    		</li>
    	</ul>
    </div>
    </form>
</body>
</html>