package com.oa.employee.permissions.service;

import com.oa.framework.condition.Condition;
import com.oa.framework.dao.IBaseDao;
import com.oa.framework.struts.Page;

public class EmployeeManageServiceImpl implements IEmployeeManageService {
	private IBaseDao dao;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public Page queryEmployeePage(Condition condition) {
		condition.setSortname("employee.loginName");
		condition.setSortorder("asc");
		return dao.queryPage(condition);
	}

	public IBaseDao getDao() {
		return dao;
	}

	public void setDao(IBaseDao dao) {
		this.dao = dao;
	}
}
