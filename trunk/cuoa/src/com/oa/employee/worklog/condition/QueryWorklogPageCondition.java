package com.oa.employee.worklog.condition;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;

import com.oa.framework.condition.Condition;
public class QueryWorklogPageCondition extends Condition {
	private static final long serialVersionUID = 1470255285262805463L;
	private String caption;
	
	@Override
	public String getInitialHql() {
		StringBuilder builder = new StringBuilder();
		builder.append("select new map(worklog.id as id, ");
		builder.append("employee.name as employeeName, ");
		builder.append("DATE_FORMAT(worklog.logDate, '%Y-%m-%d') as logDate, ");
		builder.append("worklog.caption as caption, ");
		builder.append("creater.name as createrName, ");
		builder.append("DATE_FORMAT(worklog.createrDate, '%Y-%m-%d %H:%i:%s') as createrDate)");
		builder.append("from Worklog worklog ");
		builder.append("left join worklog.employee employee ");
		builder.append("left join worklog.creater creater ");
		builder.append("where worklog.deleted=0 ");
		if (StringUtils.isNotBlank(caption)) {
			builder.append("and worklog.caption like like :caption ");
		}
		return builder.toString();
	}

	@Override
	public Query preparedParams(Query query) {
		if (StringUtils.isNotBlank(caption)) {
			query.setParameter("caption", "%" + caption + "%");
		}
		return query;
	}

	public String getCaption() {
		return caption;
	}

	public void setCaption(String caption) {
		this.caption = caption;
	}
}
