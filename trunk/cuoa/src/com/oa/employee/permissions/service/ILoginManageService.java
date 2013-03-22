package com.oa.employee.permissions.service;

import java.util.List;
import java.util.Map;

import com.oa.employee.permissions.domain.Employee;
import com.oa.employee.permissions.domain.Resource;

public interface ILoginManageService {

	/**
		* @author yjn
		* @version Aug 30, 2011 4:15:10 PM
		* @tag 登录验证
	 */
	public Employee queryLogin(Employee employee);

	/**
		* @author yjn
		* @version Aug 31, 2011 11:50:36 AM
		* @tag 查询系统所有权限
	 */
	public List<Resource> queryAllPermissions();
	
	/**
		* @author yjn
		* @version Aug 30, 2011 3:43:08 PM
		* @tag 查询系统所有的权限和用户拥有的权限，用于初始化和权限过滤
	 */
	public Map<String, List<Resource>> queryPermissionsForInit(String roleId, String isAdminRole, List<Resource> allPermissions);
}
