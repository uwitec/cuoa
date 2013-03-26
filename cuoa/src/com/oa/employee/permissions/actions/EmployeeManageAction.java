package com.oa.employee.permissions.actions;

import com.oa.employee.permissions.condition.QueryEmployeePageCondition;
import com.oa.employee.permissions.domain.Employee;
import com.oa.employee.permissions.service.IEmployeeManageService;
import com.oa.framework.struts.AbstractAction;
/**
 * @author yjn
 */
public class EmployeeManageAction extends AbstractAction {

	private static final long serialVersionUID = -5078898317715595337L;

	private Employee employee;
	private IEmployeeManageService employeeManageService;
	private QueryEmployeePageCondition condition;
	
	/**
	* @author yjn
	* @version 2011-8-24 下午01:36:12
	* @tag 跳转至员工管理首页
	 */
	public String toIndex() {
		return "index";
	}
	
	/**
	* @author yjn
	* @version 2011-8-24 下午01:38:14
	* @tag 查询员工
	 */
	public String data() {
		if (condition == null) {
			condition = new QueryEmployeePageCondition();
		}
		page = employeeManageService.queryEmployeePage(condition);
		return "json-page";
	}

	/**
		* @author yjn
		* @version Aug 26, 2011 12:42:16 PM
		* @tag 进入新增员工页面
	 */
	public String toAddEmployeeIndex() {
		return "addEmployeeIndex";
	}
	
	/**
		* @author yjn
		* @version Aug 26, 2011 12:39:30 PM
		* @tag 新增员工
	 */
	public String addEmployee() {
		return "jsonSuccess";
	}
	
	/**
		* @author yjn
		* @version Aug 26, 2011 12:40:17 PM
		* @tag 删除员工
	 */
	public String deleteEmployees() {
		return "jsonSuccess";
	}
	
	/**
		* @author yjn
		* @version Aug 26, 2011 1:15:56 PM
		* @tag 进入修改员工页面
	 */
	public String toModifyEmployeeIndex() {
		return "modifyEmployeeIndex";
	}
	
	/**
		* @author yjn
		* @version Aug 26, 2011 12:40:57 PM
		* @tag 修改员工
	 */
	public String modifyEmployee() {
		return "jsonSuccess";
	}
	
	public Employee getEmployee() {
		return employee;
	}

	public void setEmployee(Employee employee) {
		this.employee = employee;
	}

	public IEmployeeManageService getEmployeeManageService() {
		return employeeManageService;
	}

	public void setEmployeeManageService(
			IEmployeeManageService employeeManageService) {
		this.employeeManageService = employeeManageService;
	}

	public QueryEmployeePageCondition getCondition() {
		return condition;
	}

	public void setCondition(QueryEmployeePageCondition condition) {
		this.condition = condition;
	}
}
