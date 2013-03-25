<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
	<style type="text/css">
		.l-button {width:80px; height:26px; float:none; margin-left:10px; padding-bottom:2px;}
	</style>
    <script type="text/javascript">
    
         function f_submit(){
         	if($('input:radio[name="condition.importRange"]:checked').val() =='pages' )
         	{
	         	var pageTotal =  $("#pageTotal").val();
	         	var pageNums = $("#pageNums").val();
	         	if(parseInt(pageNums)>parseInt(pageTotal))
	         		{	alert("您填写的页数超过总页数，请重新填写！");
	         			return
	         		}
	         	$("#pageSize").attr("name","condition.pageSize");	
         	}
         
        	if($("form.validate").valid()){
	        	var param=$("form.validate").serialize();
	        	path = contextPath + $("#requestUrlE", window.parent.document).val();
	        	$("#submitButton").attr("disabled", true);
	        	$("#submitButton").val("正在处理，请稍候");
	        	$.post(path, param, function(json) {
					if(json.jumpType){
						alertt("请点击<a href='"+json.jumpUrl+"'"+"> 下载 </a>下载您导出的数据!", "");
					} else {
						alert(json.returnMessage, "");
					}
					$("#submitButton").attr("disabled", false);
					$("#submitButton").val("确定导出");
				},
			'json');
			} 
         }
         
         function checkPageNums(num) {
        	 if (num == 1) {
        		 $("#pageNums").attr("disabled", true);
        		 $("#batchIds").val("");
        	 } else if (num == 2 || num == 3) {
        		 $("#pageNums").attr("disabled", true);
        		 $("#batchIds").val($("#batchIds", window.parent.document).val());
        	 } else {
        		 $("#pageNums").attr("disabled", false);
        		 $("#batchIds").val("");
        	 }
         }
         function checkRadioForAdditionalRecording() {
        	 var requestUrlE = $("#requestUrlE", window.parent.document).val();
			//如果是以下四个模块的导出功能，可以有“导出补录”选项，否则不显示此选项
        	 if (requestUrlE.indexOf("py-courseleave/courseleave!") != -1
        			 || requestUrlE.indexOf("py-courselate/courselate!") != -1 
        			 || requestUrlE.indexOf("py-rejectcourse/rejectcourse!") != -1) { 
        		 //如果角色不是考勤员，也不显示“导出补录”选项
        		 $("#export_param_div > input[name='condition.role']").each(function(i) {
        			 if ($(this).val() != 2) {
        				 $("#arUl").remove();
            			 return;
        			 }
        		 });
        		 
	        	 var batchIds = $("#batchIds", window.parent.document).val();
	        	 if(batchIds == "" || batchIds.split(",").length != 1) {
	        		 $("#additionalRecording").attr("disabled", true);
	        		 $("#ar").html("<span style='color:#666'>补录导出(只有在选择项数目为1的情况下可用)</span>");
	        	 }
        	 } else {
        		 $("#arUl").remove();
        	 }
         }
         $(document).ready(function(){
        	 checkPageNums(2);
        	 //从父页面中取得params放置于此页面hidden中
        	 fetchValuesInHidden();
        	 //检查补录方式Radio是否可用
        	 checkRadioForAdditionalRecording();
        	 
         });
         function fetchValuesInHidden() {
        	 $($("#export_param_div", window.parent.document)).clone().appendTo("#exportForm");
         }
    </script>
</head>

<body>
 <form id="exportForm" class="l-form validate">
 	<input type="hidden" id="batchIds" name="condition.ids"/>
 	<div class="content">
		<ul>
    		<li>
    			<input type="radio" value="all" name="condition.importRange" onclick="checkPageNums(1)" id="all"/><label for="all">所有页</label>
    		</li>
    	</ul>
		<ul>
    		<li>
    			<input type="radio" value="selected" name="condition.importRange" onclick="checkPageNums(2)" checked="checked" id="selected"/><label for="selected">选中项</label>
    		</li>
    	</ul>
		<ul>
    		<li>
    			<input type="radio" value="pages" name="condition.importRange" onclick="checkPageNums(0)" id="pages"/><label for="pages">页</label>
    			<input name="condition.pageNums" id="pageNums" style="width:240px;"/>
    		</li>
    		<li>
				(输入页码或页范围。例如 1-6 或 1,3,6)
			</li>
		</ul>
		<ul id="arUl">
    		<li>
    			<input type="radio" value="additionalRecording" id="additionalRecording" name="condition.importRange" onclick="checkPageNums(3)"/><label id="ar" for="additionalRecording">补录导出</label>
    		</li>
		</ul>
    </div>
    </form>
    <div>
    	<input type="button" id="submitButton" class="l-button" value="确定导出" onclick="f_submit()" style="width:120px;">
    </div>
</body>
</html>