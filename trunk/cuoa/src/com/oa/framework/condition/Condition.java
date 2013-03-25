package com.oa.framework.condition;

import java.io.Serializable;

import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;
import org.hibernate.Session;

import com.oa.framework.struts.Page;
import com.oa.global.constants.ESortType;


/**
 */
@SuppressWarnings("serial")
public abstract class Condition implements  Serializable, Cloneable {
	
	private String sortname;//排序字段
	private String sortorder=ESortType.DESC.getCode();//升序/降序(默认)
	private int pageSize = Page.DEFAULT_PAGE_SIZE;
	private int pageNo =Page.DEFAULT_PAGE_NO;
	private boolean isSQL = false;
	private String dataFilterExpressions="";
	private boolean isConcatDataFilterExpressions=true;
	
	private Integer pageSizeE;//用于记录导出时网页上每页有多少行数据
	private Integer pageNumE;//计录导出时当前的页码号
	private String importRange;
	private String pageNums;
	
	private Integer role;
	private String ids;
	
	/**
	 * sql/hql
	 * @return
	 */
	public abstract String getInitialHql();
	/**
	 * 设置参数
	 * @param query
	 * @return
	 */
	public abstract Query preparedParams(Query query); 
	
	public String getFilterHql(){
		if(StringUtils.isNotBlank(dataFilterExpressions)&&isConcatDataFilterExpressions){
			return getInitialHql() + dataFilterExpressions;
		}else{
			return getInitialHql();
		}
	}

	public String getCompleteHql() {
		String completeHql = getFilterHql();
		if (StringUtils.isNotBlank(getSortname())) {
			completeHql += " order by " + getSortname()+" "+getSortorder();
		}
		return completeHql;
	}

	private String getMainAlias(String hql) {
		String behindPartLow = hql.toLowerCase();
		int lct0 = behindPartLow.indexOf("from ");
		String behindPart = hql.substring(lct0 + 5, hql.length());
		String mainDomainName = behindPart.split(" ")[0];
		String behindPartDeleteDomain = behindPart.replaceFirst(mainDomainName, "").trim();
		return behindPartDeleteDomain.split(" ")[0];
	}
	
	public Query getHibernateQuery(Session session){
		Query query = null;
		String queryString=this.getCompleteHql();
		if(isSQL){
			query = session.createSQLQuery(queryString);
		}else{
			query = session.createQuery(queryString);
		}
		query = this.preparedParams(query);
		return query;	
	}

	public Query getHibernateCountQuery(Session session){
		Query query = null;
		String countQueryString = "select count(*) " + trimSelect(this.getCompleteHql());
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
	public boolean isConcatDataFilterExpressions() {
		return isConcatDataFilterExpressions;
	}

	public void setConcatDataFilterExpressions(boolean isConcatDataFilterExpressions) {
		this.isConcatDataFilterExpressions = isConcatDataFilterExpressions;
	}
	public String getSortname() {
		return sortname;
	}
	public void setSortname(String sortname) {
		this.sortname = sortname;
	}
	public String getSortorder() {
		return sortorder;
	}
	public void setSortorder(String sortorder) {
		this.sortorder = sortorder;
	}
	public Integer getPageSizeE() {
		return pageSizeE;
	}
	public void setPageSizeE(Integer pageSizeE) {
		this.pageSizeE = pageSizeE;
	}
	public Integer getPageNumE() {
		return pageNumE;
	}
	public void setPageNumE(Integer pageNumE) {
		this.pageNumE = pageNumE;
	}
	public String getImportRange() {
		return importRange;
	}
	public void setImportRange(String importRange) {
		this.importRange = importRange;
	}
	public String getPageNums() {
		return pageNums;
	}
	public void setPageNums(String pageNums) {
		this.pageNums = pageNums;
	}
	public Integer getRole() {
		return role;
	}
	public void setRole(Integer role) {
		this.role = role;
	}
//	public String getBatchIds() {
//		return batchIds;
//	}
//	public void setBatchIds(String batchIds) {
//		this.batchIds = batchIds;
//	}
	
	private static String getMainAlias1(String hql) {
		String behindPartLow = hql.toLowerCase();
		int lct0 = behindPartLow.indexOf("from ");
		String behindPart = hql.substring(lct0 + 5, hql.length());
		String mainDomainName = behindPart.split(" ")[0];
		String behindPartDeleteDomain = behindPart.replaceFirst(mainDomainName, "").trim();
		return behindPartDeleteDomain.split(" ")[0];
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
}
