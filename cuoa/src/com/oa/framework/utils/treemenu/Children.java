/**
 * 
 */
package com.oa.framework.utils.treemenu;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;

/**
 * Description:
 * Children.java Create on 2013-3-22 下午05:19:52 
 * @author YJN
 * @Description: TODO 
 */
public class Children {
	@SuppressWarnings("rawtypes")
	private List list = new ArrayList();
	    public int getSize() {
	        return list.size();
	    }
	    @SuppressWarnings("unchecked")
		public void addChild(Node node) {
	        list.add(node);
	    }
	    // 拼接孩子节点的JSON字符串
	    @SuppressWarnings("rawtypes")
		public String toString() {
	        String result = "[";       
	        for (Iterator it = list.iterator(); it.hasNext();) {
	            result += ((Node) it.next()).toString();
	            result += ",";
	        }
	        result = result.substring(0, result.length() - 1);
	        result += "]";
	        return result;
	    }
	    // 孩子节点排序
	    @SuppressWarnings({ "unchecked", "rawtypes" })
		public void sortChildren() {
	        // 对本层节点进行排序
	        // 可根据不同的排序属性，传入不同的比较器，这里传入ID比较器
	        Collections.sort(list, new NodeIDComparator());
	        // 对每个节点的下一层节点进行排序
	        for (Iterator it = list.iterator(); it.hasNext();) {
	            ((Node) it.next()).sortChildren();
	        }
	    }
}
