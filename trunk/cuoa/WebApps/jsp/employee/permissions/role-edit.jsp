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
	        	$.post(contextPath + "/permissions/permissionManage!modifyRole.action", param, function(json) {
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
   	  	
          $(document).ready(function(){
        	 
          });
          
          
           //验证 
	     function verify(){
	    	return true;
         } 
          
    </script>
</head>

<body>
 <form class="l-form validate">
    <div class="content">
    	<ul>
    		<li>
    			<INPUT type="hidden" name="role.id" value="<s:property value='role.id'/>"/>

    			<label>角色名</label>
    			<input type="text" name="role.name" value="<s:property value='role.name'/>" class="input-text required" />
    		</li>
    	</ul>
    </div>
    </form>
</body>
</html>