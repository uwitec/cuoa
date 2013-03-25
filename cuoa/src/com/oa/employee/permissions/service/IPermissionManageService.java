package com.oa.employee.permissions.service;

import com.oa.employee.permissions.condition.ModifyPermissionsCondition;
import com.oa.employee.permissions.domain.Employee;
import com.oa.employee.permissions.domain.Role;
import com.oa.framework.condition.Condition;
import com.oa.framework.struts.Page;

public interface IPermissionManageService {

	/**
		* @author yjn
		* @version Aug 26, 2011 1:07:06 PM
		* @tag 查询角色列表
	 */
	public Page<Role> queryRolePage(Condition condition);
	
	/**
		* @author yjn
		* @version Aug 26, 2011 3:05:42 PM
		* @tag 新建角色
	 */
	public String addRole(Role role, Employee employee) throws Exception;
	
	/**
		* @author yjn
		* @version Aug 26, 2011 4:31:09 PM
		* @tag 更改角色名称
	 */
	public String modifyRole(Role role, Employee employee) throws Exception;
	
	/**
		* @author yjn
		* @version Aug 26, 2011 4:42:19 PM
		* @tag 查询角色ByID
	 */
	public Role queryRole(Role role);
	
	/**
	* @author YJN
	* @version 2011-8-29 下午11:09:17
	* @tag 查询初始化权限树字符串
	 */
	public String queryInitPermissionTree(Role role) throws Exception;
	
	/**
		* @author YJN
		* @version Aug 30, 2011 11:07:07 AM
		* @tag 更改角色权限
	 */
	public String modifyPermissions(Role role, ModifyPermissionsCondition modifyPermissionsCondition) throws Exception;
}
