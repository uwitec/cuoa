package com.oa.global.interceptor;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.struts2.StrutsStatics;

import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.oa.framework.struts.AbstractAction;
import com.oa.framework.struts.Result;
import com.oa.global.routingDataSource.changecity.CustomerContextForCity;



/**
 * 登录验证拦截
 * @author Administrator
 *
 */
public class LoginAuthorizationInterceptor extends AbstractInterceptor 
{

	private static Logger logger=Logger.getLogger(LoginAuthorizationInterceptor.class);
	
	public String intercept(ActionInvocation actionInvocation) throws Exception 
	{
		
		ActionContext actionContext=actionInvocation.getInvocationContext();
		Map session=actionContext.getSession();
		HttpServletRequest request= (HttpServletRequest) actionContext.get(StrutsStatics.HTTP_REQUEST);
		if(StringUtils.isBlank((String)session.get("userId")))
		{
			ActionProxy proxy=actionInvocation.getProxy();
			AbstractAction action=null;
			if(actionInvocation.getAction() instanceof AbstractAction){
				action=(AbstractAction)actionInvocation.getAction();
			}else{
				return ActionSupport.ERROR;
			}
			if(request.getHeader("x-requested-with")!= null  
	                && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
				action.setResult(new Result(false,"登录超时!","/loginManage!toLogin.action"));
				return "reLoginAjaxResult";
			}else{
				return "reLoginResult";
			}
		}
		return actionInvocation.invoke();
	}

}
