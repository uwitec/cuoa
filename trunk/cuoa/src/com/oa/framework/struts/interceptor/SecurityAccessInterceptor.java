package com.oa.framework.struts.interceptor;

import java.util.Map;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.ValidationAware;
import com.opensymphony.xwork2.interceptor.Interceptor;
public class SecurityAccessInterceptor implements  com.opensymphony.xwork2.interceptor.Interceptor {

	/**
	 * 
	 */
	private static final long serialVersionUID = 2728007741842038219L;

	public void destroy() {

	}

	public void init() {

	}

	@SuppressWarnings("unchecked")
	public String intercept(ActionInvocation invocation) throws Exception {
		System.out.println("success!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
		final Object action = invocation.getAction();
        ValidationAware validation = null;

        if (action instanceof ValidationAware) {
            validation = (ValidationAware) action;
        }

        return invocation.invoke();
	}

}
