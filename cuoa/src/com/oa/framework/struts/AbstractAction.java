package com.oa.framework.struts;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.oa.framework.paginaction.Page;
import com.oa.global.domain.Result;
import com.oa.global.routingDataSource.CustomerContextHolder;
import com.oa.global.routingDataSource.DataSourceMap;

public class AbstractAction extends ActionSupport implements ServletRequestAware,DataSourceMap{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6863731185975618134L;
	
	
	protected String  goToUrl = null;
	@SuppressWarnings("unchecked")
	protected Page currentPage ;
	protected String namespace = "";
	protected Result result = null;
	private String random;
	private HttpServletRequest request; 
	

	
	/**
	 * @return java.lang.Strings
	 * @throws java.lang.Exception
	 * @roseuid 431F92DB001D
	 */
	public String execute() throws Exception {
		if (hasErrors()) {
			LOG.debug("action not executed, field or action errors");
			LOG.debug("Field errors: " + getFieldErrors());
			LOG.debug("Action errors: " + getActionErrors());
			return INPUT;
		}
		return SUCCESS;
	}

	/**
	 * Get an object from the WebWork user session
	 * 
	 * @param name
	 * @return java.lang.Object
	 * @roseuid 431F92DB00BD
	 */
	protected Object get(String name) {		
		return ActionContext.getContext().getSession().get(name);
		
	}

	/**
	 * Put an object in the WebWork user session
	 * 
	 * @param name
	 * @param value
	 * @roseuid 431F92DB00D1
	 */
	
	protected void set(String name, Object value) {
		ActionContext.getContext().getSession().put(name, value);
	}

	/**
	 * 判断是否为权限管理员
	 * @return
	 */
	public boolean isAdmin(){
		if(((Integer)get("isAdmin")).intValue()==1){
			return true;
		}
		return false;
	}
	
	/**
	 * Remove an object in the WebWork user session
	 * 
	 * @param key
	 * @roseuid 431F92DB00D2
	 */
	protected void remove(Object key) {
		ActionContext.getContext().getSession().remove(key);
	}


	protected void clear()
	{
		ActionContext.getContext().getSession().clear();
	}

	public String getActionName(){
		return this.getClass().getName()+"_";
		
	}
	
	public String getActionNames(){
		return ActionContext.getContext().getActionInvocation().getProxy().getActionName();
	}
	public String getGoToUrl() {
		return goToUrl;
	}

	public void setGoToUrl(String goToUrl) {
		this.goToUrl = goToUrl;
	}
	public Page<Object> getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Page<Object> page) {
		this.currentPage = page;
	}
	
	public void setEMessageAndGoToUrl(String eMessage,String goToUrl){
		this.addActionError(eMessage);
		this.goToUrl=goToUrl;
	}
	public void setAMessageAndGoToUrl(String aMessage,String goToUrl){
		this.addActionMessage(aMessage);
		this.goToUrl=goToUrl;
	}

	public String getNamespace() {
		return ActionContext.getContext().getActionInvocation().getProxy().getNamespace();
	}
	
	public String getServerLocation() {
		return "HTTP://" + request.getServerName() + ":" + String.valueOf(request.getServerPort());
	}
	
	public String getContextPath(){
		return request.getContextPath();
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	public String getHttpPath(){
		return "http:"+"//"+
			getServletRequest().getServerName()+":"+getServletRequest().getServerPort()+
			getServletRequest().getContextPath();
	}
	
	public String getRandom() {
		return random;
	}

	public void setRandom(String random) {
		this.random = random;
	}

	public void setServletRequest(HttpServletRequest request) {
		this.request=request;
	}
	
	public HttpServletRequest getServletRequest(){
		return request;
	}
	
}
