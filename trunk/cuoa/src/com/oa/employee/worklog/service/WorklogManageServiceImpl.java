package com.oa.employee.worklog.service;

import com.oa.employee.worklog.domain.Worklog;
import com.oa.framework.condition.Condition;
import com.oa.framework.dao.IBaseDao;
import com.oa.framework.struts.Page;

public class WorklogManageServiceImpl implements IWorklogManageService {
	private IBaseDao dao;
	@Override
	public Page<Worklog> queryWorklogList(Condition condition) {
		condition.setSortname("worklog.modifyDate");
		condition.setSortorder("desc");
		return dao.queryPage(condition);
	}
	public IBaseDao getDao() {
		return dao;
	}
	public void setDao(IBaseDao dao) {
		this.dao = dao;
	}
}
