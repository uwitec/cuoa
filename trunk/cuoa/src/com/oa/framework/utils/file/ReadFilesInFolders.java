package com.oa.framework.utils.file;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.oa.framework.utils.Date.DateUtil;

public class ReadFilesInFolders {
	public static List<Map<String, String>> read(Date date_start_date, Date date_end_date, String rootPath) {
//		date_start_date = new Date();
//		date_end_date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat();
		sdf.applyPattern("yyyyMMdd");
		int int_start_date = 0;
		int int_end_date = 0;
		//格式化开始、结束日期
		if (date_start_date != null) {
			 int_start_date = Integer.valueOf(sdf.format(date_start_date.getTime()));
		}
		if (date_end_date != null) {
			 int_end_date = Integer.valueOf(sdf.format(date_end_date.getTime()));
		}
		//根路径
		File root_dir = new File(rootPath + "lecture/");
		//以日期命名的文件夹
		File[] folders = root_dir.listFiles();
		List<Map<String, String>> file_info_list = new ArrayList<Map<String, String>>();
		for (File one_folder: folders) {
			try {
				if (one_folder.isDirectory() && !one_folder.getName().equals(".svn")) { //如果是文件夹，且满足日期条件，打开并读取其中的文件
					if (int_start_date != 0) {
						if (Integer.valueOf(one_folder.getName()) < int_start_date) {
							continue;
						}
					}
					if (int_end_date != 0) {
						if (Integer.valueOf(one_folder.getName()) > int_end_date) {
							continue;
						}
					}
					System.out.println("* * * * * * * * folder:" + one_folder.getName());
					File[] files = one_folder.listFiles();
					for (File one_file: files) {
						try {
							if (one_file.isFile()) {
								System.out.println("* * * * * * * * file:" + one_file.getName());
								Map<String, String> temp_map = new HashMap<String, String>();
								//过滤掉.svn
								if (one_file.getName().equals(".svn")) {
									continue;
								}
								temp_map.put("fileName", one_file.getName());
								temp_map.put("filePath", one_file.getAbsolutePath());
								//temp_map.put("uploadType", one_file.get)
								file_info_list.add(temp_map);
							}
						} catch (Exception ex) {
							ex.printStackTrace();
							continue;
						}
					}
				}
			} catch (Exception ex) {
				ex.printStackTrace();
				continue;
			}
		}
		return file_info_list;
	}
}
