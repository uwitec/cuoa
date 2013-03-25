package com.oa.global.interceptor;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.StrutsStatics;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.oa.employee.permissions.domain.Resource;
import com.oa.framework.struts.AbstractAction;
import com.oa.framework.struts.Result;

public class PermissionsValidateInterceptor extends AbstractInterceptor {
	private static final long serialVersionUID = 8187716580877813175L;
	private static Logger logger = Logger.getLogger(PermissionsValidateInterceptor.class);

	public String intercept(ActionInvocation actionInvocation) throws Exception {
		ActionContext actionContext = actionInvocation.getInvocationContext();
		Map session = actionContext.getSession();
		HttpServletRequest request = (HttpServletRequest) actionContext.get(StrutsStatics.HTTP_REQUEST);   
		Map application = actionContext.getApplication();
		
		try {
			if (((Integer)session.get("isAdminRole")).intValue() != 1) {
				ActionProxy proxy = actionInvocation.getProxy();
				AbstractAction action = null;
				if (actionInvocation.getAction() instanceof AbstractAction) {
					action = (AbstractAction) actionInvocation.getAction();
				} else {
					return ActionSupport.ERROR;
				}
				List<Resource> allPermissions = (List<Resource>) application.get("allPermissions");
				Object allPersonalPermissionsObj = session.get("allPersonalPermissions");
				String url = request.getRequestURL().toString();
				if (allPersonalPermissionsObj != null && !((List) allPersonalPermissionsObj).isEmpty()) {
					List<Resource> allPersonalPermissions = (List<Resource>) allPersonalPermissionsObj;
					//如果url包含在个人权限中，通过验证
					for (Resource resource: allPersonalPermissions) {
						if (StringUtils.isNotBlank(resource.getUrl()) && url.indexOf(resource.getUrl()) != -1) {
							return actionInvocation.invoke();
						}
					}
					//如果个人权限未包含此url,且全部权限中包含此url,此操作应被拦截
					for (Resource allResource: allPermissions) {
						if (StringUtils.isNotBlank(allResource.getUrl()) && url.indexOf(allResource.getUrl()) != -1) {
							if(request.getHeader("x-requested-with")!= null  
			                && request.getHeader("x-requested-with")   
			                        .equalsIgnoreCase("XMLHttpRequest")) {
								action.setResult(new Result(false,"您无权访问此页面!"));
								return "noPermissionAjaxResult";
							}else{
								action.addActionError("您无权访问此页面!");
								return "noPermissionResult";
							}
						}
					}
				}
			}
		} catch (Exception ee) {
			ee.printStackTrace();
		}
		return actionInvocation.invoke();
	}

}
