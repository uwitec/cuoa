package com.oa.employee.permissions.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.oa.employee.permissions.condition.LoginValidateCondition;
import com.oa.employee.permissions.condition.QueryAllPermissionResourcesCondition;
import com.oa.employee.permissions.condition.QueryPersonalPermissionsCondition;
import com.oa.employee.permissions.domain.Employee;
import com.oa.employee.permissions.domain.Resource;
import com.oa.framework.dao.IBaseDao;

public class LoginManageServiceImpl implements ILoginManageService {
	private IBaseDao dao;
	@Override
	public Employee queryLogin(Employee employee) {
		LoginValidateCondition condition = new LoginValidateCondition();
		condition.setEmployee(employee);
		List<Employee> employeeList = dao.queryObjectList(condition);
		if (employeeList == null || employeeList.isEmpty()) {
			return null;
		}
		return employeeList.get(0);
	}
	
	@Override
	public List<Resource> queryAllPermissions() {
		QueryAllPermissionResourcesCondition condition = new QueryAllPermissionResourcesCondition();
		List<Resource> allPermissions = dao.queryObjectList(condition);
		return allPermissions;
	}

	@Override
	public Map<String, List<Resource>> queryPermissionsForInit(String roleId, String isAdminRole, List<Resource> allPermissions) {
		//查询系统所有权限
		Map<String, List<Resource>> resultMap = new HashMap<String, List<Resource>>();
		
		//查询所有的本角色的权限
		if (isAdminRole.equals("1")) {
			resultMap.put("allPersonalPermissions", allPermissions);
		} else {
			QueryPersonalPermissionsCondition personalPermissionsCondition = new QueryPersonalPermissionsCondition();
			personalPermissionsCondition.setRoleId(roleId);
			List<Resource> allPersonalPermissions = dao.queryObjectList(personalPermissionsCondition);
			resultMap.put("allPersonalPermissions", allPersonalPermissions);
		}
		//分离出本角色的菜单权限
		List<Resource> personalMenuPermissions = new ArrayList<Resource>();
		for (Resource res: resultMap.get("allPersonalPermissions")) {
			if (res.getIsMenu() == 1) {
				personalMenuPermissions.add(res);
			}
		}
		resultMap.put("personalMenuPermissions", personalMenuPermissions);
		return resultMap;
	}

	public IBaseDao getDao() {
		return dao;
	}

	public void setDao(IBaseDao dao) {
		this.dao = dao;
	}

}
