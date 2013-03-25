<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
<script src="<%=contextPath %>/js/class.js" type="text/javascript"></script>
 <script type="text/javascript">
 
    	//提交
         function f_submit(){
         
			//验证输入值 
			if(!verify())
			return;        
		
        	if($("form.validate").valid()){
	        	var param=$("form.validate").serialize();
	        	$.post(contextPath + "/py-courseleave/courseleave!add.action", param, function(json){
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
	        var courseId = $("#courseId").val();
			if(courseId==""||reg.test(courseId)){  alert("请选择班级！","warn");	return false;}  
	
	         var lessonNo = $("#lessonNo").val();
			if(lessonNo==""||reg.test(lessonNo)){  alert("请选择班次！","warn");	return false;}  
	
	
			//验证员班老师和请假老师
	
			var leaveIsHeadTeacher ;	//请假老师是否是班主任
			var replaceIsHeadTeacher ;	//接课老师是否是班主任	
	
			//接课老师验证
	        var replaceTeacherArray=$('input:radio[name="replaceTeacherName"]:checked').val(); 
	        if(replaceTeacherArray == ""||typeof(replaceTeacherArray) == "undefined")
	         {
	         		alert("请选择替课老师");
	   				return false;
	         }	

			$("#curriculumId").val(replaceTeacherArray.split(",")[0]);
			replaceIsHeadTeacher = replaceTeacherArray.split(",")[1];
	
	
			var leaveDate = $("#leaveDate").val();
			if(leaveDate==""||reg.test(leaveDate)){  alert("请选择缺课日期！ ","warn");	return false;}  
			
			var leaveTeacherId = $("#leaveTeacherId").val();
			if(leaveTeacherId==""||reg.test(leaveTeacherId)){  alert("请选择请假老师！","warn");	return false;}  
	
			var remark =  $("#remark").val();
			if(remark==""||reg.test(remark)){  alert("请选择班主任备注！","warn");	return false;}  	
	
			var dateOfAskForLeave = $("#dateOfAskForLeave").val();
			if(dateOfAskForLeave==""||reg.test(dateOfAskForLeave)){  alert("请选择请假时间！","warn");	return false;}  
			
			var type = $("#type").val();
			if(type==""||reg.test(type)){  alert("请选择请假类型！","warn");	return false;}  
			
			var reason =  $("#reason").val();
			if(reason==""||reg.test(reason)){  alert("请填写请假原因！","warn");	return false;}  
			if(reason.length>200)  {  alert("请假原因应在200字符以内!","warn");	return false;}  

			//判断原班老师和请假老师职位是否相同
			leaveIsHeadTeacher = $('input:radio[name="isHeadTeacher"]:checked').val();	
			if(leaveIsHeadTeacher != replaceIsHeadTeacher)
			{	
				alert("替课老师和请假老师职位不同，请重新选择");
				return false;
			}
	    	return true;
	     }
		
		    //接受班级查询结果
			function fetch_return_class_value(courseId) {
		       	var param={"queryCourseCondition.id":courseId};   	
		       	var initJson = {"courseNameCt":"name","courseIdCt":"courseId","lessonNoCt":"lessonNo","type":1};
		       	fetch_return_class_value_deal(param,initJson);
			}
		
      	  
      	  //教师返回值
          function fetch_return_value(teacherId, techerName, isHeadteacher) {
	       	  $("#leaveTeacherId").val(teacherId);
	          $("#teacherName").val(techerName);
          }
                
          //课次变更
          function lessonNoOnchange()
          {
          	var courseId = $("#courseId").val();
          	var courseNum = $("#lessonNo").val();
          	var param={"condition.courseId":courseId,"condition.courseNum":courseNum};
    		lessonNoOnchange_deal(param,"replaceTeacherName","");
          }

		//查找老师
		function  f_seach_isHeadteacher()
		{
			f_seachTeacher($('input:radio[name="isHeadTeacher"]:checked').val());
		}
          
         //是否班主任radio变更 
        function   teacher_isHeadteacher_onchange()
        {
        	$("#leaveTeacherId").val("");
	        $("#teacherName").val("");
        }
          
    </script>
</head>

<body>
 <form class="l-form validate">
    <div id="content" class="content">
    	<ul>
    		<li>
	   			<input type="hidden" name="leave.courseId" id="courseId">
    			<input type="hidden" name="leave.verifyYearMonth" id="verifyYearMonth">
    			<input type="hidden" name="leave.curriculumId" id="curriculumId">
    			<input type="hidden" name="leave.leaveTeacherId" id ="leaveTeacherId">
    			
    			<label>确认年月:</label>
    			<input id="verify_year" readonly class="no-border-year" />年
    			<input id="verify_month" readonly class="no-border-month" />月
    			<%--<select id="verify_year"   class="input-select">
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
				<select id="verify_month"   class="input-select">
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
    	<ul>
    		<li>
    			<label>班级名称：</label>
    			<input type="text"  name="name" id="name"  class="required input-text"  readonly="readonly"/>
    		</li>
    		<li>
				<a href="javascript:f_seachClass()">查找班级名称</a>
    		</li>
    		<li>
    			<label>缺勤课次：</label>
  				<select id="lessonNo" name="leave.lessonNo" class="input-select" onchange="lessonNoOnchange()">
					<option value="">请选择</option>
				</select>
    		</li>
    	</ul>
    	
    	<ul id="classInfoUL"></ul>  	
    	
    	<ul>
    		<li>缺课日期 :
    			<input id="leaveDate" name="leave.leaveDate" type="text" class="Wdate input-text"
    			 onFocus="WdatePicker({isShowClear:false,readOnly:true});changeVerifyYearMonth(this, 'verify_year', 'verify_month');"/>
    		</li>
    	</ul>
    	<ul>	
    		<li>请假老师:<input type="text"  id="teacherName" class="input-text" readonly="readonly" />
    			<input name ="isHeadTeacher" type="radio" value=0 checked="checked" onchange="teacher_isHeadteacher_onchange()"> 老师
    			<input name ="isHeadTeacher" type="radio" value=1 onchange="teacher_isHeadteacher_onchange()"> 班主任
    			<a href="javascript:f_seach_isHeadteacher()" >查找教师姓名</a>
    		</li>
    		<li>
    			<label>
					班主任备注:
				</label>
				<select id="remark" name="leave.remark" class="input-select">
					<option value="">请选择</option>
					<option value="1">正常请假</option>
					<option value="-1">取消请假</option>
				</select>
    		</li>
    	</ul>	
    	<ul>
    		<li>请假时间:
	    		<input id="dateOfAskForLeave" name="leave.dateOfAskForLeave" type="text" class="input-text" />
					<img onclick="WdatePicker({el:'dateOfAskForLeave',dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
						height="22" align="absmiddle">
    		</li>
    		<li>
				<label>
					请假类型:
				</label>
				<select id="type" name="leave.type" class="input-select">
							<option value="">请选择</option>
							<option value="1">开课前48小时（含48小时）以上</option>
							<option value="2">开课前24小时（含24小时）到48小时之间</option>
							<option value="3">课前24-12小时内请假</option>
							<option value="4">课前12-6小时内请假</option>
							<option value="5">课前6-2小时内请假</option>
							<option value="6">课前2小时内请假</option>
							<option value="0">未请假</option>
				</select>
    		</li>
    	</ul>	
    	<ul>
    		<li>
    		   	<span style="font-weight: bold; vertical-align: top;">请假原因:</span>	
    		</li>
    	</ul>
    	<ul>
    		<li>
    			<textarea name="leave.reason" rows="11" cols="100" id = "reason" ></textarea>		
    		</li>
    		<div style="clear:both;"></div>
    	</ul>
    	<div style="clear:both;"></div>    	
    </div>
    </form>

</body>
</html>