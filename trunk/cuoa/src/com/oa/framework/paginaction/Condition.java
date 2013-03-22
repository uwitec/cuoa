package com.oa.framework.paginaction;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 */
public abstract class Condition implements  Serializable, Cloneable {
	
	private Logger logger=Logger.getLogger(Condition.class);
	private String orderByItem = "";
	private String groupByItem = "";
	private boolean isSQL = false;
	private String dataFilterExpressions="";
	private int pageSize = Page.DEFAULT_PAGE_SIZE;
	private int pageNo =1;
	private String returnMessage;//用于记录在service中返回的具体信息.以便在action 中使用
	private String countQueryString;//分页时的count查询字符串
	
	private boolean isConcatDataFilterExpressions=true;

	public abstract String getInitialHql();
	
	public Object clone() {
		Condition o = null;
		try {
			o = (Condition) super.clone();
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
		}
		return o;
	}
	
	public String getFilterHql(){
		if(StringUtils.isNotBlank(dataFilterExpressions)&&isConcatDataFilterExpressions){
			return getInitialHql() + dataFilterExpressions;
		}else{
			return getInitialHql();
		}
	}

	public String getCompleteHql() {
		String completeHql=getFilterHql();
		if (!groupByItem.equals(""))
			completeHql += " group by " + groupByItem;
		if (!orderByItem.equals(""))
			completeHql += " order by " + orderByItem;
		System.out.println(completeHql);
		return completeHql;
	}

	
	public Query getHibernateQuery(Session session){
		Query query = null;
		if(isSQL){
			query = session.createSQLQuery(this.getCompleteHql());
		}else{
			query = session.createQuery(this.getCompleteHql());
		}
		query = this.preparedParams(query);
		return query;	
	}
	
	public Query getHibernateCountQuery(Session session){
		Query query = null;
		if(StringUtils.isBlank(countQueryString)){
			countQueryString = "select count(*) " + trimSelect(this.getFilterHql());
		}
		if(isSQL){
			query = session.createSQLQuery(countQueryString);
		}else{
			query = session.createQuery(countQueryString);
		}
		query = this.preparedParams(query);
		return query;
	}
	
	private String trimSelect(String hql){
		return StringUtils.mid(hql,StringUtils.indexOf(hql,"from"),hql.length());
	}
	
	public Query preparedParams(Query query){return query;}; 

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public String getReturnMessage() {
		return returnMessage;
	}

	public void setReturnMessage(String returnMessage) {
		this.returnMessage = returnMessage;
	}

	public boolean getIsSQL() {
		return isSQL;
	}

	public void setIsSQL(boolean isSQL) {
		this.isSQL = isSQL;
	}

	public String getDataFilterExpressions() {
		return dataFilterExpressions;
	}

	public void setDataFilterExpressions(String dataFilterExpressions) {
		this.dataFilterExpressions = dataFilterExpressions;
	}

	public String getCountQueryString() {
		return countQueryString;
	}

	public void setCountQueryString(String countQueryString) {
		this.countQueryString = countQueryString;
	}
	public String getGroupByItem() {
		return groupByItem;
	}

	public void setGroupByItem(String groupByItem) {
		this.groupByItem = groupByItem;
	}

	public String getOrderByItem() {
		return orderByItem;
	}

	public void setOrderByItem(String orderByItem) {
		this.orderByItem = orderByItem;
	}

	public boolean isConcatDataFilterExpressions() {
		return isConcatDataFilterExpressions;
	}

	public void setConcatDataFilterExpressions(boolean isConcatDataFilterExpressions) {
		this.isConcatDataFilterExpressions = isConcatDataFilterExpressions;
	}
	
}
