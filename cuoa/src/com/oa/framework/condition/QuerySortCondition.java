package com.oa.framework.condition;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;


/**
 * 查询序号最大sort  所有的
 * @author sunchuanbao
 *
 */
public class QuerySortCondition extends Condition {
	private Class clazz;//要查询sort类的class 如：查询City  clazz=City.class
	private String where;//where 语句，添加查询条件
	
	@Override
	public String getInitialHql() {
		StringBuffer buffer=new StringBuffer();
		buffer.append("select max(clazz.sort) from ");
		buffer.append(clazz.getName()+" clazz ");
		if(StringUtils.isNotBlank(where)){
			buffer.append(where);
		}
		return buffer.toString();
	}

	@Override
	public Query preparedParams(Query query) {
		return query;
	}

	private QuerySortCondition() {
		super();
	}

	public QuerySortCondition(Class domainClazz) {
		super();
		this.clazz = domainClazz;
	}
	public QuerySortCondition(Class domainClazz,String where) {
		super();
		this.clazz = domainClazz;
		this.where=where;
	}
}
