<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
	<style type="text/css">
		.l-button {width:80px; height:26px; float:none; margin-left:10px; padding-bottom:2px;}
	</style>
    <script type="text/javascript">
         function f_submit(){
        	if($("form.validate").valid()){
        		$("#verifyYearMonth").val($("#verifyYear").val() + "-" + $("#verifyMonth").val());
	        	var param=$("form.validate").serialize();
	        	path = contextPath + "/py-attendsummary/attendSummary!generate.action",
	        	$("#submitButton").attr("disabled", true);
	        	$("#submitButton").val("正在处理，请稍候");
	        	$("#verifyYear").attr("disabled", true);
	        	$("#verifyMonth").attr("disabled", true);
	        	$("#startDate").attr("disabled", true);
	        	$("#endDate").attr("disabled", true);
	        	
	        	$.post(path, param, function(json) {
	        		if(json.success){
						alert(json.message,"success");
					  	home_fresh();
					  	closeWindow();
					}else{
						alert(json.message,"error");
					}
					$("#submitButton").attr("disabled", false);
					$("#submitButton").val("确定");
					$("#verifyYear").attr("disabled", false);
		        	$("#verifyMonth").attr("disabled", false);
					$("#startDate").attr("disabled", false);
		        	$("#endDate").attr("disabled", false);
				},
			'json');
			} 
         }
         
         $(document).ready(function(){
        	
         });
    </script>
</head>

<body>
	<div class="content">
 		<ul>
 			<li>请选择生成考勤的时间区间</li>
 		</ul>
 		<form id="exportForm" class="l-form validate">
	 		<ul>
	 			<li>
					<label>考勤年份</label>
	    			<select id="verifyYear" name="record.year" class="required input-select">
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
				</li>
			</ul>
			<ul>
				<li>
					<label>考勤月份</label>
					<select id="verifyMonth" name="record.month" class="required input-select">
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
 		
 			<input type="hidden" id="verifyYearMonth" name="record.verifyYearMonth">
			<ul>
	    		<li>
					<label>
						开始日期
					</label>
					<input id="startDate" name="record.startDate" type="text" class="required Wdate"
					onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
				</li>
	    	</ul>
			<ul>
	    		<li>
					<label>
						截止日期
					</label>
					<input id="endDate" name="record.endDate" type="text" class="required Wdate"
					onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
				</li>
	    	</ul>
	    </form>
    </div>
    <div>
    	<input type="button" id="submitButton" class="l-button" value="确定" onclick="f_submit()" style="width:120px;">
    </div>
</body>
</html>