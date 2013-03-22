<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
<script src="<%=contextPath %>/ligerui/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>
<script src="<%=contextPath %>/js/class.js" type="text/javascript"></script>
    <script type="text/javascript">
    
    	          

    
   	//初始化数据
   	$(function(){
   		fetch_return_class_value("<s:property value='late.courseId'/>");
 //  		$("#remark").val("<s:property value='leave.remark'/>");
   		$("#isHeadTeacher").val(<s:property value='late.isHeadTeacher'/>);
   		$("#type").val(<s:property value='late.lateType'/>);
   		setTimeout(function() {
   			$("#lessonNo").val(<s:property value='late.lessonNo'/>);
   			lessonNoOnchange();
   		},2000); 
   		
   	});
	
   	$(document).ready(function(){
   	 	var verifyYearMonth = "<s:property value='late.verifyYearMonth'/>";
   	 	if (verifyYearMonth.length == 7) {
	   		 $("#verify_year").val(verifyYearMonth.split("-")[0]);
	   		 $("#verify_month").val(verifyYearMonth.split("-")[1]);
   	 	}
   	});
 
   	//提交
	function f_submit(){
	
		         
		//验证输入值 
		if(!verify())
		return;      
		
       	if($("form.validate").valid()){
        	var param=$("form.validate").serialize();
        	$.post(contextPath + "/py-courselate/courselate!edit.action", param, function(json){
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
			if(verify_year==""||reg.test(verify_year)){  alert("请选择确认年份！","warn");	return false;}  
			
			var verify_month = $("#verify_month").val();
			if(verify_month==""||reg.test(verify_month)){  alert("请选择确认月份！","warn");	return false;}  

	         //班级验证
	        var courseId = $("#courseId").val();
			if(courseId==""||reg.test(courseId)){  alert("请选择班级！","warn");	return false;}  
	
	         var lessonNo = $("#lessonNo").val();
			if(lessonNo==""||reg.test(lessonNo)){  alert("请选择班次！","warn");	return false;}  
	
			//验证迟到老师
	        var replaceTeacherArray=$('input:radio[name="replaceTeacherName"]:checked').val();        
	        if(replaceTeacherArray == ""||typeof(replaceTeacherArray) == "undefined")
	         {
	         		alert("请选择迟到老师");
	   				return false;
	         }	
			$("#summaryCurrId").val(replaceTeacherArray.split(",")[0]);
	
	
			var actualTime = $("#actualTime").val();
			if(actualTime==""||reg.test(actualTime)){  alert("请选择迟到时间！ ","warn");	return false;}  
			
			var lateType = $("#lateType").val();
			if(lateType==""||reg.test(lateType)){  alert("请选择迟到类型！","warn");	return false;}  
			
			var reasonForModify =  $("#reasonForModify").val();
			if(reasonForModify==""||reg.test(reasonForModify)){  alert("请填写修改原因！","warn");	return false;}  
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
		lessonNoOnchange_deal(param, "replaceTeacherName", "<s:property value='late.summaryCurrId'/>");
    }
      		
    </script>
</head>

<body>
 <form class="l-form validate">
    <div class="content">
    	<ul>
    		<li>
    			<input type="hidden" name="late.courseId" value="<s:property value='late.courseId'/>" id="courseId">
    			<input type="hidden" name="late.id" value="<s:property value='late.id'/>" >
    			<input type="hidden" id="verifyYearMonth" name="late.verifyYearMonth" value="<s:property value='late.verifyYearMonth'/>" >
    			<input type="hidden" id="summaryCurrId" name="late.summaryCurrId" value="<s:property value='late.summaryCurrId'/>" >
    			
    			
    			<label>确认年月</label>
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
    			<input type="text"  name="name" id="name" value="<s:property value='late.course.name'/>" class="required input-text"  readonly="readonly"/>
    		</li>
    		<li>
				<a href="javascript:f_seachClass()">查找班级名称</a>
    		</li>
    		<li>
    			<label>迟到课次：</label>
  				<select id="lessonNo" name="late.lessonNo" class="input-select" onchange="lessonNoOnchange()">
					<option value="">请选择</option>
				</select>
    		</li>
    	</ul>
		<ul id="classInfoUL"></ul>  
    	<ul>

    	</ul>  		
    	<ul>
    		<li>迟到时间:
	    		<input id="actualTime" name="late.actualTime" type="text" class="input-text" value="<fmt:formatDate value='${late.actualTime}' pattern='HH:mm:ss'/>"  />
					<img onclick="WdatePicker({el:'actualTime',dateFmt:'HH:mm:ss'})"
						src="<%=contextPath%>/js/my97/skin/datePicker.gif" width="16"
						height="22" align="absmiddle">
    		</li>
    		<li>
				<label>
					迟到类型
				</label>
				<select id="lateType" name="late.lateType" class="input-select">
					<option value="">请选择</option>
					<option value="1">课前迟到</option>
					<option value="2">课后迟到</option>
					<option value="0">缺勤</option>
				</select>
    		</li>
    	</ul>	
    	<ul>
    		<li>
    		   	<span style="font-weight: bold; vertical-align: top;">迟到原因</span>
    		</li>
    	</ul>   	
    	<ul>
    		<li>
    			<textarea name="late.reason"  rows="11" cols="100" readonly="readonly" ><s:property value='late.reason'/></textarea>		
    		</li>
    	</ul>
		<ul>
    		<li>
    		   	<span style="font-weight: bold; vertical-align: top;">修改原因</span>
    		</li>
    	</ul>    	
		<ul>
    		<li>
    			<textarea name="late.reasonForModify" rows="11" cols="100" id="reasonForModify"></textarea>		
    		</li>
    	</ul>	
    </div>
    </form>
</body>
</html>