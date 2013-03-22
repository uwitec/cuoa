package com.oa.framework.paginaction;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Page<E> implements  Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1730123421731807246L;

	public static int DEFAULT_PAGE_SIZE = 25;

	public int pageSize = DEFAULT_PAGE_SIZE;

	private long start;

	private long totalCount;
	
	private List<E> data;
	
	private String conditionName = "condition";

	public Page() {
		this(0, 0, DEFAULT_PAGE_SIZE,new ArrayList<E>());
	}

	public Page(long start, long totalSize, int pageSize,List<E> data) {
		this.pageSize = pageSize;
		this.start = start;
		this.totalCount = totalSize;
		this.data = data;
	}

	public long getTotalCount() {
		return this.totalCount;
	}

	public  long getTotalPageCount() {
		if (totalCount % pageSize == 0)
			return totalCount / pageSize;
		else
			return totalCount / pageSize + 1;
	}

	public int getPageSize() {
		return pageSize;
	}

	public int getCurrentPageNo() {
		long pageNo = start / pageSize + 1;
		Long lPageNo = new Long(pageNo);
		return lPageNo.intValue();
	}

	public boolean hasNextPage() {
		return this.getCurrentPageNo() < this.getTotalPageCount();
	}

	public boolean hasPreviousPage() {
		return this.getCurrentPageNo() > 1;
	}

	protected static int getStartOfPage(int pageNo) {
		return getStartOfPage(pageNo, DEFAULT_PAGE_SIZE);
	}

	public static int getStartOfPage(int pageNo, int pageSize) {
		return (pageNo - 1) * pageSize;
	}

	public List<E> getData() {
		return data;
	}

	public void setData(List<E> data) {
		this.data = data;
	}

	public long getStart() {
		return start;
	}

	public void setStart(long start) {
		this.start = start;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public void setTotalCount(long totalCount) {
		this.totalCount = totalCount;
	}

	public String getConditionName() {
		return conditionName;
	}

	public void setConditionName(String conditionName) {
		this.conditionName = conditionName;
	}
}