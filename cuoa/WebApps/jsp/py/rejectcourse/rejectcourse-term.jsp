<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
    <script type="text/javascript">
         function f_submit(){
			var ids = $("#ids").val();
			var term = $("#term").val();
			$.getJSON(
			contextPath+"/py-rejectcourse/rejectcourse!isTerm.action?ids="+ids+"&reject.termOfRejectCourseId="+term+"&timeStamp="+new Date().getTime(), 
			function(json) {
				if(json.success){
						alert(json.message,"success");
					  	home_fresh();
					  	closeWindow();
					}else{
						alert(json.message,"error");
					}
			});
          }
         
      
    </script>
</head>

<body>
	<form action="">
		<input type="hidden"  name="ids" id="ids" value="<s:property value='condition.ids'/>">
	 	<div class="content">
			<ul>
				<li>
	    			<label>将此甩班学期归属到：</label>
	    		</li>
	    	</ul>
	    	<ul>	
				<li>
	    			<select id="term" name="value" class="input-select">
						<option value=1> 春季班 </option>
						<option value=2> 暑假班 </option>
						<option value=3> 秋季班 </option>
						<option value=4> 寒假班 </option>
					</select>
	    		</li>
			</ul>
			<ul>
				<li>
					<input type="button" id="button" value="确定" class="l-button" onclick="f_submit()"/>
				</li>
				<li>
					<input type="button" value="取消" class="l-button" onclick="closeWindow()"/>
				</li>
			</ul>
	    </div>
    </form>
</body>
</html>