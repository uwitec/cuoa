package com.oa.framework.utils;

import java.util.ArrayList;
import java.util.List;

public class TypeConvert {
	public static List<List<Object>> trans_objarrlist_to_objlistlist(List<Object[]> list) {
		List<List<Object>> returnList = new ArrayList<List<Object>>();
		for (Object[] obj_arr: list) {
			List<Object> list_in = new ArrayList<Object>();
			for (Object obj: obj_arr) {
				if (obj != null) {
					list_in.add(obj);
				} else {
					list_in.add(0);
				}
			}
			returnList.add(list_in);
		}
		return returnList;
	}
}
