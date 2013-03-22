package com.oa.global.strutsTypeConverter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.util.StrutsTypeConverter;

public class hsChangeDate extends StrutsTypeConverter {

	@Override
	public Object convertFromString(Map context, String[] values, Class toClass) {
		if (Date.class.isAssignableFrom(toClass)
				|| java.util.Date.class == toClass) {
			if (values[0] == null || values[0].trim().equals(""))return null;
			List<SimpleDateFormat> sdfList = new ArrayList<SimpleDateFormat>();
			sdfList.add(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
			sdfList.add(new SimpleDateFormat("yyyy-MM-dd"));
			sdfList.add(new SimpleDateFormat("yy-MM-dd"));
			sdfList.add(new SimpleDateFormat("HH:mm:ss"));
			sdfList.add(new SimpleDateFormat("HH:mm"));
			Date date=null;
			for (SimpleDateFormat sdf : sdfList) {
				try {
					date=sdf.parse(values[0]);
					break;
				} catch (Exception e) {
					continue;
				}
			}
			return date;
		} else {
			return null;
		}
	}

	@Override
	public String convertToString(Map context, Object o) {
		if (Date.class.isAssignableFrom(o.getClass())) {
			List<SimpleDateFormat> sdfList = new ArrayList<SimpleDateFormat>();
			sdfList.add(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
			sdfList.add(new SimpleDateFormat("yyyy-MM-dd"));
			sdfList.add(new SimpleDateFormat("yy-MM-dd"));
			sdfList.add(new SimpleDateFormat("HH:mm:ss"));
			sdfList.add(new SimpleDateFormat("HH:mm"));
			String dateStr=null;
			for (SimpleDateFormat sdf : sdfList) {
				try {
					dateStr=sdf.format((Date) o);
					break;
				} catch (RuntimeException e) {
					continue;
				}
			}
			return dateStr;
		} else {
			return null;
		}
	}


}
