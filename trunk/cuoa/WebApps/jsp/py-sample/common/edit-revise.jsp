<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
<script src="<%=contextPath %>/ligerui/ligerUI/js/plugins/ligerForm.js" type="text/javascript"></script>

    <script type="text/javascript">


	var isNegative = "<s:property value='#parameters.isNegative'/>"; //是否允许为负数

	//保存
	function f_submit()
	{
		//验证输入值 
		if(!verify())
		return;
		var path = contextPath + "<s:property value='#parameters.reviseAction'/>" ;

       	if($("form.validate").valid()){
        	var param=$("form.validate").serialize();
        	$.post(path, param, function(json){
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
     	 
     	var finalDeductHours =$('#finalDeductHours').val(); 
     	if(finalDeductHours==""||reg.test(finalDeductHours)){	alert("请输入修正课时","warn");  	return false;}  
        
        if(typeof(isNegative) != "undefined"&&isNegative =="1")
        {
			var re = /^[+-]?\d+(.\d)?$/;   //判断字符串是否为小数,保留一位       
    		if (!re.test(finalDeductHours)){ alert("修正课时应为整数或保留一位小数。例如：1.5","warn"); 	return false;}
        }
        else
        {
        	var re = /^[0-9]+([.]{1}[0-9]{1})?$/;   //判断字符串是否为小数,保留一位       
    		if (!re.test(finalDeductHours)){ alert("修正课时应为非负整数或非负保留一位小数。例如：1.5","warn"); 	return false;}
    	}
    	var reasonForRevise =$('#reasonForRevise').val(); 
     	if(reasonForRevise==""||reg.test(reasonForRevise)){  alert("请输入修正原因","warn");	return false;}  
    	
    	if(reasonForRevise.length>200)  {  alert("修改原因,应在200字符以内!","warn");	return false;}  

    	return true;
     }
	

    </script>
</head>

<body>
 	<form id="conditionForm"  class="l-form validate" method="post">
   		 <div class="content">
   		 	<ul>
   		 		<li>
   		 			<span style="font-weight: bold; vertical-align: top;">最终扣课时：</span>
   		 			<input id="finalDeductHours" name="modifyDeductLessonCondition.finalDeductHours" type="text">
   		 		</li>
    		</ul>
    		<ul>	
	   		 	<li>
	    		   	<span style="font-weight: bold; vertical-align: top;">修正原因：</span>
	    		</li>
	    	</ul>
    		<ul>	
	   		 	<li>
	    			<textarea id="reasonForRevise"  name="modifyDeductLessonCondition.reasonForRevise" rows="11" cols="70"></textarea>		
	    		</li>
	    	</ul>	    	
	    	<ul>	
	    		<li>
	    			<input type="hidden" name="modifyDeductLessonCondition.deductId" value="<s:property value='#parameters.deductId'/> "> 
	    			<input type="hidden" name="modifyDeductLessonCondition.entityId" value="<s:property value='#parameters.entityId'/> "> 
    			</li>
    		</ul>
   		 </div>
    </form>
</body>
</html>