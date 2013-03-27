package com.oa.employee.worklog.actions;

import com.oa.employee.worklog.condition.QueryWorklogPageCondition;
import com.oa.employee.worklog.service.IWorklogManageService;
import com.oa.framework.struts.AbstractAction;

public class WorklogManageAction extends AbstractAction {

	private static final long serialVersionUID = 7845295644003696654L;

	private IWorklogManageService worklogManageService;
	private QueryWorklogPageCondition condition;
	
	/**
		* @author zcj
		* @version 2011-8-27 下午02:35:58
		* @tag 跳转至日志查询主页
	 */
	public String toIndex() {
		return "index";
	}

	/**
		* @author zcj
		* @version 2011-8-27 下午02:36:46
		* @tag 日志查询
	 */
	public String data() {
		if (condition == null) {
			condition = new QueryWorklogPageCondition();
		}
		page = worklogManageService.queryWorklogList(condition);
		return "json-page";
	}

	public IWorklogManageService getWorklogManageService() {
		return worklogManageService;
	}

	public void setWorklogManageService(IWorklogManageService worklogManageService) {
		this.worklogManageService = worklogManageService;
	}

	public QueryWorklogPageCondition getCondition() {
		return condition;
	}

	public void setCondition(QueryWorklogPageCondition condition) {
		this.condition = condition;
	}
}
