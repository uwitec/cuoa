package com.oa.employee.worklog.service;

import com.oa.employee.worklog.domain.Worklog;
import com.oa.framework.dao.IDbDao;
import com.oa.framework.paginaction.Condition;
import com.oa.framework.paginaction.Page;

public class WorklogManageServiceImpl implements IWorklogManageService {
	private IDbDao dao;
	@Override
	public Page<Worklog> queryWorklogList(Condition condition) {
		condition.setOrderByItem("worklog.modifyDate desc");
		return dao.pagedQuery(condition);
	}
	public IDbDao getDao() {
		return dao;
	}
	public void setDao(IDbDao dao) {
		this.dao = dao;
	}
}
