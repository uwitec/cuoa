/**
 * 
 */
package com.oa.framework.utils.treemenu;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.oa.employee.permissions.domain.Resource;

/**
 * Description:
 * TreeMenu.java Create on 2013-3-22 下午05:17:15 
 * @author YJN
 * @Description: TODO 
 */
public class TreeMenu {
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static String getTreeMenuJson(List<Resource> dataList) {
		// 节点列表（散列表，用于临时存储节点对象）
		HashMap nodeList = new HashMap();
		// 根节点
		Node root = null;
		// 根据结果集构造节点列表（存入散列表）
		for (Resource resource : dataList) {
			Node node = new Node();
			node.id = resource.getId();
			node.text = resource.getName();
			node.parentId = resource.getParentId();
			node.url = resource.getUrl();
			nodeList.put(node.id, node);
		}
		// 构造无序的多叉树
        Set entrySet = nodeList.entrySet();
        for (Iterator it = entrySet.iterator(); it.hasNext();) {
            Node node = (Node) ((Map.Entry) it.next()).getValue();
            if (node.parentId == null || node.parentId.equals("") || node.parentId.equals("-1")) { //如果父节点为-1,则此节点为顶级节点
                root = node;
            } else {
                ((Node) nodeList.get(node.parentId)).addChild(node);
            }
        }
        // 对多叉树进行横向排序
        root.sortChildren();

		return "[" + root.toString() + "]";
	}
}
