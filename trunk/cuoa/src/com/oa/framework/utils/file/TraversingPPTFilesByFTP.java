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

public class TraversingPPTFilesByFTP {
	private FtpClient _client;
	
	
//	private final static String _SERVER = "192.168.7.39";
//	private final static String _USER = "test";
//	private final static String _PASSWORD = "test";
//	private final static String _ENCODING = "UTF-8"; //服务器端编码格式
	
	
	
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
        
        BufferedReader bf = new BufferedReader(new InputStreamReader(in, FileUtils.getFileParam("ppt_ftp_encoding", areaCode).toString()));
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
    	TraversingPPTFilesByFTP ftp = new TraversingPPTFilesByFTP();
    	//ftp.getFileNameAndPathList();
    }

	/**
	 * 
	 * @return
	 * @throws IOException
	 */
    @SuppressWarnings("unchecked")
	public static List<Map<String, String>> getFileNameAndPathList(Date date_start_date, Date date_end_date, String areaCode) throws IOException {
    	System.out.println(FileUtils.getFileParam("ppt_ftp_server", areaCode).toString());
    	System.out.println(FileUtils.getFileParam("ppt_ftp_user", areaCode).toString());
    	System.out.println(FileUtils.getFileParam("ppt_ftp_pwd_" + areaCode).toString());
    	System.out.println(FileUtils.getFileParam("ppt_ftp_rootpath", areaCode).toString());
    	List<Map<String, String>> fileNameAndPathList = new ArrayList<Map<String, String>> ();
    	Map<String, String> fileNameAndPathMap = new HashMap<String, String> ();
    	TraversingPPTFilesByFTP ftp = new TraversingPPTFilesByFTP();
    	ftp.connectionServer(FileUtils.getFileParam("ppt_ftp_server", areaCode).toString(), FileUtils.getFileParam("ppt_ftp_user", areaCode).toString(), 
    			FileUtils.getFileParam("ppt_ftp_pwd_" + areaCode).toString(), FileUtils.getFileParam("ppt_ftp_rootpath", areaCode).toString());
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
    		try {
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
	    		List<String> in_folders = ftp.getFileList(areaCode);
	    		for (String in_folder: in_folders) {
	    			fileNameAndPathMap = new HashMap<String, String> ();
	    			fileNameAndPathMap.put("fileName", in_folder);
	    			fileNameAndPathMap.put("filePath", FileUtils.getFileParam("ppt_ftp_rootpath", areaCode).toString() + "/" + folder + "/" + in_folder);
	    			fileNameAndPathList.add(fileNameAndPathMap);
	    		}
	    		ftp.cdPath("..");
    		} catch (NumberFormatException nxe) {
    			//跳过上传日期目录名不为数字的目录
    			continue;
    		}
     	}
    	return fileNameAndPathList;
    }
}