package com.oa.framework.utils.ref;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import com.oa.framework.utils.string.StringUtil;

public class RefUtil {

	public static Object returnMethod(Object o,String methodName) throws SecurityException, NoSuchMethodException, IllegalArgumentException, IllegalAccessException, InvocationTargetException{
		Class<? extends Object> clazz = o.getClass();
			Method m = clazz.getDeclaredMethod("get"+StringUtil.toUpperCaseFirstLetter(methodName));
			return m.invoke(o);
		
	}
}