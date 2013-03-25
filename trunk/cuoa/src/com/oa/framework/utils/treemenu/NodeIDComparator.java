/**
 * 
 */
package com.oa.framework.utils.treemenu;

import java.util.Comparator;

/**
 * Description:
 * NodeIDComparator.java Create on 2013-3-22 下午05:20:10 
 * @author YJN
 * @Description: TODO 
 */
@SuppressWarnings("rawtypes")
public class NodeIDComparator implements Comparator {
	// 按照节点编号比较
	    public int compare(Object o1, Object o2) {
	        int j1 = Integer.parseInt(((Node)o1).id);
	        int j2 = Integer.parseInt(((Node)o2).id);
	        return (j1 < j2 ? -1 : (j1 == j2 ? 0 : 1));
	    }  

}
