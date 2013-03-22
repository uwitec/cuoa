package com.oa.employee.permissions.service;

import com.oa.employee.permissions.domain.Employee;
import com.oa.framework.dao.IDbDao;
import com.oa.framework.paginaction.Condition;
import com.oa.framework.paginaction.Page;

public class EmployeeManageServiceImpl implements IEmployeeManageService {
	private IDbDao dao;
	
	@Override
	public Page<Employee> queryEmployeePage(Condition condition) {
		condition.setOrderByItem("employee.loginName");
		return dao.pagedQuery(condition);
	}
	
	public IDbDao getDao() {
		return dao;
	}
	public void setDao(IDbDao dao) {
		this.dao = dao;
	}
}
