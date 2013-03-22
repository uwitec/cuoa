package com.oa.employee.permissions.service;

import com.oa.employee.permissions.domain.Employee;
import com.oa.framework.paginaction.Condition;
import com.oa.framework.paginaction.Page;

public interface IEmployeeManageService {
	
	/**
	* @author yjn
	* @version 2011-8-24 下午01:41:15
	* @tag 查询员工列表
	 */
	public Page<Employee> queryEmployeePage(Condition condition);
}
