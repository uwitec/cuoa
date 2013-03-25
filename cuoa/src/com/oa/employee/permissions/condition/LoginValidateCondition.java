package com.oa.employee.permissions.condition;

import org.hibernate.Query;

import com.oa.employee.permissions.domain.Employee;
import com.oa.framework.condition.Condition;
import com.oa.framework.utils.string.MD5;

@SuppressWarnings("serial")
public class LoginValidateCondition extends Condition {

	private Employee employee;
	
	@Override
	public String getInitialHql() {
		StringBuilder builder = new StringBuilder();
		builder.append("select employee from Employee employee ");
		builder.append("where employee.loginName=:loginName ");
		builder.append("and employee.loginPassword=:loginPassword ");
		builder.append("and employee.deleted=0 ");
		return builder.toString();
	}
	
	@Override
	public Query preparedParams(Query query) {
		query.setParameter("loginName", employee.getLoginName());
		query.setParameter("loginPassword", MD5.getMD5String(employee.getLoginPassword()));
		return query;
	}

	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}
}
