/**
 * 
 */
package com.oa.framework.utils.treemenu;

import org.apache.commons.lang.xwork.StringUtils;

/**
 * Description:
 * Node.java Create on 2013-3-22 下午05:19:32 
 * @author YJN
 * @Description: TODO 
 */
public class Node {
	public String id;
	public String text;
	public Boolean isexpand;
	public String url;
	public String parentId;

	public Children children = new Children();
	
	// 先序遍历，拼接JSON字符串
	
	    public String toString() {     
	        String result = "{"
	            + "text : '" + text + "'"
	            + ", isexpand : " + isexpand;
	        if (children != null && children.getSize() != 0) {
	            result += ", children : " + children.toString();
	        } else {
	            if (StringUtils.isNotBlank(url)) {
	            	result += ", url :'" + url + "'";
	            }
	            
	        }
	        return result + "}";
	    }
	    // 兄弟节点横向排序
	    public void sortChildren() {
	        if (children != null && children.getSize() != 0) {
	            children.sortChildren();
	        }
	    }
	    // 添加孩子节点
	    public void addChild(Node node) {
	        this.children.addChild(node);
	    }

}
