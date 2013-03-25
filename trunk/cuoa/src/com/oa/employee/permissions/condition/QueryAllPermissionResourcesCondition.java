package com.oa.employee.permissions.condition;

import org.hibernate.Query;

import com.oa.framework.condition.Condition;


public class QueryAllPermissionResourcesCondition extends Condition {

	private static final long serialVersionUID = 6629492442396407107L;

	@Override
	public String getInitialHql() {
		return "select res from Resource res where res.deleted=0";
	}

	@Override
	public Query preparedParams(Query query) {
		return query;
	}
}
