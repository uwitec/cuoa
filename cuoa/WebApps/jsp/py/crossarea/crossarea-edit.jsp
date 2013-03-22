<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
<script src="<%=contextPath %>/js/class.js" type="text/javascript"></script>
 <script type="text/javascript">
 
 
   	//初始化数据
   	$(function(){
   		fetch_return_class_value("<s:property value='crossArea.courseId'/>");
   		
   		$("#isRecorderAHeadteacher").val(<s:property value='crossArea.isRecorderAHeadteacher'/>);
		$("#ifNoticeToVenue").val(<s:property value='crossArea.ifNoticeToVenue'/>);
   		$("#ifNoticeToSupervise").val(<s:property value='crossArea.ifNoticeToSupervise'/>);
   		
		var verifyYearMonth = "<s:property value='crossArea.verifyYearMonth'/>";
		if (verifyYearMonth.length == 7) {
			$("#verify_year").val(verifyYearMonth.split("-")[0]);
			$("#verify_month").val(verifyYearMonth.split("-")[1]);
		}
   		
   		setTimeout(function() {
   			$("#lessonNo").val(<s:property value='crossArea.lessonNo'/>);
   			lessonNoOnchange();
   		},2000); 
   		
   	});
 
 
    	//提交
         function f_submit(){
         
             //验证输入值 
			if(!verify())
			return;
         
        	if($("form.validate").valid()){
	        	var param=$("form.validate").serialize();
	        	$.post(contextPath + "/py-crossarea/crossarea!edit.action", param, function(json){
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

			//取消
			function f_cancel()
			{
				closeWindow();
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
	

	        var replaceTeacherArray=$('input:radio[name="replaceTeacherName"]:checked').val(); 
	       
	        if(replaceTeacherArray == ""||typeof(replaceTeacherArray) == "undefined")
	         {
	         		alert("请选择跨点上课老师");
	   				return false;
	         }	
	
			$("#summaryCurrId").val(replaceTeacherArray.split(",")[0]);

	
			var ifNoticeToVenue = $("#ifNoticeToVenue").val();
			if(ifNoticeToVenue==""||reg.test(ifNoticeToVenue)){  alert("请选择通知教学点！ ","warn");	return false;}  
			
			var ifNoticeToSupervise = $("#ifNoticeToSupervise").val();
			if(ifNoticeToSupervise==""||reg.test(ifNoticeToSupervise)){  alert("请选择通知督查！","warn");	return false;}  
	
			var recorderName = $("#recorderName").val();
			if(recorderName==""||reg.test(recorderName)){  alert("请填写记录入！","warn");	return false;}  
			
			var reasonForModify =  $("#reasonForModify").val();
			if(reasonForModify==""||reg.test(reasonForModify)){  alert("请输入修正原因","warn");	return false;}  
			if(reasonForModify.length>200)  {  alert("修改原因应在200字符以内!","warn");	return false;}  

	    	return true;
	     }
		
		
		
		    //接受班级查询结果
			function fetch_return_class_value(courseId) {
		       	var param={"queryCourseCondition.id":courseId};   	
		       	var initJson = {"courseNameCt":"name","courseIdCt":"courseId","lessonNoCt":"lessonNo","type":1};
		       	fetch_return_class_value_deal(param,initJson);
			}
		

                
          //课次变更
          function lessonNoOnchange()
          {
          	var courseId = $("#courseId").val();
          	var courseNum = $("#lessonNo").val();
          	var param={"condition.courseId":courseId,"condition.courseNum":courseNum};
    		lessonNoOnchange_deal(param,"replaceTeacherName","<s:property value='crossArea.summaryCurrId'/>");
          }

          
    </script>
</head>

<body>
 <form class="l-form validate">
    <div class="content">
    	<ul>
    		<li>
    			<input type="hidden" name="crossArea.id" value="<s:property value='crossArea.id'/>">
    			<input type="hidden" name="crossArea.courseId" id="courseId" value="<s:property value='crossArea.courseId'/>">
    			<input type="hidden" name="crossArea.verifyYearMonth" id="verifyYearMonth" value="<s:property value='crossArea.verifyYearMonth'/>">
    			<input type="hidden" name="crossArea.summaryCurrId" id="summaryCurrId" value="<s:property value='crossArea.summaryCurrId'/>">
    			
    			<label>确认年月：</label>
    			<select id="verify_year"   class="input-select">
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
    			<label>课次：</label>
  				<select id="lessonNo" name="crossArea.lessonNo" class="input-select" onchange="lessonNoOnchange()">
					<option value="">请选择</option>
				</select>
    		</li>
    	</ul>
    	
    	<ul id="classInfoUL"></ul>  	
    	

    	<ul>	
			<li>
					<label>
						通知教学点：
					</label>
					<select id="ifNoticeToVenue" name="crossArea.ifNoticeToVenue" class="input-select">
						<option value="">请选择</option>
						<option value="1">已通知</option>
						<option value="0">未通知</option>
					</select>
			</li>
			<li>
					<label>
						通知督查：
					</label>
					<select id="ifNoticeToSupervise" name="crossArea.ifNoticeToSupervise" class="input-select">
						<option value="">请选择</option>
						<option value="1">已通知</option>
						<option value="0">未通知</option>
					</select>
			</li>
			<li>
				<label>记录人：</label>
    			<input type="text"  name="crossArea.recorderName" id="recorderName"  class="required input-text" value="<s:property value='crossArea.recorderName'/>" />
			</li>
    	</ul>
    	<ul>
    		<li>
    		   	<span style="font-weight: bold; vertical-align: top;">备注：</span>	
    		</li>
    	</ul>    
    	<ul>
    		<li>
    			<textarea rows="11" cols="100" readonly="readonly"><s:property value='crossArea.remark'/></textarea>		
    		</li>
    	</ul>    			
    	<ul>
    		<li>
    		   	<span style="font-weight: bold; vertical-align: top;">跨点原因：</span>		
    		</li>
    	</ul>
    	<ul>
    		<li>
    			<textarea  rows="11" cols="100" readonly="readonly"><s:property value='crossArea.reasonForCross'/></textarea>		
    		</li>
    	</ul>    	
    	<ul>
    		<li>
    		   	<span style="font-weight: bold; vertical-align: top;">修改原因：</span>
    		</li>
    	</ul>    
    	<ul>
    		<li>
    			<textarea name="crossArea.reasonForModify" id="reasonForModify" rows="11" cols="100"></textarea>		
    		</li>
    	</ul>       		
    </div>
    </form>
</body>
</html>