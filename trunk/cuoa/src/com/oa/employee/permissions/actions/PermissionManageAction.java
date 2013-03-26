package com.oa.employee.permissions.actions;

import org.apache.commons.lang.StringUtils;

import com.oa.employee.permissions.condition.ModifyPermissionsCondition;
import com.oa.employee.permissions.condition.QueryRolePageCondition;
import com.oa.employee.permissions.domain.Employee;
import com.oa.employee.permissions.domain.Role;
import com.oa.employee.permissions.service.IPermissionManageService;
import com.oa.framework.struts.AbstractAction;
import com.oa.framework.struts.Result;
/**
 * @author yjn
 */
public class PermissionManageAction extends AbstractAction {

	private static final long serialVersionUID = -6018677425249387465L;
	private IPermissionManageService permissionManageService;
	private QueryRolePageCondition condition;
	private Role role;
	private String initTreeString;
	private ModifyPermissionsCondition modifyPermissionsCondition;
	
	/**
	* @author yjn
	* @version 2011-8-26 12:24:42
	* @tag 跳转至角色管理页面
	 */
	public String toRoleIndex() {
		return "roleIndex";
	}
	
	/**
	* @author yjn
	* @version 2011-8-26 12:26:42
	* @tag 查询角色列表
	 */
	public String data() {
		if (condition == null) {
			condition = new QueryRolePageCondition();
		}
		try {
			page = permissionManageService.queryRolePage(condition);
			return "json-page";
		} catch (Exception ex) {
			ex.printStackTrace();
			return ERROR;
		}
	}
	
	/**
		* @author yjn
		* @version Aug 26, 2011 12:43:09 PM
		* @tag 进入新增角色页面
	 */
	public String toAddRoleIndex() {
		return "addRoleIndex";
	}
	
	/**
		* @author yjn
		* @version Aug 26, 2011 12:32:24 PM
		* @tag 新增角色
	 */
	public String addRole() {
		Employee employee = new Employee();
		employee.setId(this.get("userId").toString());
		try {
			String returnMessage = permissionManageService.addRole(role, employee);
			if (StringUtils.isBlank(returnMessage)) {
				result = new Result(Boolean.TRUE, "新增角色成功");
				return "json-result";
			}
			result = new Result(Boolean.FALSE, returnMessage);
			return "json-result";
		} catch (Exception ex) {
			result = new Result(Boolean.FALSE, ex.getMessage());
			return "json-result";
		}
	}
	
	/**
		* @author yjn
		* @version Aug 26, 2011 12:33:37 PM
		* @tag 删除角色
	 */
	public String deleteRoles() {
		return "jsonSuccess";
	}
	
	/**
		* @author yjn
		* @version Aug 26, 2011 1:12:32 PM
		* @tag 进入修改角色页面
	 */
	public String toModifyRoleIndex() {
		role = permissionManageService.queryRole(role);
		return "modifyRoleIndex";
	}
	
	/**
		* @author yjn
		* @version Aug 26, 2011 12:35:28 PM
		* @tag 修改角色
	 */
	public String modifyRole() {
		Employee employee = new Employee();
		employee.setId(this.get("userId").toString());
		try {
			String returnMessage = permissionManageService.modifyRole(role, employee);
			if (StringUtils.isBlank(returnMessage)) {
				result = new Result(Boolean.TRUE, "修改角色成功");
				return "json-result";
			}
			result = new Result(Boolean.FALSE, returnMessage);
			return "json-result";
		} catch (Exception ex) {
			result = new Result(Boolean.FALSE, ex.getMessage());
			return "json-result";
		}
	}
	
	/**
		* @author yjn
		* @version Aug 26, 2011 12:36:52 PM
		* @tag 进入权限设置弹出页面
	 */
	public String toResourceTree() {
		try {
			initTreeString = permissionManageService.queryInitPermissionTree(role);
		} catch (Exception e) {
			e.printStackTrace();
			return ERROR;
		}
		return "resourceTree";
	}
	
	/**
		* @author yjn
		* @version Aug 26, 2011 12:38:01 PM
		* @tag 设置角色权限
	 */
	public String modifyPermission() {
		try {
			String returnMessage = permissionManageService.modifyPermissions(role, modifyPermissionsCondition);
			if (StringUtils.isBlank(returnMessage)) {
				result = new Result(Boolean.TRUE, "修改权限成功");
				return "json-result";
			}
			result = new Result(Boolean.FALSE, returnMessage);
			return "json-result";
		} catch (Exception ex) {
			result = new Result(Boolean.FALSE, ex.getMessage());
			return "json-result";
		}
	}

	public IPermissionManageService getPermissionManageService() {
		return permissionManageService;
	}

	public void setPermissionManageService(
			IPermissionManageService permissionManageService) {
		this.permissionManageService = permissionManageService;
	}

	public QueryRolePageCondition getCondition() {
		return condition;
	}

	public void setCondition(QueryRolePageCondition condition) {
		this.condition = condition;
	}
	
	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public String getInitTreeString() {
		return initTreeString;
	}

	public void setInitTreeString(String initTreeString) {
		this.initTreeString = initTreeString;
	}

	public ModifyPermissionsCondition getModifyPermissionsCondition() {
		return modifyPermissionsCondition;
	}

	public void setModifyPermissionsCondition(
			ModifyPermissionsCondition modifyPermissionsCondition) {
		this.modifyPermissionsCondition = modifyPermissionsCondition;
	}
}
