<%@ page language="java" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@include file="/include/header.inc"%>
    <script type="text/javascript">
         function f_submit(){
        	if($("form.validate").valid()){
	        	var param=$("form.validate").serialize();
	        	path = contextPath + $("#requestUrlE", window.parent.document).val();
	        	$.post(path, param, function(json) {
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
         
         function uploadifyUpload(){
             var fileQueueHtml = $("#fileQueue").html();
             if (fileQueueHtml == "") {
            	 alert("上传文件不能为空");
            	 return;
             }
        	 $("#import_button").attr("disabled", true);
  		   	 $('#uploadModify').uploadifyUpload(); 
  		 } 

         $(document).ready(function(){
        	 $("#uploadModify").uploadify({ 
                 /*注意前面需要书写path的代码*/ 
                 'uploader'       : contextPath + "/images/uploadify.swf", 
                 'script'         : contextPath + "<s:property value='#parameters.importAction'/>",
                 'cancelImg'      : contextPath + "/images/cancel.png", 
                 'queueID'        : 'fileQueue', //和存放队列的DIV的id一致 
                 'fileDataName'   : 'uploadModify', //和以下input的name属性一致 
                 'auto'           : false, //是否自动开始 
                 'multi'          : true, //是否支持多文件上传 
                 'buttonText'     : '浏览', //按钮上的文字 
                 'simUploadLimit' : 1, //一次同步上传的文件数目 
                 'sizeLimit'      : 19871202, //设置单个文件大小限制 
                 'queueSizeLimit' : 1, //队列中同时存在的文件个数限制 
                 'fileDesc'       : '支持格式:xlsx/xls.', //如果配置了以下的'fileExt'属性，那么这个属性是必须的 
                 'fileExt'        : '*.xlsx;*.xls;',//允许的格式   
                 onComplete: function (event, queueID, fileObj, response, data) { 
     				var json = eval("(" + response + ")");
     				if(json.success){
						alert(json.message,"success");
					  	home_fresh();
					  	closeWindow();
					}else{
						alert(json.message,"error");
						$("#import_button").attr("disabled", false);
					}
     			}, 
     			onError: function(event, queueID, fileObj) { 
     	            dialog("提示","text:"+response.returnMessage,300,"auto","","");
     	        }, 
     	        onCancel: function(event, queueID, fileObj){ 
     	       		dialog("提示","text:"+response.returnMessage,300,"auto","","");
     	      	} 
     		}); 
         });

    </script>
</head>

<body>
 	<div class="content">
		<ul>
			<li>
    			<input type="file" id="uploadModify" name="uploadModify"/>
    		</li>
    		<li style="width:30px;">
    		</li>
    		<li>
				<div id="fileQueue"></div>
				<ol class=files></ol> 
			</li>
		</ul>
		<ul>
			<li>
				<input type="button" id="import_button" value="确定导入" class="l-button" onclick="uploadifyUpload()"/>
			</li>
			<li>
				<input type="button" value="取消" class="l-button" onclick="closeWindow()"/>
			</li>
		</ul>
    </div>
</body>
</html>