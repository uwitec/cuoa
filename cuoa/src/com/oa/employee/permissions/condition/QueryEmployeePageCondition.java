package com.oa.employee.permissions.condition;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;

import com.oa.framework.condition.Condition;


public class QueryEmployeePageCondition extends Condition {

	private static final long serialVersionUID = -6735322178303584625L;

	private String loginName;
	private String serial;
	private String name;
	@Override
	public String getInitialHql() {
		StringBuilder builder = new StringBuilder();
		builder.append("select new map(employee.id as id, ");
		builder.append("employee.loginName as loginName, ");
		builder.append("employee.name as name, ");
		builder.append("employee.serial as serial, ");
		builder.append("role.name as roleName, ");
		builder.append("creater.name as createrName, ");
		builder.append("DATE_FORMAT(employee.createrDate, '%Y-%m-%d') as createrDate,");
		builder.append("modifier.name as modifierName, ");
		builder.append("employee.modifyDate as modifyDate) ");
		
		builder.append("from Employee employee ");
		builder.append("left join employee.creater creater ");
		builder.append("left join employee.modifier modifier ");
		builder.append("left join employee.role role ");
		
		builder.append("where employee.deleted=0 ");
		if (StringUtils.isNotBlank(loginName)) {
			builder.append("and employee.loginName like :loginName ");
		}
		if (StringUtils.isNotBlank(name)) {
			builder.append("and employee.name like :name ");
		}
		if (StringUtils.isNotBlank(serial)) {
			builder.append("and employee.serial =:serial ");
		}
		return builder.toString();
	}
	
	@Override
	public Query preparedParams(Query query) {
		if (StringUtils.isNotBlank(loginName)) {
			query.setParameter("loginName", "%" + loginName + "%");
		}
		if (StringUtils.isNotBlank(name)) {
			query.setParameter("name", "%" + name + "%");
		}
		if (StringUtils.isNotBlank(serial)) {
			query.setParameter("serial", serial);
		}
		return query;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}

	public String getSerial() {
		return serial;
	}

	public void setSerial(String serial) {
		this.serial = serial;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
}
