<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
<script src="<%=contextPath %>/ligerui/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>

    <script type="text/javascript">

	//保存
	//提交
	function f_submit(){
	     //验证输入值 
		if(!verify())
		return;   
	
       	if($("form.validate").valid()){
       		setVerifyYearMonth();
        	var param=$("form.validate").serialize();
        	$.post(contextPath + generateURL(), param, function(json){
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
	
	function setVerifyYearMonth() {
		$("#verifyYearMonth").val($("#verify_year").val() + "-" + $("#verify_month").val());
	}
	
	function generateURL() {
		var thisURL = document.location.href;
		var part_1 = thisURL.split("!")[0];
		var array = part_1.split("/");
		return "/" + array[array.length-2]+"/"+array[array.length-1] + "!edit.action";
	}
	
	$(document).ready(function(){
   	 	var verifyYearMonth = "<s:property value='additional.verifyYearMonth'/>";
   	 	if (verifyYearMonth.length == 7) {
	   		 $("#verify_year").val(verifyYearMonth.split("-")[0]);
	   		 $("#verify_month").val(verifyYearMonth.split("-")[1]);
   	 	}
   	});
   	
   		 //验证 
     function verify()
     {
     	var reg = /^\s*$/; //不能为空 
     	 
     	var addHours =$('#addHours').val(); 
     	if(addHours==""||reg.test(addHours)){	alert("请输入修正课时","warn");  	return false;}  
         	
   		var re = /^[+-]?\d+(.\d)?$/;   //判断字符串是否为小数,保留一位       
   		if (!re.test(addHours)){ alert("修正课时应为整数或保留一位小数。例如：1.5","warn"); 	return false;}
    	
    	var addReason =$('#addReason').val(); 
     	if(addReason==""||reg.test(addReason)){  alert("请输入补差原因","warn");	return false;}  
    	if(addReason.length>200)  {  alert("补差原因,应在200字符以内!","warn");	return false;}  

		var addTargetDate = $("#addTargetDate").val();
		if(addTargetDate==""||reg.test(addTargetDate)){  alert("请选择补录指向日期！","warn");	return false;}  

		var verify_year = $("#verify_year").val();
		var verify_month = $("#verify_month").val();
		if(verify_year == ""||verify_month == "")
		{	
			alert("请输入选择确认年月");
    		return  false;
    	}
		$("#verifyYearMonth").val(verify_year+"-"+verify_month);

    	return true;
     }
   	
   	
    </script>
</head>

<body>
 	<form id="conditionForm"  class="l-form validate" method="post">
 		 <input type="hidden" name="additional.id" value="<s:property value='additional.id'/>" >
 	     <input type="hidden" id="verifyYearMonth" name="additional.verifyYearMonth" value="<s:property value='additional.verifyYearMonth'/>" >
   		 <div class="content">
   		 	<ul>
   		 		<li>
   		 			<span style="font-weight: bold; vertical-align: top;">补差扣课时：</span>
   		 			<input id="addHours" name="additional.addHours" value="<s:property value='additional.addHours'/>" type="text">
   		 		</li>
    		</ul>
    		<ul>
	   		 	<li>
	    		   	<span style="font-weight: bold; vertical-align: top;">补差原因：</span>
	    			<textarea id="addReason"  name="additional.addReason" rows="11" cols="100"><s:property value="additional.addReason"/></textarea>		
	    		</li>
	    	</ul>
	    	<ul>	
	   		 	<li>补录指向日期:
	    			<input id="addTargetDate" name="additional.addTargetDate" type="text" class="input-text" value="<fmt:formatDate value='${additional.addTargetDate}' pattern='yyyy-MM-dd'/>" 
	    			onFocus="WdatePicker({isShowClear:false,readOnly:true,dateFmt:'yyyy-MM-dd'})" />
						
    			</li>
    			<li>
	    			<label>确认年月</label>
	    			<select id="verify_year"  class="input-select">
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
				</li>
	    	</ul>
	    	
	    	<ul>
	    		<li style="text-align:center;"> 
    			    <input type="button" id="submitButton" value="确认" class="l-button"  onclick="f_submit()"/>
					<input type="button"" id="resetButton" value="取消" class="l-button" onclick="f_cancel()" />
    			</li>
    		</ul>
   		 </div>
    </form>
</body>
</html>