<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@include file="/jsp/include/header_param.inc"%>
<%
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
%>
  <head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>OA系统登录</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
	background-color: #016aa9;
	overflow:hidden;
}
.STYLE1 {
	color: #000000;
	font-size: 12px;
}
-->
</style>

<script type="text/javascript">
//<![CDATA[
	var login = function() {
		if ($("#empLoginName").val() == "") {
			dialog("提示信息框","text:请输入用户名",300,100,"","");
			return;
		}
		if ($("#empLoginPassword").val() == "") {
			dialog("提示信息框","text:请输入密码",300,100,"","");
			return;
		}
		document.loginForm.submit();
	};
	$(document).ready(function() {
		var returnMessage = "<s:property value='returnMessage'/>";
		if (returnMessage != "") {
			dialog("提示信息框", "text:" + returnMessage ,300, 100, "", "");
		}
		$("#empLoginName").focus();
	});
	function keySubmit() {
		if(event.keyCode==13) {
			login();
		}
	}
//]]>
</script>

</head>
<body onkeydown="keySubmit();">
<form name="loginForm" action="<%=contextPath%>/loginManage!login.action" method="post">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><table width="962" border="0" align="center" cellpadding="0" cellspacing="0">
      <tr>
        <td height="235" background="<%=contextPath%>/images/login/login_03.gif">&nbsp;</td>
      </tr>
      <tr>
        <td height="53"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td width="394" height="53" background="<%=contextPath%>/images/login/login_05.gif">&nbsp;</td>
            <td width="206" background="<%=contextPath%>/images/login/login_06.gif"><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="16%" height="25"><div align="right"><span class="STYLE1">用户</span></div></td>
                <td width="57%" height="25"><div align="center">
                  <input type="text" id="empLoginName" name="employee.loginName" style="width:105px; height:17px; background-color:#292929; border:solid 1px #7dbad7; font-size:12px; color:#6cd0ff">
                </div></td>
                <td width="27%" height="25">&nbsp;</td>
              </tr>
              <tr>
                <td height="25"><div align="right"><span class="STYLE1">密码</span></div></td>
                <td height="25"><div align="center">
                  <input type="password" id="loginPassword" name="employee.loginPassword" style="width:105px; height:17px; background-color:#292929; border:solid 1px #7dbad7; font-size:12px; color:#6cd0ff">
                </div></td>
                <td height="25"><div align="left"><a href="javascript:login();"><img src="<%=contextPath%>/images/login/dl.gif" width="49" height="18" border="0"></a></div></td>
              </tr>
            </table></td>
            <td width="362" background="<%=contextPath%>/images/login/login_07.gif">&nbsp;</td>
          </tr>
        </table></td>
      </tr>
      <tr>
        <td height="213" background="<%=contextPath%>/images/login/login_08.gif">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
</form>
</body>
</html>
