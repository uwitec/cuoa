package com.oa.employee.permissions.actions;

import java.util.List;
import java.util.Map;

import com.oa.employee.permissions.domain.Employee;
import com.oa.employee.permissions.domain.Resource;
import com.oa.employee.permissions.service.ILoginManageService;
import com.oa.framework.struts.AbstractAction;
import com.opensymphony.xwork2.ActionContext;
/**
 * @author yjn
 */
public class LoginManageAction extends AbstractAction {

	private static final long serialVersionUID = -6252857690281113980L;
	
	private ILoginManageService loginManageService;
	private Employee employee;
	private String returnMessage;
	/**
	* @author yjn
	* @version 2011-8-23 上午08:57:44
	* @tag 跳转至登录页面
	 */
	public String toLogin() {
		return "toLogin";
	}
	
	/**
	* @author yjn
	* @version 2011-8-23 上午08:58:54
	* @tag 登录
	 */
	public String login() {
		employee = loginManageService.queryLogin(employee);
		if (employee == null) {
			returnMessage = "用户名或密码错误";
			return "toLogin";
		}
		this.set("loginName", employee.getLoginName());
		this.set("empName", employee.getName());
		this.set("userId", employee.getId());
		this.set("roleId", employee.getRoleId());
		
		//设置是否是超级管理员角色
		if ("0".equals(employee.getRoleId())) {
			this.set("isAdminRole", 1);
		} else {
			this.set("isAdminRole", 0);
		}
		return "login";
	}
	
	/**
	* @author yjn
	* @version 2011-8-23 上午09:03:19
	* @tag 跳转至主页
	 */
	@SuppressWarnings("unchecked")
	public String index() {
		ActionContext context = ActionContext.getContext();
		Map application = context.getApplication();
		Object allPermissions = application.get("allPermissions");
		if (allPermissions == null) {
			//查询并设置application
			allPermissions = loginManageService.queryAllPermissions();
			application.put("allPermissions", allPermissions);
		}
		
		//加载权限至session
		Map<String, List<Resource>> permissions = loginManageService.queryPermissionsForInit(get("roleId").toString(), get("isAdminRole").toString(), (List<Resource>) allPermissions);
		this.set("allPermissions", permissions.get("allPermissions"));
		
		//设置 session
		this.set("allPersonalPermissions", permissions.get("allPersonalPermissions"));
		this.set("personalMenuPermissions", permissions.get("personalMenuPermissions"));
		return "index";
	}

	/**
	* @author yjn
	* @version 2011-8-24 上午01:07:02
	* @tag 退出登录
	 */
	public String logout() {
		this.clear();
		return "redirectLogin";
	}
	
	public ILoginManageService getLoginManageService() {
		return loginManageService;
	}

	public void setLoginManageService(ILoginManageService loginManageService) {
		this.loginManageService = loginManageService;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public String getReturnMessage() {
		return returnMessage;
	}

	public void setReturnMessage(String returnMessage) {
		this.returnMessage = returnMessage;
	}
}
