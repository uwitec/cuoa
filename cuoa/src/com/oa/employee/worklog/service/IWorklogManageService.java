package com.oa.employee.worklog.service;

import com.oa.employee.worklog.domain.Worklog;
import com.oa.framework.condition.Condition;
import com.oa.framework.struts.Page;

public interface IWorklogManageService {

	/**
		* @author zcj
		* @version 2011-8-27 下午02:40:31
		* @tag 分页查询日志列表
	 */
	public Page<Worklog> queryWorklogList(Condition condition);
}
