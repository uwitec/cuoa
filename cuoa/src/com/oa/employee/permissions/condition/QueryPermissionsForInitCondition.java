package com.oa.employee.permissions.condition;

import org.hibernate.Query;

import com.oa.framework.condition.Condition;

public class QueryPermissionsForInitCondition extends Condition {

	private static final long serialVersionUID = 8150823696199126351L;
	private String roleId;
	@Override
	public String getInitialHql() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public Query preparedParams(Query query) {
		query.setParameter("roleId", roleId);
		return query;
	}
	public String getRoleId() {
		return roleId;
	}
	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
}
