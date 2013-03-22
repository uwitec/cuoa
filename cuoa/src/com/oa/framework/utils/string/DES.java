package com.oa.framework.utils.string;

import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import org.apache.commons.lang.StringUtils;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class DES {
	
	private byte[] desKey;

	public DES(){
		
	}
	public DES(String desKey) {
		this.desKey = desKey.getBytes();
	}

	public byte[] desEncrypt(byte[] plainText) {
		SecureRandom sr = new SecureRandom();
		byte[] encryptedData;
		Cipher cipher;
		try {
			DESKeySpec dks = new DESKeySpec(desKey);
			SecretKey key = SecretKeyFactory.getInstance("DES").generateSecret(dks);
			cipher = Cipher.getInstance("DES");
			cipher.init(Cipher.ENCRYPT_MODE, key, sr);
			encryptedData = cipher.doFinal(plainText);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
		return encryptedData;
	}

	public byte[] desDecrypt(byte[] encryptText) {
		SecureRandom sr = new SecureRandom();
		byte[] decryptedData;
		try{
			DESKeySpec dks = new DESKeySpec(desKey);
			SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
			SecretKey key = keyFactory.generateSecret(dks);
			Cipher cipher = Cipher.getInstance("DES");
			cipher.init(Cipher.DECRYPT_MODE, key, sr);
			decryptedData= cipher.doFinal(encryptText);
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
		return decryptedData;
	}

	public String encrypt(String input)  {
		if(StringUtils.isBlank(input)){
			return "";
		}
		return base64Encode(desEncrypt(input.getBytes()));
	}

	public String decrypt(String input) {
		if(StringUtils.isBlank(input)){
			return "";
		}
		byte[] result = base64Decode(input);
		return new String(desDecrypt(result));
	}

	public static String base64Encode(byte[] s) {
		if (s == null)
			return null;
		BASE64Encoder b = new sun.misc.BASE64Encoder();
		return b.encode(s);
	}

	public static byte[] base64Decode(String s) {
		if (s == null){
			return null;
		}
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] b;
		try{
			b = decoder.decodeBuffer(s);
		}catch(Exception e){
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
		return b;
	}

	public void setDesKey(String keyStr) {
		this.desKey = keyStr.getBytes();
	}
	
	public static void main(String[] args) throws Exception {
		String key = "测试测12";
		String input = "4800000";
		DES crypt = new DES();
		crypt.setDesKey(key);
		System.out.println("Encode:" + crypt.encrypt(input));
		System.out.println("Decode:" + crypt.decrypt(crypt.encrypt(input)));
		key="测试测12";
		crypt.setDesKey(key);
		System.out.println("Encode:" + crypt.encrypt(input));
		System.out.println("Decode:" + crypt.decrypt(crypt.encrypt(input)));
	}
}
