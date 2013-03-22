package com.oa.framework.utils.file.newppt;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import com.oa.framework.utils.file.FileUtils;

import sun.net.TelnetInputStream;

public class FtpClientUtil {
	
	private XesFtpClient _client;
	
	/** 
     * 连接FTP服务器 
     * @param server FTP服务器IP地址 
     * @param user 登录名 
     * @param password 密码 
     * @throws IOException 
     */  
    public void connectionServer(String server, String user, String password) throws IOException {
    	_client = new XesFtpClient();
    	_client.openServer(server);
    	_client.login(user, password);
    	_client.binary();
    	_client.setEncoding(FileUtils.getPropertyValue("/config/path.properties", "ftp_client_encoding"));
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
    	_client = new XesFtpClient();
    	_client.openServer(server);
    	_client.login(user, password);
    	_client.cd(path);
    	_client.binary();
    	_client.setEncoding(FileUtils.getPropertyValue("/config/path.properties", "ftp_client_encoding"));
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
	public List getFileList(String encoding) throws IOException {
        List list = new ArrayList();
        TelnetInputStream in = _client.nameList(".");
        BufferedReader bf = new BufferedReader(new InputStreamReader(in, FileUtils.getFileParam(encoding).toString()));
        String l = null;
        while ((l = bf.readLine()) != null) {
            if (!l.equals(".") && !l.equals("..")) {
                list.add(l);
            }
        }
        return list;
    }
    
    /**
     * 重命名文件
     * @param string1
     * @param string2
     * @return Boolean
     */
    public Boolean renameFile(String string1, String string2) {
    	try {
    		_client.rename(string1, string2);
    	} catch (IOException ex) {
    		throw new RuntimeException("重命令错误！");
    	}
    	return Boolean.TRUE;
    }
    
    /**
     * 移动文件
     * @param filename 文件名
     * @param newfilepath 与当前目录平级的另一目录
     * @return
     * @throws UnsupportedEncodingException 
     */
    public Boolean moveFile(String ora_dir, String tar_dir) throws UnsupportedEncodingException {
    	try {
    		System.out.println("移动文件。。。");
    		System.out.println("原路径：" + ora_dir);
    		System.out.println("现路径：" + tar_dir);
    		_client.rename(ora_dir, tar_dir);
    	} catch (IOException ex) {
    		ex.printStackTrace();
    		throw new RuntimeException("Error in moving file！");
    	}
    	System.out.println("文件移动成功！");
    	return Boolean.TRUE;
    }
    
    /**
     * 删除文件
     * @param url
     * @return
     */
    public Boolean deleteFile(String url) {
    	try {
    		_client.sendServer("DELE "+url+"\r\n");
    		 int status = _client.readServerResponse();
    	     System.out.print("ftp delete file status: "+status);
    	     if(status == 250){
    	      System.out.println("成功删除FTP服务器中文件");
    	     }
    	} catch (IOException ex) {
    		throw new RuntimeException("删除文件操作异常！");
    	}
    	return Boolean.TRUE;
    }
    
    
}
