package com.oa.global.interceptor;

import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.struts2.StrutsStatics;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

public class AsynchronousTokenInterceptor  extends MethodFilterInterceptor {
	private Logger logger=Logger.getLogger(AsynchronousTokenInterceptor.class);

	@SuppressWarnings("unchecked")
	@Override
	protected String doIntercept(ActionInvocation actionInvocation) throws Exception {
		
		try{
			ActionContext actionContext = actionInvocation.getInvocationContext();
			Map session = actionContext.getSession();
			HttpServletRequest request = (HttpServletRequest) actionContext.get(StrutsStatics.HTTP_REQUEST);
			/**接收请求时，如果request中的token_id和session中的tokenId相等时，允许通过*/
			
			if (request.getParameter("async_token_static").toString().equals(session.get("asyncTokenId").toString())) {
				/**更改session中的token_id，关闭此请求通过，直至请求返回后再把新token_id发送至页面*/
				session.put("asyncTokenId", UUID.randomUUID());
				logger.info("提交!");
				return actionInvocation.invoke();
			} else {
				logger.info("重复提交了!");
				return null;
			}
		}catch(Exception e){
			e.printStackTrace();
			return ActionSupport.ERROR;
		}
		
	}
	
}
