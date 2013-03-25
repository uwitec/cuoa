package com.oa.framework.struts;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Page<E> implements  Serializable {

	private static final long serialVersionUID = 1730123421731807246L;

	public static int DEFAULT_PAGE_SIZE = 20;
	
	public static int DEFAULT_PAGE_NO=1;

    private int pageSize; // 页面大小 需赋值
    
    private int pageNo; // 页码 1based 需赋值
   
    private long recordSize; // 数据总数 需赋值
   
    private List<E> data;

    public Page() {
		this(DEFAULT_PAGE_NO , DEFAULT_PAGE_SIZE , 0 , new ArrayList<E>());
	}
    
	public Page(int pageNo,int pageSize, long recordSize, List<E> data) {
		super();
		this.pageSize = pageSize;
		this.pageNo = pageNo;
		this.recordSize = recordSize;
		this.data = data;
	}
    
	public static int getStartOfPage(int pageNo, int pageSize) {
		return (pageNo - 1) * pageSize;
	}

	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}

	public long getRecordSize() {
		return recordSize;
	}

	public void setRecordSize(long recordSize) {
		this.recordSize = recordSize;
	}

	public List<E> getData() {
		return data;
	}

	public void setData(List<E> data) {
		this.data = data;
	}
	
	
}