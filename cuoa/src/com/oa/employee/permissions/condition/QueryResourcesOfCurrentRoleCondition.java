package com.oa.employee.permissions.condition;

import org.hibernate.Query;

import com.oa.framework.condition.Condition;


public class QueryResourcesOfCurrentRoleCondition extends Condition {

	private static final long serialVersionUID = -3699433808963411862L;
	private String roleId;
	@Override
	public String getInitialHql() {
		StringBuilder builder = new StringBuilder();
		builder.append("select roleResource.resourceId from RoleResource roleResource ");
		builder.append("where roleResource.roleId=:roleId");
		return builder.toString();
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
