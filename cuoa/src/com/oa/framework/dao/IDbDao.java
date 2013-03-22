package com.oa.framework.dao;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.springframework.orm.hibernate3.HibernateTemplate;

import com.oa.framework.paginaction.Condition;
import com.oa.framework.paginaction.Page;

/**
 * 针对hibernate通用数据库操作
 */
public interface IDbDao {
	/**
	 * 新增一个实体对象,并返回该实体对象持久化后的主键
	 * @param obj 要持久化的实体对象
	 * @return String 该实体对象持久化后的主键
	 */
	public Serializable addObjectBackPK_(Object obj);
	
	/**
	 * 删除对象
	 * @param obj
	 */
	public void deleteObject(Object obj);
	/**
	 * 新增或修改一个实体对象
	 * @param obj 要持久化或更新的实体对象
	 */
	public void saveOrUpdate(Object obj);
	/**
	 * 删除一个或多个持久化对象,专用于in操作.</br>
	 * 示例:delete from table where id in(:ids)
	 * @param c 要删除对象的查询条件
	 * @param s 占位符名称和占位符对应的值.其值是一个用逗号分隔的多个id串
	 * @return int 删除的记录数
	 */
	public int delAll(Condition c,String[] s);
	/**
	 * 更新一个持久化对象
	 * @param o 要更新的持久化对象
	 */
	public void update(Object o);
	
	/**
	 * 根据condition更新对象
	 * @param condition
	 * @return
	 */
	public int update(Condition condition);
	
	/**
	 * 更新或删除符合条件的所有对象
	 * 示例: update table set Property='xx' where ty='2' and td='3'
	 * @param condition 更新或删除的条件
	 * @return int 更新或删除的记录数
	 */
	public int updateOrDeleteAll(Condition condition);
	/**
	 * /**
	 * 更新一个或多个持久化对象,专用于in操作.</br>
	 * 示例:update table set Property1='x',Property2='xx' where id in(:ids)
	 * @param c 要更新对象的查询条件
	 * @param s 占位符名称和占位符对应的值.其值是一个用逗号分隔的多个id串
	 * @return int 更新的记录数
	 */
	public int updateAll(Condition condition,String[]s);
	/**
	 * 根据查询对象中的条件查询数据并返回分页列表
	 * @param condition
	 * @return Page Page.data属性中存放的是返回的数据列表
	 */
	public <E>Page<E> pagedQuery(Condition condition);
	/**
	 * 根据查询对象中的条件返回数据列表
	 * @param condition
	 * @return List 返回的数据列表
	 */
	public <E>List<E> queryObjectList(Condition condition);
	/**
	 * 返回指定的持久化实体对象
	 * @param c 持久化对象的实体类
	 * @param id 持久化对象的主键id
	 * @return Object 具体持久化对象
	 */
	public <T extends Object> T getObject(Class<T> c ,Serializable id);
	
	/**
	 * 加载对象
	 * @param object
	 * @param id
	 * @return
	 */
	public void load(Object object,Serializable id);
	
	
	/**
	 * 加载对名
	 * @param entityClass
	 * @param id
	 */
	public Object load(Class entityClass,Serializable id);
	
	
	/**
	 * 按c指定的实体和columnName指定的属性,查找值等于columnValue的对象
	 * @param <T>
	 * @param c
	 * @param columnName
	 * @param columnValue
	 * @return
	 */
	public <E extends Object>boolean getObjectForColumn(Class<E> c ,String columnName,Object columnValue);
	/**
	 * 检查实体obj 在数据库中是否已经存在
	 * @param obj 要检查的实体
	 * @param checkColumn 要包含的列
	 * @param notCheckColumn 要排除的列
	 * @return 如果存在,返回字符串y,否则返回n.如果checkColumn没有数据,返回字符串:checkColumn 没有数据!
	 * @throws HibernateException
	 * @throws SecurityException
	 * @throws IllegalArgumentException
	 * @throws NoSuchMethodException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	public String CheckObjectColumn(Object obj,String[] checkColumn,String[] notCheckColumn) throws HibernateException, SecurityException, IllegalArgumentException, NoSuchMethodException, IllegalAccessException, InvocationTargetException; 
	/**
	 * 根据查询对象中的条件查询满足条件的记录总数并返回
	 * @param condition
	 * @return long 查询到的记录总数
	 */
	public long count(Condition condition); 	
	/**
	 * 从Hibernate的Cache中获取指定的持久化对象
	 * @param c 持久化对象的实体类
	 * @param id 持久化对象的主键id
	 * @return Object 具体持久化对象
	 */
	public <T extends Object> T getObjectForCache(Class<T> c ,String id);
	/**
	 * 从Hibernate的session中移除指定持久化对象.让Hibernate不再管理该对象.</br>
	 * 实现方法:org.springframework.orm.hibernate3.support.HibernateDaoSupport.getHibernateTemplate().evict(o);
	 * @param o
	 */
	public void evict(Object o);
	
	/**
	 * 刷新hibernate session
	 */
	public void flush();
	/**
	 * 从Hibernate的session中移除所有持久化对象.让Hibernate不再管理该对象.</br> 
	 */
	public void clear();
	/**
	 * 返回指定Class类型的所有记录
	 * @param 要返回的实体类对象类型
	 * @return 指定Class类型的所有记录
	 */
	public <E>List<E> loadAll(Class<E> c);
	
	public long returnCount(Condition condition);
	
	
	/**
	 * 查询唯一结果
	 * @param condition
	 * @return
	 */
	public Object uniqueResult(Condition condition);
	
	/**
	 * 导出excel
	 * @param condition
	 * @param pageSize
	 * @param path
	 * @param filename
	 * @param extension
	 * @param title
	 * @return
	 */
	public String exportExcel(Condition condition,int pageSize,String path,String filename,String extension,String title);
	
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
	public String exportExcel(Condition condition,int pageSize,String path, String filename, String extension, String title, Integer... transCols);
	
	public Session getHibernateSession();
	
	public HibernateTemplate getHibernateTemplate();
	
	/**
	 * 特殊的分页查询，根据整个hql语句查询记录总数
	 * @param <E>
	 * @param condition
	 * @return
	 */
	public <E>Page<E> specialPagedQuery(Condition condition);
	
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
	public String CheckObjectColumnNotDeleted(Object obj,String[] checkColumn,String[] notCheckColumn, String deletedColumnName) throws HibernateException, SecurityException, IllegalArgumentException, NoSuchMethodException, IllegalAccessException, InvocationTargetException;
	
	/**
	 * byte强制转为字符串操作的列的序号(从0开始)
	 * @param condition
	 * @param pageSize
	 * @param path
	 * @param filename
	 * @param extension
	 * @param title
	 * @param transCols
	 * @return
	 */
	public String exportExcelByte(Condition condition,int pageSize,String path, String filename, String extension, String title, Integer... transCols);
}