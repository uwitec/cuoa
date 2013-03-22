package com.oa.framework.dao;


import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;

import org.directwebremoting.util.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.oa.framework.paginaction.Condition;
import com.oa.framework.paginaction.Page;
import com.oa.framework.utils.file.FileUtilException;
import com.oa.framework.utils.file.FileUtils;
import com.oa.framework.utils.ref.RefUtil;

/**
 * 针对hibernate通用数据库操作实现
 * 
 * @spring.bean id ="***ServiceTarget"
 */ 
public class DbDaoImpl extends HibernateDaoSupport implements  IDbDao {

	private Logger logger = Logger.getLogger(DbDaoImpl.class);
	
	public Serializable addObjectBackPK_(Object obj) {
		return getHibernateTemplate().save(obj);
	}
	
	public void deleteObject(Object obj){
		getHibernateTemplate().delete(obj);
	}

	public void saveOrUpdate(Object obj) {
		this.getHibernateTemplate().saveOrUpdate(obj);
	}
	
	public int delAll(Condition c,String[] s){
		List<String> l = Arrays.asList(s[1].split(","));
		Query q = c.getHibernateQuery(this.getSession());
		q.setParameterList(s[0], l);
		return q.executeUpdate();
	}
	public void update(Object obj){
		this.getHibernateTemplate().update(obj);
	}
	
	public int update(Condition condition){
		Query query=condition.getHibernateQuery(this.getSession());
		return query.executeUpdate();
	}
	public int updateAll(Condition c,String[] s){
		List<String> l = Arrays.asList(s[1].split(","));
		Query q = c.getHibernateQuery(this.getSession());
		q.setParameterList(s[0], l);
		return q.executeUpdate();
	}
	public int updateOrDeleteAll (Condition c){
		Query q = c.getHibernateQuery(this.getSession());
		return q.executeUpdate();
	}
	
	@SuppressWarnings("unchecked")
	public <E>Page<E> pagedQuery(Condition condition) {
		int pageNo = condition.getPageNo();
		int pageSize = condition.getPageSize();
		long totalCount = this.count(condition);
		if (totalCount < 1)
			 return new Page<E>();
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		
		if(startIndex >= totalCount){		
			return this.lastOfPagedQuery(condition);
		}
		Query query = condition.getHibernateQuery(this.getSession());
	
		List<E> list = query.setFirstResult(startIndex).setMaxResults(pageSize).list();
		return new Page<E>(startIndex, totalCount, pageSize, list);
	}
	
	public long count(Condition condition) {
		Query query = condition.getHibernateCountQuery(this.getSession());
		long totalCount=0;
		try {
			totalCount = Long.valueOf(query.uniqueResult().toString());
			condition.setCountQueryString(null);    //////////  add 2010-5-11   
		} catch (Exception e) {
			e.printStackTrace();
			totalCount = 0;
		} catch (Error e) {
			e.printStackTrace();
		}
		return totalCount;
	}
	private <E>Page<E> lastOfPagedQuery(Condition condition){
		long totalCount = this.count(condition);
		int pageNo ;
		if (totalCount % condition.getPageSize() == 0)
			pageNo = new Long(totalCount / condition.getPageSize()).intValue();
		else
			pageNo =  new Long(totalCount / condition.getPageSize() + 1).intValue();
		condition.setPageNo(pageNo);
		return pagedQuery(condition);
	}

	@SuppressWarnings("unchecked")
	public <E>List<E> queryObjectList(Condition condition){

		Query query = condition.getHibernateQuery(this.getSession());
		return query.list();
	}
	
