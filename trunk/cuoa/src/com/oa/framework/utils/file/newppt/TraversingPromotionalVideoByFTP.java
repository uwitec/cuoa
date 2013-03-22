package com.oa.framework.utils.file.newppt;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.oa.framework.utils.file.FileUtils;
import com.oa.framework.utils.string.MD5;

public class TraversingPromotionalVideoByFTP {
	public static FtpClientUtil connection(String areaCode) throws IOException {
		FtpClientUtil ftpClientUtil = new FtpClientUtil();
		System.out.println(FileUtils.getFileParam("pv_ftp_server_" + areaCode).toString());
    	System.out.println(FileUtils.getFileParam("pv_ftp_user_" + areaCode).toString());
    	System.out.println(FileUtils.getFileParam("pv_ftp_pwd_" + areaCode).toString());
    	System.out.println(FileUtils.getFileParam("pv_ftp_rootpath_" + areaCode).toString());
    	ftpClientUtil.connectionServer(FileUtils.getFileParam("pv_ftp_server_" + areaCode).toString(), FileUtils.getFileParam("pv_ftp_user_" + areaCode).toString(), 
    			FileUtils.getFileParam("pv_ftp_pwd_" + areaCode).toString(), FileUtils.getFileParam("pv_ftp_rootpath_" + areaCode).toString());
    	return ftpClientUtil;
	}
	
	/**
	 * 
	 * @return
	 * @throws IOException
	 */
    @SuppressWarnings("unchecked")
	public static List<Map<String, String>> getFileNameAndPathList(String areaCode) throws IOException {
    	FtpClientUtil ftpClientUtil = connection(areaCode);
		List<String> in_files = ftpClientUtil.getFileList("pv_ftp_encoding_" + areaCode);
		
		//遍历原文件夹
		List<Map<String, String>> sourceFileNameAndPathList = new ArrayList<Map<String, String>>();
		Map<String, String> sourceFileNameAndPathMap = new HashMap<String, String> ();
		for (String in_file: in_files) {
			sourceFileNameAndPathMap = new HashMap<String, String> ();
			sourceFileNameAndPathMap.put("primitiveName", in_file); //CN name
			sourceFileNameAndPathMap.put("fileName", MD5.getMD5(in_file.split("\\.")[0]) + "." + in_file.split("\\.")[1]); //MD5 name
			sourceFileNameAndPathMap.put("filePath", 
					FileUtils.getFileParam("pv_ftp_rootpath_" + areaCode).toString() + "/" + sourceFileNameAndPathMap.get("fileName")); //MD5 path
			sourceFileNameAndPathList.add(sourceFileNameAndPathMap);
		}
		
		//遍历目标文件夹
		ftpClientUtil.cdPath(FileUtils.getFileParam("pv_ftp_newfolder_" + areaCode).toString());
		in_files = ftpClientUtil.getFileList("pv_ftp_encoding_" + areaCode);
		List<Map<String, String>> targetFileNameAndPathList = new ArrayList<Map<String, String>>();
		Map<String, String> targetFileNameAndPathMap = new HashMap<String, String> ();
		for (String in_file: in_files) {
			targetFileNameAndPathMap = new HashMap<String, String> ();
			targetFileNameAndPathMap.put("fileName", in_file);
			targetFileNameAndPathMap.put("filePath", FileUtils.getFileParam("pv_ftp_newfolder_" + areaCode).toString() + "/" + in_file);
			targetFileNameAndPathList.add(targetFileNameAndPathMap);
		}
		//System.out.println(targetFileNameAndPathList);
		
		//循环查找重名文件，修改原文件的文件名，把新文件复制到目标文件夹，重名文件不涉及更新数据库
		List<Map<String, String>> finalList = new ArrayList<Map<String, String>>();
		for (Map sourceMap: sourceFileNameAndPathList) {
			
			Date date = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String time = sdf.format(date); 
			boolean isRepeat = false;
			
			for (Map targetMap: targetFileNameAndPathList) {
				if (sourceMap.get("fileName").toString().equals(targetMap.get("fileName").toString())) {
					//修改原文件的文件名
					ftpClientUtil.renameFile(targetMap.get("fileName").toString(), targetMap.get("fileName").toString() + time);
					isRepeat = true;
				}
			}
			//新文件移动到目标文件夹
			String primitivePath = "../" + FileUtils.getFileParam("pv_ftp_rootpath_" + areaCode).toString() + "/" + sourceMap.get("primitiveName").toString();
			ftpClientUtil.moveFile(new String(primitivePath.getBytes()), sourceMap.get("fileName").toString());
			//如果不是重复文件，添加到待新增数据List里
			if (!isRepeat) {
				sourceMap.put("isRepeat", "0");
				finalList.add(sourceMap);
			} else {
				sourceMap.put("isRepeat", "1");
				sourceMap.put("newFileName", sourceMap.get("fileName") + time);
				sourceMap.put("newFilePath", sourceMap.get("filePath") + time);
				finalList.add(sourceMap);
			}
		}
		
		//返回筛选后的文件名和路径
    	return finalList;
    }
    
}
