<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<!-- 通用页面头文件 -->
		<%@include file="/include/header.inc"%>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<!-- 列表页面样式 -->
		<link href="<%=contextPath %>/css/table.css" rel="stylesheet" type="text/css" media="screen" />
		<script src="<%=contextPath %>/js/mztreeview2/scripts/jsframework.js" type="text/javascript"></script>
		<STYLE type="text/css">
		 body {overflow-x:hidden;}
		</STYLE>
		<script type="text/javascript">
			var modifyPermission = function() {
				var url = "permissionManage!modifyPermission.action";
				var resourceIds = "";
		        for(var i in a.nodes) { 
					if(a.nodes[i].checked){
						resourceIds += (resourceIds != "" ? "," : "") + a.nodes[i].id;
					} 
				}
				$("#submitBtn").attr("disabled", true);
		        $.post(url, {"role.id": "<s:property value='role.id'/>",
       					"modifyPermissionsCondition.resourceIds": resourceIds,
       					"random": Math.random()}, function(json) { 
       			   $("#submitBtn").attr("disabled", false);
		           if(!json.jumpType) {
		           		dialog("提示", "text:" + json.returnMessage, 300, "auto");
		           		return;
		           }
				   window.returnValue = {"jumpType": true, "returnMessage": json.returnMessage};
				   window.close();
		        }, 'json');
			};
		</script>
	</HEAD>
	<BODY>
		<TABLE border=0 cellSpacing=0 cellPadding=0 width="100%">
			<TBODY>
				<TR>
					<TD>
						<TABLE border=0 cellSpacing=0 cellPadding=0 class="tb_1">
							<THEAD>
								<TR>
									<TD width="100%" class="pop_title">
										修改角色权限
									</TD>
								</TR>
							</THEAD>

							<TBODY>
								<form name="pop_form" id="pop_form">
									<TR>
										<td class="" width=100%>
									         <table width="100%" border="0" cellspacing="1" cellpadding="0" class="grid"  style="background-color:#FFF">
											  <tr>
											  	<td class="tableTitleBg"></td>
											  </tr>
											  <tr >
											    <td class="tableTitleBg" valign="top" style="font-weight:normal;">
											    <br />
											    <div class="content" style="text-align:left">
											       <script type="text/javascript">
											       		Using("System.Web.UI.WebControls.MzTreeView");
											       		var a = new MzTreeView();
											       		var data={};
											       		<%=request.getAttribute("initTreeString")%>;
											       		a.dataSource = data;
											       		a.autoSort=false;
												        a.useCheckbox=true;
												        a.canOperate=true;
												        document.write(a.render());
												        a.expandLevel(3);
											       </script>
											        <table width="100%" border="0" cellspacing="0" cellpadding="0">
													  <tr>
													    <td width="70%" align="center" id="showinfo" class="orangeBold"></td>
													    <td width="30%" align="center">
													    </td>
													  </tr>
													</table>
											    </div>
											    </td>
											    </tr>
											</table>
										</td>
									</TR>
									<TR>
										<TD>
											<SPAN class="operate_span">
											<INPUT type="button" id="submitBtn" class="btn" value="提 交" onclick="modifyPermission()"/>&nbsp;&nbsp;
											<INPUT type="button" class="btn" value="关 闭" onclick="window.close()" /> </SPAN>
										</TD>
									</TR>
								</form>
							</TBODY>
						</TABLE>
					</TD>
				</TR>
			</TBODY>
		</TABLE>
	</BODY>
</HTML>
