package com.oa.framework.dao;


import java.io.FileInputStream;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

import java.io.FileNotFoundException;
import java.lang.reflect.InvocationTargetException;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import com.oa.framework.condition.Condition;
import com.oa.framework.condition.QuerySameNameCountCondition;
import com.oa.framework.condition.QuerySortCondition;
import com.oa.framework.struts.Page;
import com.oa.framework.utils.ref.RefUtil;
import com.oa.framework.utils.string.StringUtil;
import com.oa.global.exception.NameIsExistException;



/**
 * DAO基类
 */
public class BaseDaoImpl implements IBaseDao{
	
	private SessionFactory sessionFactory;

	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}
	
	@Override
	public void updateObject(Object o) {
		getSession().update(o);
	}

	@Override
	public void addOrUpdate(Object o) {
		getSession().saveOrUpdate(o);
		
	}

	@Override
	public void deleteObject(Object o) {
		getSession().delete(o);
	}

	@Override
	public String addObject(Object o) {
		return getSession().save(o).toString();
	}

	@Override
	public int updateOrDeleteAll(Condition condition) {
		Query q = condition.getHibernateQuery(getSession());
		return q.executeUpdate();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public <T extends Object> T getObject(Class<T> c, Serializable id) {
		return (T)getSession().get(c, id);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public <E> List<E> queryObjectList(Condition condition) {
		Query query = condition.getHibernateQuery(getSession());
		return query.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public <E> Page<E> queryPage(Condition condition) {
		int pageNo = condition.getPageNo();
		int pageSize = condition.getPageSize();
		long totalCount = this.queryCount(condition);
		if (totalCount < 1)
			 return new Page<E>();
		int startIndex = Page.getStartOfPage(pageNo, pageSize);
		Query query = condition.getHibernateQuery(getSession());
		List<E> list = query.setFirstResult(startIndex).setMaxResults(pageSize).list();
		return new Page<E>(pageNo, pageSize , totalCount , list);
	}

	@Override
	public long queryCount(Condition condition) {
		Query query = condition.getHibernateCountQuery(getSession());
		long totalCount=0;
		try {
			totalCount = Long.valueOf(query.uniqueResult().toString());
		} catch (Exception e) {
			e.printStackTrace();
			totalCount = 0;
		} catch (Error e) {
			e.printStackTrace();
		}
		return totalCount;
	}
	
	private Session getSession(){
		return sessionFactory.getCurrentSession();
	}

	@Override
	public <E extends Object> E uniqueResult(Condition condition) {
		Query query = condition.getHibernateQuery(getSession());
		return (E)query.uniqueResult();
	}

	@Override
	public void validHasSameName(Class domainClazz,String name,String where) throws NameIsExistException {
		QuerySameNameCountCondition condition=new QuerySameNameCountCondition(domainClazz, name,where);
		Object object=this.uniqueResult(condition);
		long size=object==null?0l:(Long)object;
		if(size>0l){
			throw new NameIsExistException("the name is exist!");
		}
	}

	@Override
	public int getNextSort(Class domainClazz,String where) {
		QuerySortCondition condition=new QuerySortCondition(domainClazz,where);
		Object mxsort=this.uniqueResult(condition);
		int sort=mxsort==null?1:(Integer)mxsort+1;
		return sort;
	}
	/**
	 * 导入excel数据
	 * @return
	 * @author YJN
	 */
	public String excelImport(FileInputStream fs, List<String> columnNames, String tableName) {
		try {
            Workbook workbook = new HSSFWorkbook(fs);

            Sheet sheet = workbook.getSheetAt(0);
            int rowNum = sheet.getLastRowNum() + 1;
            StringBuilder insertSql = new StringBuilder();
            for(int i = 0 ; i < rowNum ; i++){
            	
            	//把表头做为字段名拼接至SQL
            	insertSql.append("insert into ").append(tableName).append("(id,");
            	for (String columnName: columnNames) {
            		insertSql.append(columnName).append(",");
            	}
            	insertSql.deleteCharAt(insertSql.length() - 1);
            	insertSql.append(") values ('").append(StringUtil.generateString()).append("',");
	            	
	            //进入每一个单元格取数据
                Row row = sheet.getRow(i);
                int cellNum = row.getLastCellNum() ;
                for(int j = 0 ; j < cellNum ; j++){
                    insertSql.append("'").append(row.getCell(j).getStringCellValue()).append("',");
                }
                insertSql.deleteCharAt(insertSql.length() - 1);
                insertSql.append(");");
                
                //插入数据
                getSession().createSQLQuery(insertSql.toString());
                insertSql.delete(0, insertSql.length());
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (Exception exception){
            exception.printStackTrace();
        }
        return "";
    }
	
	/**
	 * 处理导入的数据
	 * @param tableName
	 * @return
	 * @author YJN
	 */
	public String manageExcelData(String tableName) {
		StringBuilder message = new StringBuilder();
		message.append(this.manageRepeatData(tableName));
		message.append(this.courseMatching(tableName));
		return message.toString();
	}
	
	/**
	 * 处理重复数据，给重复数据做标识，并返回提示
	 * @param tableName
	 * @return
	 * @author YJN
	 */
	private String manageRepeatData(String tableName) {
		//分组连接语句，用于将重复数据的ID分组存至StringBuilder
		String cruxColumns = "year,term_name,gt_name,grade_name,subject_name,classlevel_name,classroom_name,start_date,start_time,teacher_name,passed_lesson_count";
		StringBuilder querySQL = new StringBuilder();
		querySQL.append("select group_concat(id) from ").append(tableName).append(" where is_deleted=0 group by ").append(cruxColumns)
		   .append(" having count(id) > 1");
		List resultList = getSession().createSQLQuery(querySQL.toString()).list();
		
		StringBuilder repeatIds = new StringBuilder();
		for (Object groupIds: resultList) {
			String[] groupIdsArr = groupIds.toString().split(",");
				for (int i = 0; i < groupIdsArr.length; i ++) {
					if (i >= 1) {
						repeatIds.append(groupIdsArr[i]).append(",");
					}
			}
		}
		if (repeatIds.length() == 0) {
			return "";
		} else {
			repeatIds.deleteCharAt(repeatIds.length() - 1);
		}
		//第个分组中除第一个ID以外，其他的ID对应的数据全部标识为重复数据，用于手动作废
		StringBuilder updateSQL = new StringBuilder();
		updateSQL.append("update ").append(tableName).append(" set if_managed=2 and set cause_type_of_failed=0 ")
		.append("where id in('").append(repeatIds).append("')");
		getSession().createSQLQuery(updateSQL.toString());
		//如果存在大于等于1条重复数据，返回提示语，表示有重复数据
		
		return "存在重复数据\n";
	}
	
	/**
	 * 全表班级匹配，给未匹配数据做标识，并返回提示
	 * @param tableName
	 * @return
	 * @author YJN
	 */
	private String courseMatching(String tableName) {
		//匹配时，如果发现此数据已被标识为重复数据，不对其进行匹配，后期每次修改数据时，都匹配一次
		
		//先把班级表ID和已导入的数据的ID做匹配查询，再把班级表ID更新至对应的导入数据中
		StringBuilder matchIdsSQL = new StringBuilder();
		matchIdsSQL.append("select detail.id, course.id ");
		matchIdsSQL.append("from ").append(tableName).append(" detail,py_course course,py_course_basic basic,py_course_location location ");
		matchIdsSQL.append("where course.basic_id=basic.id and course.location_id=location.id ");
		matchIdsSQL.append("and detail.if_managed<>1 and detail.is_deleted<>1 ");
		matchIdsSQL.append("and detail.year=basic.year ");
		matchIdsSQL.append("and detail.term_name=basic.term_name ");
		matchIdsSQL.append("and detail.grade_name=basic.grade_name ");
		matchIdsSQL.append("and detail.subject_name=basic.classlevel_name ");
		matchIdsSQL.append("and detail.classlevel_name=basic.classlevel_name ");
		matchIdsSQL.append("and detail.classroom_name=location.classroom_name ");
		matchIdsSQL.append("and detail.start_date=course.start_date ");
		matchIdsSQL.append("and detail.start_time_str=course.start_time_str");
		
		List matchIds = getSession().createSQLQuery(matchIdsSQL.toString()).list();
		StringBuilder updateSQL = new StringBuilder();
		for (Object object: matchIds) {
			List ids = (List)object;
			updateSQL.append("update ");
			updateSQL.append(tableName);
			updateSQL.append(" set course_id='");
			updateSQL.append(((List)object).get(1).toString());
			updateSQL.append("' and if_managed=1");
			updateSQL.append(" where id='");
			updateSQL.append(((List)object).get(0).toString());
			updateSQL.append("'");
			getSession().createSQLQuery(updateSQL.toString());
			updateSQL.delete(0, updateSQL.length());
		}
		
		//处理后，检查未处理的数据，设置其状态为：处理失败
		StringBuilder checkSQL = new StringBuilder();
		checkSQL.append("update ");
		checkSQL.append(tableName);
		checkSQL.append(" set if_managed=2 where (if_managed is null or if_managed = '') and is_deleted<>1");
		getSession().createSQLQuery(checkSQL.toString());
		checkSQL.delete(0, checkSQL.length());
		
		//处理后，检查处理失败且原因不是重复数据的数据，设置其失败原因类型为状态为：未成功匹配
		checkSQL.append("update ");
		checkSQL.append(tableName);
		checkSQL.append(" set cause_type_of_failed=1 where if_managed = 2 and cause_type_of_failed<>0");
		getSession().createSQLQuery(checkSQL.toString());
		checkSQL.delete(0, checkSQL.length());
		
		//检查失败原因为未成功匹配的数据的数量，如大于等于1条，返回提示语，表示有未匹配的数据
		checkSQL.append("select count(id) ");
		checkSQL.append("from ");
		checkSQL.append(tableName);
		checkSQL.append(" where cause_type_of_failed=1 ");
		checkSQL.append("and is_deleted<>1 ");
		int count = ((Number)(getSession().createSQLQuery(checkSQL.toString()).list().get(0))).intValue();
		
//		StringBuilder updateSQL = new StringBuilder();
//		updateSQL.append("update ").append(tableName).append(" set ");
//		for (String cruxColumn: cruxColumnArr) {
//			updateSQL.append("");
//		}
		//如果存在大于等于1条未成功匹配的数据，返回提示语，表示有未匹配的数据
		if (count > 0) {
			return "存在未匹配的数据";
		}
		return "";
	}
	
	/**
	 * (单条数据)处理重复数据，给重复数据做标识，并返回提示
	 * 用于修改班级时调用
	 * @param tableName
	 * @param id
	 * @return
	 */
	public String singleManageRepeatData(String tableName, String id) {
		return "";
	}
	
	/**
	 * 单条数据班级匹配，给未匹配数据做标识，并返回提示
	 * @param tableName
	 * @param id
	 * @return
	 * @author YJN
	 */
	public String singleCourseMatching(String tableName, String id) {
		return "";
	}
	
	/**
	 * Description: 查询数据用于导出(根据数据序号查询)
	 * Date:2012-9-8
	 * @author YJN
	 * @return List<Map<String,Object>>
	 */
	@Override
	public List<Map<String, Object>> queryForExport(Condition condition) {
		// TODO Auto-generated method stub
		return null;
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
	@Override
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
			Query query = this.getSession().createQuery(hql);
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
}
