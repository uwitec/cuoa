package com.oa.framework.dao;

import java.io.Serializable;
import java.lang.reflect.InvocationTargetException;
import java.util.List;
import java.util.Map;

import org.hibernate.HibernateException;

import com.oa.framework.condition.Condition;
import com.oa.framework.struts.Page;
import com.oa.global.exception.NameIsExistException;



/**
 * dao基类接口
 */
public interface IBaseDao {
	
	/**
	 * 增加实例
	 * 
	 * @param o
	 * @throws DaoException
	 */
	public String addObject(Object o);
	
	/**
	 * 修改实例
	 * 
	 * @param o
	 * @throws DaoException
	 */
	public void updateObject(Object o);
	
	/**
	 * 保存或修改实例
	 * 
	 * @param o
	 * @throws DaoException
	 */
	public void addOrUpdate(Object o);
	
	/**
	 * 更新或删除符合条件的所有对象
	 *
	 * @param condition
	 * @return int
	 */
	public int updateOrDeleteAll(Condition condition);

	/**
	 * 删除实例
	 * 
	 * @param o
	 * @throws DaoException
	 */
	public void deleteObject(Object o);
	
	/**
	 * 通过主键获得对象
	 *
	 * @param c
	 * @param id
	 * @return T
	 */
	public <T extends Object> T getObject(Class<T> c ,Serializable id);
	
	/**
	 * 查询数据列表
	 * 
	 * @param condition
	 * @return List
	 */
	public <E>List<E> queryObjectList(Condition condition);
	
	/**
	 * 查询分页列表
	 * 
	 * @param condition
	 * @return Page
	 */
	public <E>Page<E> queryPage(Condition condition);
	
	/**
	 * 查询记录总数
	 * 
	 * @param condition
	 * @return long
	 */
	public long queryCount(Condition condition);
	/**
	 * 查询返回唯一一个值
	 * @param <E>
	 * @param condition
	 * @return
	 */
	public <E> E uniqueResult(Condition condition);
	/**
	 * 判断名称是否重复
	 * @param domainClazz 必填+
	 * @param name 必填
	 * @param where 选填
	 * @throws NameIsExistException
	 */
	public void validHasSameName(Class domainClazz,String name,String where) throws NameIsExistException;
	
	/**
	 *  查询下一个顺延序号sort   ==max(sort)+1
	 * @param domainClazz 必填
	 * @param where 选填
	 * @return
	 */
	public int getNextSort(Class domainClazz,String where) ;

	/**
	 * Description: 查询数据用于导出(根据数据序号查询)
	 * Date:2012-9-8
	 * @author YJN
	 * @return List<Map<String,Object>>
	 */
	public List<Map<String, Object>> queryForExport(Condition condition);

	/**
	 * Description:
	 * Date:2012-9-24
	 * @author YJN
	 * @return String
	 */
	String CheckObjectColumnNotDeleted(Object obj, String[] checkColumn,
			String[] notCheckColumn, String deletedColumnName)
			throws HibernateException, SecurityException,
			IllegalArgumentException, NoSuchMethodException,
			IllegalAccessException, InvocationTargetException;
}
