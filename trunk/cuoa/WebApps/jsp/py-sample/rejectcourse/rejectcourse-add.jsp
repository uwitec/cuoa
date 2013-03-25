<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
<script src="<%=contextPath %>/js/class.js" type="text/javascript"></script>
 <script type="text/javascript">
 
 	
 		var isReject = 0;
 
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
	
			var  isHeadTeacher = $('input:radio[name="reject.isHeadTeacher"]:checked').val();
			if(isHeadTeacher==""||reg.test(isHeadTeacher)){  alert("请选择是否班主任！","warn");	return false;}  

			var rejectingTeacherId =  $("#rejectingTeacherId").val();
			if(rejectingTeacherId==""||reg.test(rejectingTeacherId)){  alert("请选择甩班老师！","warn");	return false;} 
	
			var rejectDate = $("#rejectDate").val();
			if(rejectDate==""||reg.test(rejectDate)){  alert("请选择甩班日期！ ","warn");	return false;}  
			
			var rejectCourseType = $("#rejectCourseType").val();
			if(rejectCourseType==""||reg.test(rejectCourseType)){  alert("请选择甩班类型！","warn");	return false;}  
		
			var remark = $("#remark").val();
			if(remark==""||reg.test(remark)){  alert("请选择班主任备注！","warn");	return false;}  
				
			var termOfRejectCourseId =  $("#termOfRejectCourseId").val();
			if(termOfRejectCourseId==""||reg.test(termOfRejectCourseId)){  alert("请选择甩班学期归属！","warn");	return false;}  
			
			var reason =  $("#reason").val();
			if(reason==""||reg.test(reason)){  alert("请输入甩班原因","warn");	return false;}  
			if(reason.length>200)  {  alert("甩班原因,应在200字符以内!","warn");	return false;}  
			
	    	return true;
	     }
 
 
 
    	//提交
         function f_submit(){
         
         	//验证输入值 
			if(!verify())
			return;
         
	       	if($("form.validate").valid()){
	        	var param=$("form.validate").serialize();
	        	$.post(contextPath + "/py-rejectcourse/rejectcourse!add.action", param, function(json){
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
		
	    //接受班级查询结果
		function fetch_return_class_value(courseId) {
	       	var param={"queryCourseCondition.id":courseId};   	
			var initJson = {"courseNameCt":"name","courseIdCt":"courseId","lessonNoCt":"lessonNo","type":1};
			fetch_return_class_value_deal(param,initJson);
		}
		
      	  
     	  //教师返回值
         function fetch_return_value(teacherId, techerName, isHeadteacher) {
         
         	if(isReject==0)
         	{
		        $("#receivingTeacherId").val(teacherId);
		        $("#receivingTeacherName").val(techerName);
         	}
         	else
         	{	
         		$("#rejectingTeacherId").val(teacherId);
		        $("#rejectingTeacherName").val(techerName);
         	}
         }
                
                
                   //课次变更
          function lessonNoOnchange()
          {
          	var courseId = $("#courseId").val();
          	var courseNum = $("#lessonNo").val();
          	var param={"condition.courseId":courseId,"condition.courseNum":courseNum};
    		lessonNoOnchange_deal(param,"","");
          }       
          
	        //查找老师
			function  f_seach_reject_or_receiving (r)
			{
				isReject = r;
			
				f_seachTeacher($('input:radio[name="reject.isHeadTeacher"]:checked').val());
			}  		
	      		 		
	        //是否班主任radio变动
	        function   teacher_isHeadteacher_onchange()
	        {
	        	$("#rejectingTeacherId").val("");
		        $("#rejectingTeacherName").val("");
		        $("#receivingTeacherId").val("");
		        $("#receivingTeacherName").val("");
	        } 	
	        
	        

	        
          
    </script>
</head>

<body>
 <form class="l-form validate">
    <div class="content">
    	<ul>
    		<li>
    			<input type="hidden" name="reject.courseId" id="courseId">
    			<input type="hidden" name="reject.verifyYearMonth" id="verifyYearMonth">
				<input type="hidden" name="reject.rejectingTeacherId" id="rejectingTeacherId" >
				<input type="hidden" name="reject.receivingTeacherId" id="receivingTeacherId" >
 
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
    	<ul>
    		<li>
    			<label>班级名称：</label>
    			<input type="text"  name="name" id="name"  class="required input-text"  readonly="readonly"/>
    		</li>
    		<li>
				<a href="javascript:f_seachClass()">查找班级名称</a>
    		</li>
    		<li>
    			<label>开始甩班的课次：</label>
  				<select id="lessonNo" name="reject.lessonNo" class="input-select" onchange="lessonNoOnchange()">
					<option value="">请选择</option>
				</select>
    		</li>
    	</ul>
    	
    	<ul id="classInfoUL"></ul>  	
    	
    	<ul>    	
    		<li>
    		    <label>
    				是否班主任：
    			</label>
    			<input name ="reject.isHeadTeacher" type="radio" value=0 onchange="teacher_isHeadteacher_onchange()" checked="checked"> 老师
    			<input name ="reject.isHeadTeacher" type="radio" value=1 onchange="teacher_isHeadteacher_onchange()" > 班主任	
    		</li>
    	</ul>
    	<ul>			
    		<li>
    			<label>
    				甩班老师:
    			</label>
    			<input type="text"  id="rejectingTeacherName" class="input-text" readonly="readonly" />
    			<a href="javascript:f_seach_reject_or_receiving(1)" >查找教师姓名</a>
    		</li>
    		<li>
    			<label>
    				甩班日期 :
    			</label>
    			<input id="rejectDate" name="reject.rejectDate" type="text" class="Wdate input-text" 
    			onFocus="WdatePicker({isShowClear:false,readOnly:true});changeVerifyYearMonth(this, 'verify_year', 'verify_month');"/>
    		</li>
    		<li>
				<label>
					甩班类型:
				</label>
				<select id="type" name="reject.rejectCourseType" class="input-select">
					<option value="">请选择</option>
					<option value="1">续报周后至开课前21（不含）天</option>
					<option value="2">开课前21（含）天</option>
					<option value="3">开课后</option>
				</select>
    		</li>
    		
    	</ul>
    	<ul>
        	<li>
    			<label>
    				接课老师:
    			</label>
        		<input type="text"  id="receivingTeacherName" class="input-text" readonly="readonly" />
    			<a href="javascript:f_seach_reject_or_receiving(0)" >查找教师姓名</a>
    		</li>	
    	    <li>
    			<label>
					班主任备注:
				</label>
				<select id="remark" name="reject.remark" class="input-select">
					<option value="">请选择</option>
					<option value="1">正常甩班</option>
					<option value="-1">取消甩班</option>
				</select>
    		</li>
    	</ul>	
    	<ul>
    		<li>
				<label>
					甩班学期归属:
				</label>
				<select id="termOfRejectCourseId" name="reject.termOfRejectCourseId" class="input-select">
					<option value=""> 请选择 </option>
					<option value="1"> 春季班 </option>
					<option value="2"> 暑假班 </option>
					<option value="3"> 秋季班 </option>
					<option value="4"> 寒假班 </option>
				</select>
			</li>		
    	</ul>	
    	<ul>
    		<li>
    		   	<span style="font-weight: bold; vertical-align: top;">甩班原因:</span>
    		</li>
    	</ul>
    	<ul>
    		<li>
    			<textarea name="reject.reason" id="reason" rows="11" cols="100"></textarea>		
    		</li>
    	</ul>    	
    </div>
    </form>
</body>
</html>