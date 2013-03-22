<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
<script src="<%=contextPath %>/js/class.js" type="text/javascript"></script>
 <script type="text/javascript">
 
 		//初始化
 		$(function() {
			$("#year").attr("name","meetingBasic.year");
			$("#term").attr("name","meetingBasic.termId");
			$("#gradeType").attr("name","meetingBasic.gtId");
			$("#grade").attr("name","meetingBasic.gradeId");
			$("#subject").attr("name","meetingBasic.subjectId");
			$("#classLevel").attr("name","");
			$("#classLevel").hide();
		});
 
    	//提交
         function f_submit(){
         
         	//验证输入值 
			if(!verify())
			return;     
         
        	if($("form.validate").valid()){
	        	var param=$("form.validate").serialize();
	        	$.post(contextPath + "/py-meeting/meeting!add.action", param, function(json){
					if(json.success){
						alert(json.message,"success");
					  	home_fresh();
					  	closeWindow();
					}else{
						alert(json.message,"error");
					}
				});
			} 
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
			$("#verifyYearMonth").val(verify_year+"-"+verify_month);
	         
	         //班级验证
	        var year = $("#year").val();
			if(year==""||reg.test(year)){  alert("请选择年份！","warn");	return false;}  
	
	        var term = $("#term").val();
			if(term==""||reg.test(term)){  alert("请选择学期！","warn");	return false;}  
				
	        var gradeType = $("#gradeType").val();
			if(gradeType==""||reg.test(gradeType)){  alert("请选择学部！","warn");	return false;}  
		
	        var grade = $("#grade").val();
			if(grade==""||reg.test(grade)){  alert("请选择年级！","warn");	return false;}  
	
	        var subject = $("#subject").val();
			if(subject==""||reg.test(subject)){  alert("请选择学科！","warn");	return false;}  
	
			var meetingName = $("#meetingName").val();
			if(meetingName==""||reg.test(meetingName)){  alert("请填写会议名称！","warn");	return false;}  
	

			var teacherId = $("#teacherId").val();
			if(teacherId==""||reg.test(teacherId)){  alert("请选择缺勤老师！","warn");	return false;}  
	
	
			var startDate = $("#startDate").val();
			if(startDate==""||reg.test(startDate)){  alert("请选择会议日期 ！ ","warn");	return false;}  
			
			var reviewVideoDeadline = $("#reviewVideoDeadline").val();
			if(reviewVideoDeadline==""||reg.test(reviewVideoDeadline)){  alert("请选择补看录像截止日期！","warn");	return false;}  
	
			var remark = $("#remark").val();
			if(remark==""||reg.test(remark)){  alert("请选择班主任备注！","warn");	return false;}  
			
			var reasonForAbsence =  $("#reasonForAbsence").val();
			if(reasonForAbsence==""||reg.test(reasonForAbsence)){  alert("请填写例会缺勤原因！","warn");	return false;}  
			if(reasonForAbsence.length>200)  {  alert("例会缺勤原因应在200字符以内!","warn");	return false;}  
			
			var reasonForNoReview =  $("#reasonForNoReview").val();
			if(reasonForNoReview==""||reg.test(reasonForNoReview)){  alert("请填写未补看录像原因！","warn");	return false;}  
			if(reasonForNoReview.length>200)  {  alert("未补看录像原因应在200字符以内!","warn");	return false;}  

	    	return true;
	     }

      	  //教师返回值
          function fetch_return_value(teacherId, techerName, isHeadteacher) {
				$("#teacherId").val(teacherId);
	        	$("#teacherName").val(techerName);
          }
                
          
    </script>
</head>

<body>
 <form class="l-form validate">
    <div class="content">
    	<ul>
    		<li>
    			<input type="hidden" name="meeting.teacherId" id ="teacherId">
    			<input type="hidden" name="meeting.verifyYearMonth" id="verifyYearMonth">

    			<label>确认年月:</label>
    			<input id="verify_year" readonly class="no-border-year" />年
    			<input id="verify_month" readonly class="no-border-month" />月
    			<%--<select id="verify_year"  class="input-select">
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
				<select id="verify_month"  class="input-select">
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
    		</li>
    	</ul>
		<!-- 载入班级基本信息联动 -->
		<ul id="basicLinkage">
		</ul>    	
    	<ul>
    		<li>
    			<label>会议名称：</label>
    			<input type="text"  name="meeting.meetingName" id="meetingName"  class="required input-text"  />
    		</li>
    		<li>
    			<label>教师姓名：</label>
    			<input type="text"  id="teacherName"  class="required input-text"  readonly="readonly"/>
    		</li>
    		<li>
				<a href="javascript:f_seachTeacher(0)">查找老师</a>
    		</li>
    	</ul>
    	
    	<ul id="classInfoUL"></ul>  	
    	
    	<ul>
    		<li>
    			<label>
    				会议日期 :
    			</label>
    			<input id="startDate" name="meeting.startDate" type="text" class="Wdate input-text"
    			onFocus="WdatePicker({isShowClear:false,readOnly:true});changeVerifyYearMonth(this, 'verify_year', 'verify_month');"/>
    		</li>
    		
    		<li>
    			<label>
    				补看录像截止日期 :
    			</label>
    			<input id="reviewVideoDeadline" name="meeting.reviewVideoDeadline" type="text" class="input-text"  pattern='yyyy-MM-dd'/>
				<img onclick="WdatePicker({el:'reviewVideoDeadline',dateFmt:'yyyy-MM-dd'})"
					src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
					height="22" align="absmiddle">
    		</li>
    	</ul>
    	<ul>
    	    <li>
    			<label>
					班主任备注:
				</label>
				<select id="remark" name="meeting.remark" class="input-select">
					<option value="">请选择</option>
					<option value="1">正常例会缺勤</option>
					<option value="-1">取消例会缺勤</option>
				</select>
    		</li>

    	</ul>	
    	<ul>
    		<li>
    		   	<span style="font-weight: bold; vertical-align: top;">例会缺勤原因：</span>	
    		</li>
    	</ul>    	
    	<ul>
    		<li>
    			<textarea name="meeting.reasonForAbsence" id="reasonForAbsence" rows="11" cols="100"></textarea>		
    		</li>
    	</ul>
    	<ul>
    		<li>
    		   	<span style="font-weight: bold; vertical-align: top;">未补看录像原因：</span>
    		</li>
    	</ul>
    	<ul>
    		<li>
    			<textarea name="meeting.reasonForNoReview" id="reasonForNoReview" rows="11" cols="100"></textarea>		
    		</li>
    	</ul>    	
    </div>
    </form>
</body>
</html>