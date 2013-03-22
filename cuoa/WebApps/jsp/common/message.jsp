<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%String contextPath = request.getContextPath(); %>
<%String projectRoot = contextPath;
if (!contextPath.equals("/admin") && !contextPath.equals("/servicecenter")) {
	projectRoot = "/admin";
}
%>
<%String cachePath = "http://cache1.xueersi.net" + projectRoot; %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>提示信息!!!!</title>
    <style type="text/css">
		<!--
		body,td,th {
			font-size: 14px;
			color: #000000;
		}
		body {
			margin-left: 0px;
			margin-top: 0px;
			margin-right: 0px;
			margin-bottom: 0px;
			background-color: #F7FCFF;
		}
		.t_bg{
		    position:absolute;top:50%;left:50%;margin:-142px 0 0 -250px; width:500px; height:284px; border:0px;background:url(<%=cachePath %>/images/T.jpg) no-repeat;line-height:25px;
		}
		-->
	</style>
  </head>
    <body>

<div class="t_bg"> 
<br />
    <br />
    <br />
    <br />
  <table width="451" height="142" border="0" cellpadding="0" cellspacing="0">
    <tr>
      <td width="144" height="67">&nbsp;</td>
      <td width="62" align="center"><img src="<%=cachePath %>/images/warning.gif" width="48" height="48" /></td>
      <td width="245">
      	<s:iterator value="actionMessages">
			<s:if test="actionMessages == null">
				系统出现异常情况，请于系统管理员联系。
			</s:if>
			<s:else>
				<s:property escape="false" />
			</s:else>
		</s:iterator>
		<s:fielderror/>
      </td>
    </tr>
    <tr>
      <td height="75">&nbsp;</td>
      <td colspan="2" align="center" valign="bottom">
      	<s:if test="goToUrl!=null">
			<s:if test='goToUrl.indexOf("javascript")>=0'>
				<a href='<ww:property value="goToUrl"/>'>返回</a>
			</s:if>
			<s:else>
				<a href='<%=request.getContextPath() %>/<ww:property value="goToUrl"/>'>返回</a>
			</s:else>
		</s:if>
      </td>
    </tr>
  </table>
</div>
</body>
</html>
