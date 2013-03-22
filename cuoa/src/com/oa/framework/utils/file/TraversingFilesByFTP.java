package com.oa.framework.utils.file;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import sun.net.TelnetInputStream;
import sun.net.ftp.FtpClient;

public class TraversingFilesByFTP {
	private FtpClient _client;
	
//	private final static String _SERVER = "jysc.eduu.com";
//	public final static String DOWNLOAD_ROOT_PATH = "http://jyxz.eduu.com:89/";
//	private final static String _USER = "ftpuser";
//	private final static String _PASSWORD = "Jucee9du";
//	private final static String _ROOTPATH = "lecture";
//	
//	private final static String _ENCODING = "GB18030"; //服务器端编码格式
	
	/** 
     * 连接FTP服务器 
     * @param server FTP服务器IP地址 
     * @param user 登录名 
     * @param password 密码 
     * @throws IOException 
     */  
    public void connectionServer(String server, String user, String password) throws IOException {
    	_client = new FtpClient();
    	_client.openServer(server);
    	_client.login(user, password);
    	_client.binary();
    }

    /**
     * 连接FTP服务器,并指定登录路径 
     * @param server FTP服务器IP地址 
     * @param user 登录名 
     * @param password 密码 
     * @param path 登录路径 
     * @throws IOException 
     */  
    public void connectionServer(String server, String user, String password, String path) throws IOException {
    	_client = new FtpClient();
    	_client.openServer(server);
    	_client.login(user, password);
    	_client.cd(path);
    	_client.binary();
    }
    
    /**
     * 转到指定目录 
     * @param path
     * @throws IOException
     */
    public void cdPath(String path) throws IOException {
    	_client.cd(path);
    }
    
    /**
     * 关闭FTP服务
     * @throws IOException
     */
    public void closeFTPClient() throws IOException {
        if (_client != null) {
        	_client.closeServer();
        }
    }

    /**
     * 获得文件和目录列表 
     * @return
     * @throws IOException
     */
    @SuppressWarnings("unchecked")
	public List getFileList(String areaCode) throws IOException {
    	//((Object) _client).setControlEncoding("GBK");
        List list = new ArrayList();
        TelnetInputStream in = _client.nameList(".");
        //BufferedReader bf = new BufferedReader(new InputStreamReader(in));
        String lecture_encoding =  FileUtils.getFileParam("lecture_encoding_" + areaCode).toString();
        BufferedReader bf = new BufferedReader(new InputStreamReader(in, lecture_encoding));
        String l = null;
        while ((l = bf.readLine()) != null) {
            if (!l.equals(".") && !l.equals("..")) {
                list.add(l);
            }
        }
        return list;
    }
    
    /** 
     * @param args 
     * @throws IOException 
     */  
	public static void main(String[] args) throws IOException {
    	TraversingFilesByFTP ftp = new TraversingFilesByFTP();
    	//ftp.getFileNameAndPathList();
    }

	/**
	 * 
	 * @return
	 * @throws IOException
	 */
    @SuppressWarnings("unchecked")
	public static List<Map<String, String>> getFileNameAndPathList(Date date_start_date, Date date_end_date, String areaCode) throws IOException {
    	List<Map<String, String>> fileNameAndPathList = new ArrayList<Map<String, String>> ();
    	Map<String, String> fileNameAndPathMap = new HashMap<String, String> ();
    	TraversingFilesByFTP ftp = new TraversingFilesByFTP();
    	
    	String lecture_ftproot =  FileUtils.getFileParam("lecture_ftproot_" + areaCode).toString();
    	String lecture_username = FileUtils.getFileParam("lecture_username_" + areaCode).toString();
    	String lecture_password = FileUtils.getFileParam("lecture_password_" + areaCode).toString();
    	String lecture_rootpath = FileUtils.getFileParam("lecture_rootpath_" + areaCode).toString();
    	
    	ftp.connectionServer(lecture_ftproot, lecture_username, lecture_password, lecture_rootpath);
    	System.out.println(lecture_ftproot);
    	System.out.println(lecture_username);
    	System.out.println(lecture_password);
    	System.out.println(lecture_rootpath);
    	List<String> folders = ftp.getFileList(areaCode);
    	
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
		
    	for (String folder: folders) {
    		if (int_start_date != 0) {
				if (Integer.valueOf(folder) < int_start_date) {
					continue;
				}
			}
			if (int_end_date != 0) {
				if (Integer.valueOf(folder) > int_end_date) {
					continue;
				}
			}
    		ftp.cdPath(folder);
    		List<String> files = ftp.getFileList(areaCode);
    		for (String file: files) {
    			fileNameAndPathMap = new HashMap<String, String> ();
    			fileNameAndPathMap.put("fileName", file);
    			fileNameAndPathMap.put("filePath", lecture_rootpath + "/" + folder + "/" + file);
    			fileNameAndPathList.add(fileNameAndPathMap);
    		}
    		ftp.cdPath("..");
    	}
    	return fileNameAndPathList;
    }
}