package com.oa.employee.permissions.condition;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;

import com.oa.framework.condition.Condition;


public class QueryRolePageCondition extends Condition {

	private static final long serialVersionUID = -1733172897124307007L;

	private String name;
	@Override
	public String getInitialHql() {
		StringBuilder builder = new StringBuilder();
		builder.append("select new map(role.id as id, ");
		builder.append("role.name as name, ");
		builder.append("creater.name as createrName, ");
		builder.append("DATE_FORMAT(role.createDate, '%Y-%m-%d') as createDate,");
		builder.append("modifier.name as modifierName,");
		builder.append("DATE_FORMAT(role.modifyDate, '%Y-%m-%d') as modifyDate");
		builder.append(")");
		builder.append("from Role role ");
		builder.append("left join role.creater creater ");
		builder.append("left join role.modifier modifier ");
		builder.append("where role.deleted=0 ");
		if (StringUtils.isNotBlank(name)) {
			builder.append("and role.name like :name ");
		}
		return builder.toString();
	}
	
	@Override
	public Query preparedParams(Query query) {
		if (StringUtils.isNotBlank(name)) {
			query.setParameter("name", "%" + name + "%");
		}
		return query;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
