package com.oa.framework.utils.string;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.security.MessageDigest;

public class MD5 {
	public final static String getMD5(String s){
		
		char hexDigits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd','e', 'f'};
		try {
			byte[] strTemp = s.getBytes();
			
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");
			mdTemp.update(strTemp);
			byte[] md = mdTemp.digest();
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>>4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(str);
		}
		catch (Exception e){
			return null;
		}
	}

	public static String getMD5String(String str) 
    { 
        try 
        { 
            byte[] res=str.getBytes(); 
            MessageDigest md = MessageDigest.getInstance("MD5".toUpperCase()); 
//下面这句是非常重要的，不知道JAVA的这个MD5算法为什么要加上这句，如果去掉这一句 
//加密出来的结果和上面GetMd5Str32  方法，也就是.NET提供的MD5加密的结果是一样的 
//加上这句话后加密出来的结果就不一样了，其实这句话的效果和下面加粗字体的语句效果 
//一样，从JAVA API文档中发现          使用指定的 byte 数组对摘要进行最后更新，然后完成摘要计算。也就是说，此方法首先调用 update(input)，向 update 方法传递 input 数组，然后调用 digest()。 
            System.out.println(res.length);
            for(int i=0;i<res.length;i++) 
            { 
                md.update(res[i]); 
            } 
            byte[] hash=md.digest(); 

            StringBuffer d=new StringBuffer(""); 
            for(int i=0;i<hash.length;i++) 
            { 
                int v=hash[i] & 0xFF; 
                 if(v<16) d.append("0"); 
                   d.append(Integer.toString(v,16).toUpperCase()+""); 
            } 
                return d.toString(); 
        } 
        catch(Exception e) 
        { 
            return ""; 
        } 
    }
	public static void main(String[] args) {
		System.out.println(getMD5String("123456").toLowerCase());
		try {
//			System.out.println(getMD5String(new String("中文".getBytes(),"utf-8")));//59ADB24EF3CDBE0297F05B395827453F
//			System.out.println(getMD5(new String("中文".getBytes(),"utf-8")));
//			System.out.println(getMD5String(new String("中文".getBytes(),"gbk")));
//			System.out.println(getMD5(new String("中文".getBytes(),"gbk")));
			//System.out.println(getMD5(new String("111111".getBytes(),"gbk")));
			
//			System.out.println(URLDecoder.decode("%E9%98%BF%E6%96%AF%E8%92%82%E8%8A%AC","utf-8"));
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}//a7bac2239fcdcb3a067903d8077c4a07
	}

}