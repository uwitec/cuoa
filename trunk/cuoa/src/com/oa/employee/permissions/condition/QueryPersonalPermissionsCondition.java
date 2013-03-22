package com.oa.employee.permissions.condition;

import org.hibernate.Query;

import com.oa.framework.paginaction.Condition;

public class QueryPersonalPermissionsCondition extends Condition {

	private static final long serialVersionUID = 7339489787202524509L;
	private String roleId;
	@Override
	public String getInitialHql() {
		StringBuilder builder = new StringBuilder();
		builder.append("select res ");
		builder.append("from RoleResource rr left join rr.resource res ");
		builder.append("where res.deleted=0 and rr.roleId=:roleId ");
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
