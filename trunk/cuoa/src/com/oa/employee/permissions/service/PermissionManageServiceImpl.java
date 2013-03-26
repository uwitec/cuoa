package com.oa.employee.permissions.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.xwork.StringUtils;

import com.oa.employee.permissions.condition.ModifyPermissionsCondition;
import com.oa.employee.permissions.condition.QueryAllPermissionResourcesCondition;
import com.oa.employee.permissions.condition.QueryResourcesOfCurrentRoleCondition;
import com.oa.employee.permissions.domain.Employee;
import com.oa.employee.permissions.domain.Resource;
import com.oa.employee.permissions.domain.Role;
import com.oa.framework.condition.Condition;
import com.oa.framework.dao.IBaseDao;
import com.oa.framework.struts.Page;

public class PermissionManageServiceImpl implements IPermissionManageService {
	private IBaseDao dao;
	
	@Override
	public Page<Role> queryRolePage(Condition condition) {
		condition.setSortname("role.createDate");
		condition.setSortorder("desc");
		return dao.queryPage(condition);
	}
	
	@Override
	public String addRole(Role role, Employee employee) throws Exception {
		if (dao.CheckObjectColumnNotDeleted(role, new String[] {"name"}, null, "deleted").equals("y")) {
			return "您输入的角色名已存在，请重新输入";
		}
		Date date = new Date();
		role.setCreateDate(date);
		role.setModifyDate(date);
		role.setCreaterId(employee.getId());
		role.setModifierId(employee.getId());
		role.setDeleted(0);
		dao.addObject(role);
		return null;
	}
	
	@Override
	public String modifyRole(Role role, Employee employee) throws Exception {
		Role originalRole = dao.getObject(Role.class, role.getId());
		if (role.getName().equals(originalRole.getName())) {
			return "您输入的角色名与原角色名一致，请重新输入";
		}
		if (dao.CheckObjectColumnNotDeleted(role, new String[] {"name"}, null, "deleted").equals("y")) {
			return "您输入的角色名已存在，请重新输入";
		}
		originalRole.setModifierId(employee.getId());
		originalRole.setModifyDate(new Date());
		originalRole.setName(role.getName());
		dao.updateObject(originalRole);
		return null;
	}
	
	@Override
	public Role queryRole(Role role) {
		return dao.getObject(Role.class, role.getId());
	}

	@Override
	public String queryInitPermissionTree(Role role) throws Exception {
		List<Resource> allResource = dao.queryObjectList(new QueryAllPermissionResourcesCondition());
		QueryResourcesOfCurrentRoleCondition resourcesOfCurrentRoleCondition = new QueryResourcesOfCurrentRoleCondition();
		resourcesOfCurrentRoleCondition.setRoleId(role.getId());
		List<String> resourcesOfRole = dao.queryObjectList(resourcesOfCurrentRoleCondition);
		
		StringBuilder builder = new StringBuilder();
		for (Resource resource: allResource) {
			builder.append("data['");
			builder.append(StringUtils.isBlank(resource.getParentId()) ? "-1" : resource.getParentId());
			builder.append("_");
			builder.append(resource.getId());
			builder.append("']");
			builder.append("=");
			builder.append("'text:");
			builder.append(resource.getName());
			
			if (resourcesOfRole.contains(resource.getId())) {
				builder.append(";");
				builder.append("checked:true");
			} else {
				builder.append(";");
				builder.append("checked:false");
			}
			builder.append("'");
			builder.append(";");
		}
		return builder.toString();
	}

	@Override
	public String modifyPermissions(Role role, ModifyPermissionsCondition modifyPermissionsCondition) throws Exception {
		modifyPermissionsCondition.setIsSQL(Boolean.TRUE);
		//验证数据完整性：角色是否存在
		role = dao.getObject(Role.class, role.getId());
		if (role == null) {
			return "所操作的角色不存在";
		}
		modifyPermissionsCondition.setRoleId(role.getId());
		//删除原权限资源
		modifyPermissionsCondition.setOperateType("delete");
		dao.updateOrDeleteAll(modifyPermissionsCondition);
		//添加新权限资源
		if (modifyPermissionsCondition.getResourceIds().split(",").length > 0) {
			modifyPermissionsCondition.setOperateType("add");
			dao.updateOrDeleteAll(modifyPermissionsCondition);
		}
		return null;
	}

	public IBaseDao getDao() {
		return dao;
	}

	public void setDao(IBaseDao dao) {
		this.dao = dao;
	}
}