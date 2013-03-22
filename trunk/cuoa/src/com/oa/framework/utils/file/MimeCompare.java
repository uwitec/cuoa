package com.oa.framework.utils.file;

import java.util.HashMap;
import java.util.Map;

public class MimeCompare {
	public static String getMimeType(String extension_name) {
		Map<String, String> map = getMimeMap();
		return map.get(extension_name);
	}
	public static Map<String, String> getMimeMap() {
		Map<String, String> map = new HashMap<String, String>();
		map.put("doc", "application/msword");
		map.put("xls", "application/vnd.ms-excel");
		map.put("docx", "application/msword");
		map.put("xlsx", "application/vnd.ms-excel");
		map.put("txt", "text/plain");
		map.put("ppt", "application/vnd.ms-powerpoint");
		map.put("pptx", "application/vnd.ms-powerpoint");
		map.put("zip", "application/zip");
		map.put("rar", "application/x-rar-compressed");
		map.put("7z", "application/x-7z-compressed");
		map.put("pdf", "application/pdf");
		return map;
	}
}
