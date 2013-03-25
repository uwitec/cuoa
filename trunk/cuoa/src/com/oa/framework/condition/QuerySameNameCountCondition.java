package com.oa.framework.condition;


import org.apache.commons.lang.StringUtils;
import org.hibernate.Query;

/**
 *查询相同名字的记录个数    所有的
 * @author sunchuanbao
 *
 */
public class QuerySameNameCountCondition extends Condition {
	private Class clazz;//要查询sort类的class 如：查询City  clazz=City.class
	private String name;//name
	private String where;//where 语句，添加查询条件
	
	@Override
	public String getInitialHql() {
		StringBuffer buffer=new StringBuffer();
		buffer.append("select count(*) from ");
		buffer.append(clazz.getName()+" clazz ");
		buffer.append(" where clazz.name=:name");
		buffer.append(trimWhere(where));
		return buffer.toString();
	}

	@Override
	public Query preparedParams(Query query) {
		query.setString("name", name);
		return query;
	}

	private QuerySameNameCountCondition() {
		super();
	}
	/**
	 * 构造函数  
	 * @param domainClazz 不能为空
	 * @param name 不能为空
	 */
	public QuerySameNameCountCondition(Class domainClazz,String name) {
		super();
		this.clazz = domainClazz;
		this.name=name;
	}
	/**
	 * 构造函数  
	 * @param domainClazz 不能为空
	 * @param name 不能为空
	 * @param where 可以为空
	 */
	public QuerySameNameCountCondition(Class domainClazz,String name,String where) {
		super();
		this.clazz = domainClazz;
		this.name=name;
		this.where=where;
	}
	public static String trimWhere(String where){
		String trimWhere="";
		if(StringUtils.isNotBlank(where)){
			trimWhere=where.replaceFirst("^\\s*where\\s*", "");
			if(!(trimWhere.startsWith("and"))){
				trimWhere=" and " + trimWhere;
			}
		}
		return trimWhere;
	}
	public static void main(String[] args) {
		System.out.println("1"+trimWhere(" where   and state=1 "));
	}
}
