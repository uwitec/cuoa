package com.oa.framework.utils.file.newppt;

import sun.net.ftp.FtpClient;

/**
 * <p>作者 David</p>
 * <p>功能描述:解决FtpClient无法设置编码的问题</p>
 * <p>创建时间:下午05:02:05</p>
 */
public class XesFtpClient extends FtpClient {
	public static void setEncoding(String encoding){
		sun.net.NetworkClient.encoding=encoding;
	}
}

