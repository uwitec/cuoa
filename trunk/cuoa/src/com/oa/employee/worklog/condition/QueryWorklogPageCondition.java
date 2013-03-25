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
		builder.append("select worklog from Worklog worklog ");
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
