<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
   <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
<%String contextPath = request.getContextPath();%>

<script type="text/javascript">
//<![CDATA[
var contextPath = "<%=contextPath %>";
//]]>
</script>
<link href="<%=contextPath %>/ligerui/ligerUI/skins/Aqua/css/ligerui-all.css" rel="stylesheet" type="text/css" media="screen" />
<link href="<%=contextPath %>/ligerui/ligerUI/skins/ligerui-icons.css" rel="stylesheet" type="text/css" />
<link href="<%=contextPath %>/css/attend.css" rel="stylesheet" type="text/css" media="screen" />
<script src="<%=contextPath %>/ligerui/jquery/jquery-1.5.2.min.js" type="text/javascript"></script>
<script src="<%=contextPath %>/ligerui/jquery-validation/jquery.validate.min.js" type="text/javascript"></script> 
<script src="<%=contextPath %>/ligerui/jquery-validation/jquery.metadata.js" type="text/javascript"></script>
<script src="<%=contextPath %>/ligerui/jquery-validation/messages_cn.js" type="text/javascript"></script>
<script src="<%=contextPath %>/ligerui/ligerUI/js/ligerui.all.js" type="text/javascript"></script>
<script src="<%=contextPath %>/js/jquery.uploadify.v2.1.4.js" type="text/javascript"></script>
<script src="<%=contextPath %>/js/swfobject.js" type="text/javascript"></script>
<script src="<%=contextPath %>/js/linkage-menu.js" type="text/javascript"></script>
<script src="<%=contextPath %>/js/my97/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript">
//<![CDATA[
$(document).ready(function(){
	loadBasicLinkage();
	loadLocationLinkage();
});

//]]>
</script>
<script src="<%=contextPath %>/js/attend.js" type="text/javascript"></script>
<script src="<%=contextPath %>/js/jquery-extends.js" type="text/javascript"></script>