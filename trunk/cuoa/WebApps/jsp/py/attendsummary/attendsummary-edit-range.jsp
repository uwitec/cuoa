<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
    <script type="text/javascript">
         function f_submit(){
 
        	if($("form.validate").valid()){
        		$("#verifyYearMonth").val($("#verify_year").val() + "-" + $("#verify_month").val());
        		
	        	var param=$("form.validate").serialize();
				$.post(contextPath + "/py-attendsummary/attendSummary!editRange.action", param, function(json) {
						if(json.success){
							alertt(json.message,"success");
						  	home_fresh();
						  	closeWindow();
						}else{
							alertt(json.message,"error");
						}
					},
				'json');
			} 
          }
   	  	
          $(document).ready(function(){
           	 var verifyYearMonth = "<s:property value='range.verifyYearMonth'/>";
           	 if (verifyYearMonth.length == 7) {
           		 $("#verify_year").val(verifyYearMonth.split("-")[0]);
           		 $("#verify_month").val(verifyYearMonth.split("-")[1]);
           	 }
          });
          
    </script>
</head>

<body>
 <form class="l-form validate">
    <div class="content">
    	<ul>
    		<li>
    			<input type="hidden" name="range.id" value="<s:property value='range.id'/>">
				<input type="hidden" id="verifyYearMonth" name="range.verifyYearMonth" value="<s:property value='range.verifyYearMonth'/>">
				
    			<s:if test="range.id != null && range.id != ''">
    				<label>考勤年月</label>
    				<input id="verify_year" readonly style="border:0px;width:50px;text-align:right;vertical-align:bottom;" />年
    				<input id="verify_month" readonly style="border:0px;width:30px;text-align:right;vertical-align:bottom;"/>月
    			</s:if>
    			<s:else>
    				<label>考勤年份</label>
	    			<select id="verify_year" name="verify_year" class="required input-select">
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
					<select id="verify_month" name="verify_month" class="required input-select">
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
				</s:else>
    		</li>
    	</ul>

		<ul>
			<li>
				<label>开始日期</label>
				<input id="startTime" name="range.startDate" type="text" class="required Wdate" value="<fmt:formatDate value='${range.startDate}' pattern='yyyy-MM-dd'/>"
				onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
			</li>
		</ul>
		<ul>
			<li>
				<label>结束日期</label>
				<input id="endTime" name="range.endDate" type="text" class="required Wdate" value="<fmt:formatDate value='${range.endDate}' pattern='yyyy-MM-dd'/>"
				onFocus="WdatePicker({isShowClear:false,readOnly:true})"/>
			</li>
		</ul>
    </div>
    </form>
    <div class="content">
		<ul>
	   		<li>
	   			<input type="button" id="queryButton" value="确认" class="l-button"  onclick="f_submit()"/>
				<input type="button"" id="resetButton" value="取消" class="l-button" onclick="closeWindow();" />
	   		</li>
	   	</ul>
	</div>

    
</body>
</html>