	@SuppressWarnings("unchecked")
	public <T extends Object> T getObject(Class<T> c ,Serializable id){
		return (T)this.getHibernateTemplate().get(c, id);
	}
	
	
	/**
	 * 加载对象
	 * @param object
	 * @param id
	 * @return
	 */
	public void load(Object object,Serializable id){
		 this.getHibernateTemplate().load(object,id);
	}
	/**
	 * 加载对名
	 * @param entityClass
	 * @param id
	 */
	public Object load(Class entityClass,Serializable id){
		return this.getHibernateTemplate().load(entityClass, id);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public <E extends Object> boolean getObjectForColumn(Class<E> c, String columnName,Object columnValue) {
			List l = this.getHibernateTemplate().find("from "+c.getName()+" where "+columnName+" = ?", columnValue);
		return l.size()>0?true:false;
	}
	
	@Override
	public String CheckObjectColumn(Object obj,String[] checkColumn,String[] notCheckColumn) throws HibernateException, SecurityException, IllegalArgumentException, NoSuchMethodException, IllegalAccessException, InvocationTargetException {
		String hql = "select count(*) from ";
		hql += obj.getClass().getCanonicalName();
		if(checkColumn!=null && checkColumn.length>0){
			for(int i=0; i<checkColumn.length; i++){
				if(i>0){
					hql += " and "+checkColumn[i] +" = :"+checkColumn[i];
				}else{
					hql += " where "+checkColumn[i] +" = :"+checkColumn[i];
				}
			}
			if(notCheckColumn!=null && notCheckColumn.length>0){
				for(int i=0;i<notCheckColumn.length; i++){
					hql +=" and "+notCheckColumn[i]+" != :"+notCheckColumn[i];
				}
			}
			Query query = this.getHibernateSession().createQuery(hql);
			for(String column:checkColumn){
				query.setParameter(column, RefUtil.returnMethod(obj, column));
			}
			if(notCheckColumn!=null && notCheckColumn.length>0){
				for(String column:notCheckColumn){
					query.setParameter(column, RefUtil.returnMethod(obj, column));
				}
			}
			Long t = (Long)query.uniqueResult();
			return t>0?"y":"n";
		}else{
			return "checkColumn 没有数据!";
		}
	}

	@SuppressWarnings("unchecked")
	public <T extends Object> T getObjectForCache(Class<T> c ,String id){
		return (T)this.getHibernateTemplate().load(c, id);
	}
	//清除session缓存（一级缓存）中的特定的对象
	public void evict(Object o) {
		this.getHibernateTemplate().evict(o);
	}
	
	//清除session缓存（一级缓存）中的所有的对象
	public void clear() {
		this.getHibernateTemplate().clear();
	}
	
	
	/**
	 * 刷新hibernate session
	 */
	public void flush(){
		this.getHibernateTemplate().flush();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public <E>List<E> loadAll(Class<E> c){
		return this.getHibernateTemplate().loadAll(c);
	}
	
	
	public long returnCount(Condition condition){
		Query query = condition.getHibernateQuery(this.getSession());
		long totalCount=0;
		try {
			totalCount = Long.valueOf(query.uniqueResult().toString());
		} catch (Exception e) {
			totalCount = 0;
		}
		return totalCount;
	}
	
	/**
	 * 查询唯一结果
	 * @param condition
	 * @return
	 */
	public Object uniqueResult(Condition condition){
		Query query = condition.getHibernateQuery(this.getSession());
		return query.setMaxResults(1).uniqueResult();
	}
	
	
	/**
	 * 导出excel
	 * @param condition  导出数据的查询条件
	 * @param pageSize   每次导出数据的条数
	 * @param path       文件保存路径
	 * @param filename   文件名称
	 * @param title      EXCEL文件头
	 * @param extension  文件扩展名
	 * @return
	 */
	public String exportExcel(Condition condition,int pageSize,String path,String filename,String extension,String title){
		long count=((Number)condition.getHibernateCountQuery(this.getSession()).uniqueResult()).longValue();
		if(count==0){
			condition.setReturnMessage("导出的数据结果为空!");
			return null;
		}
		int pageCount=(int)count/pageSize;
		pageCount=count%pageSize>0?pageCount+1:pageCount;
		
		String tempPath=path+"temp/"+filename;
		FileUtils.createPath(tempPath);//创建文件目录
		List<Object[]> data=null;
		Query query=null;
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream(tempPath+"/"+filename+extension, true),"gbk");
			osw.write(title);
			osw.write("\r\n");
			for(int i=0;i<pageCount;i++){
				query=condition.getHibernateQuery(this.getSession());
				query.setFirstResult(pageSize*i).setMaxResults(pageSize);
				data=query.list();
				for(Object[] item:data){
					for(int j=0;j<item.length;j++){
						if(j>0){
							osw.write(",");
						}
						osw.write("\"");
						if(item[j]!=null&&item[j].getClass()==java.sql.Timestamp.class){
							osw.write(format.format((Timestamp)item[j]));
						}else{
							osw.write(item[j]!=null?item[j].toString():" ");
						}
//						if(item[j]!=null&&item[j].getClass()==java.lang.String.class){
//							osw.write("\t");//避免数字形式的字符串被处理成数字
//						}
						osw.write("\"");
					}
					osw.write("\r\n");
				}
			}
			osw.close();
			String zipFile=path+filename+".zip";
			FileUtils.zip(zipFile, tempPath);
			System.out.println(zipFile);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("导出文件失败!");
		}finally{
			try {
				FileUtils.deleteFile(tempPath);
			} catch (FileUtilException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println(FileUtils.getFileParam("exportExcelDownLoadPath")+filename+".zip");
		return FileUtils.getFileParam("exportExcelDownLoadPath")+filename+".zip";
	}
	
	/**
	 * 导出excel
	 * @param condition
	 * @param pageSize
	 * @param path
	 * @param filename
	 * @param extension
	 * @param title
	 * @param transCols 强制转为字符串操作的列的序号(从0开始)
	 * @return
	 */
	public String exportExcel(Condition condition,int pageSize,String path, String filename, String extension, String title, Integer... transCols){
		long count=((Number)condition.getHibernateCountQuery(this.getSession()).uniqueResult()).longValue();
		if(count==0){
			condition.setReturnMessage("导出的数据结果为空!");
			return null;
		}
		int pageCount=(int)count/pageSize;
		pageCount=count%pageSize>0?pageCount+1:pageCount;
		
		String tempPath=path+"temp/"+filename;
		FileUtils.createPath(tempPath);//创建文件目录
		List<Object[]> data=null;
		Query query=null;
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream(tempPath+"/"+filename+extension, true),"gbk");
			osw.write(title);
			osw.write("\r\n");
			for(int i=0;i<pageCount;i++){
				query=condition.getHibernateQuery(this.getSession());
				query.setFirstResult(pageSize*i).setMaxResults(pageSize);
				data=query.list();
				for(Object[] item:data){
					for(int j=0;j<item.length;j++){
						if(j>0){
							osw.write(",");
						}
						osw.write("\"");
						if(item[j]!=null&&item[j].getClass()==java.sql.Timestamp.class){
							osw.write(format.format((Timestamp)item[j]));
						}else if(item[j]!=null&&item[j] instanceof byte[]){
							osw.write(item[j]!=null?new String((byte[])item[j]):" ");
						}else{
							osw.write(item[j]!=null?item[j].toString():" ");
						}
						for (Integer transCol: transCols) {
							if (transCol.intValue() == j) {
								if(item[j]!=null&&item[j].getClass() == java.lang.String.class){
									osw.write("\t");//避免数字形式的字符串被处理成数字
								}
							}
						}
						osw.write("\"");
					}
					osw.write("\r\n");
				}
			}
			osw.close();
			String zipFile=path+filename+".zip";
			FileUtils.zip(zipFile, tempPath);
			System.out.println(zipFile);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("导出文件失败!");
		}finally{
			try {
				FileUtils.deleteFile(tempPath);
			} catch (FileUtilException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println(FileUtils.getFileParam("exportExcelDownLoadPath")+filename+".zip");
		return FileUtils.getFileParam("exportExcelDownLoadPath")+filename+".zip";
	}
	
	/**
	 * 导出excel
	 * @param condition
	 * @param pageSize
	 * @param path
	 * @param filename
	 * @param extension
	 * @param title
	 * @param transCols byte强制转为字符串操作的列的序号(从0开始)
	 * @return
	 */
	public String exportExcelByte(Condition condition,int pageSize,String path, String filename, String extension, String title, Integer... transCols){
		long count=((Number)condition.getHibernateCountQuery(this.getSession()).uniqueResult()).longValue();
		if(count==0){
			condition.setReturnMessage("导出的数据结果为空!");
			return null;
		}
		int pageCount=(int)count/pageSize;
		pageCount=count%pageSize>0?pageCount+1:pageCount;
		
		String tempPath=path+"temp/"+filename;
		FileUtils.createPath(tempPath);//创建文件目录
		List<Object[]> data=null;
		Query query=null;
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream(tempPath+"/"+filename+extension, true),"gbk");
			osw.write(title);
			osw.write("\r\n");
			for(int i=0;i<pageCount;i++){
				query=condition.getHibernateQuery(this.getSession());
				query.setFirstResult(pageSize*i).setMaxResults(pageSize);
				data=query.list();
				for(Object[] item:data){
					for(int j=0;j<item.length;j++){
						if(j>0){
							osw.write(",");
						}
						osw.write("\"");
						if(item[j]!=null&&item[j].getClass()==java.sql.Timestamp.class){
							osw.write(format.format((Timestamp)item[j]));
						}else if(item[j]!=null&&item[j] instanceof byte[]){
							for (Integer transCol: transCols) {
								if (transCol.intValue() == j) {
									osw.write(item[j]!=null?new String((byte[])item[j]):" ");
								}
							}
						}else{
							osw.write(item[j]!=null?item[j].toString():" ");
						}
						osw.write("\"");
					}
					osw.write("\r\n");
				}
			}
			osw.close();
			String zipFile=path+filename+".zip";
			FileUtils.zip(zipFile, tempPath);
			System.out.println(zipFile);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("导出文件失败!");
		}finally{
			try {
				FileUtils.deleteFile(tempPath);
			} catch (FileUtilException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println(FileUtils.getFileParam("exportExcelDownLoadPath")+filename+".zip");
		return FileUtils.getFileParam("exportExcelDownLoadPath")+filename+".zip";
	}
	
	public Session getHibernateSession(){
		return this.getSession();
	}
	
	/**
	 * 特殊的分页查询，根据整个hql语句查询记录总数
	 * @param <E>
	 * @param condition
	 * @return
	 */
	public <E>Page<E> specialPagedQuery(Condition condition) {
		int pageNo = condition.getPageNo();
		int pageSize = condition.getPageSize();
		long totalCount = this.queryObjectList(condition).size();   //根据整个hql语句查询记录总数
		if (totalCount < 1)
			 return new Page<E>();
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		
		if(startIndex >= totalCount){		
			return this.lastOfPagedQuery(condition);
		}
		Query query = condition.getHibernateQuery(this.getSession());
	
		List<E> list = query.setFirstResult(startIndex).setMaxResults(pageSize).list();
		return new Page<E>(startIndex, totalCount, pageSize, list);
	}

	
	/**
	 * 检查实体obj 在数据库中是否已经存在 (删除的记录不算)
	 * @param obj
	 * @param checkColumn
	 * @param notCheckColumn
	 * @param deletedColumnName
	 * @return
	 * @throws HibernateException
	 * @throws SecurityException
	 * @throws IllegalArgumentException
	 * @throws NoSuchMethodException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	public String CheckObjectColumnNotDeleted(Object obj,String[] checkColumn,String[] notCheckColumn, String deletedColumnName) throws HibernateException, SecurityException, IllegalArgumentException, NoSuchMethodException, IllegalAccessException, InvocationTargetException {
		String hql = "select count(*) from ";
		hql += obj.getClass().getCanonicalName();
		if(checkColumn!=null && checkColumn.length>0){
			for(int i=0; i<checkColumn.length; i++){
				if(i>0){
					hql += " and "+checkColumn[i] +" = :"+checkColumn[i];
				}else{
					hql += " where "+ deletedColumnName +"=0 and "+checkColumn[i] +" = :"+checkColumn[i];
				}
			}
			if(notCheckColumn!=null && notCheckColumn.length>0){
				for(int i=0;i<notCheckColumn.length; i++){
					hql +=" and "+notCheckColumn[i]+" != :"+notCheckColumn[i];
				}
			}
			Query query = this.getHibernateSession().createQuery(hql);
			for(String column:checkColumn){
				query.setParameter(column, RefUtil.returnMethod(obj, column));
			}
			if(notCheckColumn!=null && notCheckColumn.length>0){
				for(String column:notCheckColumn){
					query.setParameter(column, RefUtil.returnMethod(obj, column));
				}
			}
			Long t = (Long)query.uniqueResult();
			return t>0?"y":"n";
		}else{
			return "checkColumn 没有数据!";
		}
	}	
	
	
//	private <T>List<T> convertResultSetToObjectList(List<Object[]> result, Class<T> clazz) throws Exception {
//		List<T> tempList = new ArrayList<T>();
//		try {
//		
//			T t = null;
//			for (Object[] objs:result) {
//				t = clazz.newInstance();
//				for (int i = 0; i < objs.length; i++) {
//					String fieldName = rsmd.getColumnLabel(i + 1);
//					BeanUtils.setProperty(t, fieldName, rs.getObject(fieldName));
//				}
//				tempList.add(t);
//			}
//		} catch (Exception e) {
//			e.printStackTrace();
//		} 
//		return tempList;// 返回填充完毕的数组列表集合对象
//	}

}