/**
 * 
 */
package com.oa.framework.utils.file;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.MalformedURLException;
import java.net.URL;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.StringTokenizer;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;


/**
 * @author Administrator 文件管理操作实用类
 */
public class FileUtils {
	
	private static int cnt=0;
	/**
	 * 生成文件名称
	 * @return
	 */
	public static synchronized String createFileName()
	{   
		
		java.util.Date dt=new java.util.Date(System.currentTimeMillis());   
		SimpleDateFormat fmt=new SimpleDateFormat("yyyyMMddHHmmssSSS");   
		String fileName=fmt.format(dt); 
		cnt =(cnt+1)%100;  
        StringBuffer sBuf=new StringBuffer("0000").append(cnt);   
        sBuf.delete(0,sBuf.length()-2);  
        fileName=fileName+"_"+sBuf.toString();   
        return fileName;   

    }
	public static Object getParamFromFile(String filePath,String key){
		InputStream in;
		try {
			in=FileUtils.class.getResourceAsStream(filePath);
			Properties properties = new Properties();
			properties.load(in);
			return properties.get(key);
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException("获得文件参数错误:"+e.getMessage());
		}catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException("获得文件参数错误:"+e.getMessage());
		}
}
	/**
	 * 新建目录
	 * 
	 * @param filePath
	 */
	public static void createPath(String filePath) {
		/**
		filePath = filePath.toString();// 中文转换
		StringTokenizer token=new StringTokenizer(filePath,"/");   
	    String path1=token.nextToken()+"/";   
	    String path2 =path1;
	    while(token.hasMoreTokens())   
	    {   
           path1=token.nextToken()+"/";  
           path2+=path1; 
           File inbox=new File(path2);   
           if(!inbox.exists()){
        	   inbox.mkdir(); 
           }
	    }
	    */
		File dir=new File(filePath);
		if(!dir.exists()){
			dir.mkdirs();
		}
	}

	/**
	 * 新建文件
	 * 
	 * @param filePath
	 */
	public static void createFile(String filePath) throws FileUtilException {
		try {
			filePath = filePath.toString();
			java.io.File myFilePath = new java.io.File(filePath);
			if (!myFilePath.exists()) myFilePath.createNewFile();
		} catch (IOException e) {
			e.printStackTrace();
			throw new FileUtilException("创建文件错误!");
		}
	}

	/**
	 * 删除文件
	 * 
	 * @param filePath
	 */
	public static void deleteFile(String filePath) throws FileUtilException {
		try {
			filePath = filePath.toString();
			java.io.File myDelFile = new java.io.File(filePath);
			if(myDelFile.isDirectory()){
				deleteFile(myDelFile);
			}else{
				myDelFile.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new FileUtilException("删除文件错误!");
		}
	}

	
	/**
	 * 删除文件夹下所有内容，包括此文件夹 
	 * @author wangxida
	 *
	 */
	public static void deleteFile(File f) throws IOException
	{ 
	    if(!f.exists())//文件夹不存在
	    {
	        throw new IOException("指定目录不存在:"+f.getName()); 
	    }
	    boolean rslt=true;//保存中间结果 
	    
	   File subs[] = f.listFiles(); //若文件夹非空。枚举、递归删除里面内容 
	   for(int i = 0; i <= subs.length - 1; i++)
	   { 
	      if (subs[i].isDirectory())
	      {
	    	  deleteFile(subs[i]);//递归删除子文件夹内容 
	      }
	      rslt = subs[i].delete();//删除子文件夹本身 
	   } 
	      
		if(!rslt) 
		{
		    throw new IOException("无法删除:"+f.getName()); 
		}
		  
		return; 
	} 
	
	/**
	 * 文件拷贝
	 * 
	 * @param sourceFilePath
	 * @param distFilePath
	 */
	public static void copyFile(String sourceFilePath, String distFilePath)	throws FileUtilException {
		try {
			int bytesum = 0;
			int byteread = 0;
			InputStream inStream = new FileInputStream(sourceFilePath);
			FileOutputStream fs = new FileOutputStream(distFilePath);
			byte[] buffer = new byte[1444];
			while ((byteread = inStream.read(buffer)) != -1) {
				bytesum += byteread;
				fs.write(buffer, 0, byteread);
			}
			inStream.close();
			fs.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new FileUtilException("文件拷贝错误!");
		}
	}
	/**
	 * 文件拷贝
	 * 
	 * @param sourceFilePath
	 * @param distFilePath
	 */
	public static void copyFile(File file, String distFilePath,String fileName)	throws FileUtilException {
		try {
			File f = new File(distFilePath);
			if(!f.exists()){
				f.mkdirs();
			}
			int bytesum = 0;
			int byteread = 0;
			InputStream inStream = new FileInputStream(file);
			FileOutputStream fs = new FileOutputStream(distFilePath+fileName);
			byte[] buffer = new byte[1444];
			while ((byteread = inStream.read(buffer)) != -1) {
				bytesum += byteread;
				fs.write(buffer, 0, byteread);
			}
			inStream.close();
			fs.close();
		} catch (Exception e) {
			e.printStackTrace();
			throw new FileUtilException("文件拷贝错误!");
		}
	}

	/**
	 * 文件夹拷贝
	 * 
	 * @param sourceFilePath
	 * @param distFilePath
	 */
	public static void copyFilePath(String sourceFilePath, String distFilePath)	throws FileUtilException {
		try {
			(new File(distFilePath)).mkdirs();
			File[] file = (new File(sourceFilePath)).listFiles();
			for (int i = 0; i < file.length; i++) {
				if (file[i].isFile()) {
					file[i].toString();
					FileInputStream input = new FileInputStream(file[i]);
					FileOutputStream output = new FileOutputStream(distFilePath
							+ "/" + (file[i].getName()).toString());
					byte[] b = new byte[1024 * 5];
					int len;
					while ((len = input.read(b)) != -1) {
						output.write(b, 0, len);
					}
					output.flush();
					output.close();
					input.close();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new FileUtilException("文件夹拷贝错误!");
		}
	}

	/**
	 * 读到流中
	 * 
	 * @param filePath
	 * @return
	 * @throws FileUtilException
	 */
	public static InputStream fileToStream(String filePath) throws FileUtilException {
		try {
			File file = new File(filePath);
			if (file.exists())
				return new FileInputStream(file);
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			throw new FileUtilException("文件转化输出流错误!");
		}

	}

	/**
	 * 读文件到字节数组中
	 * 
	 * @param file
	 * @throws Exception
	 */
	public static byte[] fileToByte(File file) throws FileUtilException {
		try {
			byte[] dist = null;
			if (file.exists()) {
				FileInputStream is = new FileInputStream(file);
				dist = new byte[is.available()];
				is.read(dist);
			}
			return dist;
		} catch (Exception e) {
			e.printStackTrace();
			throw new FileUtilException("文件转化字节数组错误!");
		}

	}
	/**
	 * 读文件到字节数组中
	 * 
	 * @param filePath
	 * @throws Exception
	 */
	public static byte[] fileToByte(String filePath) throws FileUtilException {
		try {
			File file = new File(filePath);
			byte[] dist = null;
			if (file.exists()) {
				FileInputStream is = new FileInputStream(file);
				dist = new byte[is.available()];
				is.read(dist);
			}
			return dist;
		} catch (Exception e) {
			e.printStackTrace();
			throw new FileUtilException("文件转化字节数组错误!");
		}

	}

	/**
	 * 文件的写入
	 * 
	 * @param filePath(文件路径)
	 * @param fileName(文件名)
	 * @param args[]
	 * @throws IOException
	 */
	public static void writeFile(String filePath, String fileName, String[] args) throws IOException {
		FileWriter fw = new FileWriter(filePath + fileName);
		PrintWriter out = new PrintWriter(fw);
		for (int i = 0; i < args.length; i++) {
			out.write(args[i]);
			out.println();
			out.flush();
		}
		fw.close();
		out.close();
	}

	/**
	 * 文件的写入
	 * 
	 * @param filePath(文件路径)
	 * @param fileName(文件名)
	 * @param args
	 * @throws IOException
	 */
	public static void writeFile(String filePath, String fileName, String args) throws IOException {
		FileWriter fw = new FileWriter(filePath + fileName);
		fw.write(args);
		fw.close();
	}

	/**
	 * 文件的写入
	 * 
	 * @param filePath(文件路径+文件名)
	 * @param args
	 * @throws IOException
	 */
	public static void writeFile(String filePath, String args) throws IOException {
		FileWriter fw = new FileWriter(filePath);
		fw.write(args);
		fw.close();
	}

	/**
	 * 文件的写入
	 * 
	 * @param filePath(文件路径+文件名)
	 * @param args 要写入的内容
	 * @param isUTF8 是否以UTF-8的文件编码写入文件
	 * @throws IOException
	 */
	public static void writeFile(String filePath, String args,boolean isUTF8) throws IOException {
		if(isUTF8){
			OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(filePath),"UTF-8");
			out.write(args);
			out.flush();
			out.close();
		}else{
			FileWriter fw = new FileWriter(filePath);
			fw.write(args);
			fw.close();
		}
	}
	/**
	 * 文件的写入
	 * 
	 * @param filePath文件路径
	 * @param fileName 文件名
	 * @param args 要写入的内容
	 * @param isUTF8 是否以UTF-8的文件编码写入文件
	 * @throws IOException
	 */
	public static void writeFile(String filePath,String fileName, String args,boolean isUTF8) throws IOException {
		File f = new File(filePath);
		if(!f.exists()){
			f.mkdirs();
		}
		if(isUTF8){
			OutputStreamWriter out = new OutputStreamWriter(new FileOutputStream(filePath+fileName),"UTF-8");
			out.write(args);
			out.flush();
			out.close();
		}else{
			FileWriter fw = new FileWriter(filePath+fileName);
			fw.write(args);
			fw.close();
		}
	}

	/**
	 * 创建与删除文件
	 * 
	 * @param filePath
	 * @param fileName
	 * @return 创建成功返回true
	 * @throws IOException
	 */
	public static boolean createAndDeleteFile(String filePath, String fileName)	throws IOException {
		boolean result = false;
		File file = new File(filePath, fileName);
		if (file.exists()) {
			file.delete();
			result = true;
			System.out.println("文件已经删除！");
		} else {
			file.createNewFile();
			result = true;
			System.out.println("文件已经创建！");
		}
		return result;
	}

	/**
	 * 创建和删除目录
	 * 
	 * @param folderName
	 * @param filePath
	 * @return 删除成功返回true
	 */
	public static boolean createAndDeleteFolder(String folderName, String filePath) {
		boolean result = false;
		try {
			File file = new File(filePath + folderName);
			if (file.exists()) {
				file.delete();
				System.out.println("目录已经存在，已删除!");
				result = true;
			} else {
				file.mkdir();
				System.out.println("目录不存在，已经建立!");
				result = true;
			}
		} catch (Exception ex) {
			result = false;
			System.out.println("CreateAndDeleteFolder is error:" + ex);
		}
		return result;
	}

	/**
	 * 输出目录中的所有文件及目录名字
	 * 
	 * @param filePath
	 */
	public static void readFolderByFile(String filePath) {
		File file = new File(filePath);
		File[] tempFile = file.listFiles();
		for (int i = 0; i < tempFile.length; i++) {
			if (tempFile[i].isFile()) {
				System.out.println("File : " + tempFile[i].getName());
			}
			if (tempFile[i].isDirectory()) {
				System.out.println("Directory : " + tempFile[i].getName());
			}
		}
	}

	/**
	 * 检查文件中是否为一个空
	 * 
	 * @param filePath
	 * @param fileName
	 * @return 为空返回true
	 * @throws IOException
	 */
	public static boolean fileIsNull(String filePath, String fileName) throws IOException {
		boolean result = false;
		FileReader fr = new FileReader(filePath + fileName);
		if (fr.read() == -1) {
			result = true;
			System.out.println(fileName + " 文件中没有数据!");
		} else {
			System.out.println(fileName + " 文件中有数据!");
		}
		fr.close();
		return result;
	}

	/**
	 * 读取文件中的所有内容
	 * 
	 * @param filePath
	 * @param fileName
	 * @throws IOException
	 */
	public static void readAllFile(String filePath, String fileName) throws IOException {
		FileReader fr = new FileReader(filePath + fileName);
		int count = fr.read();
		while (count != -1) {
			count = fr.read();
			if (count == 13) {
				fr.skip(1);
			}
		}
		fr.close();
	}

	/**
	 * 一行一行的读取文件中的数据
	 * 
	 * @param filePath
	 * @param fileName
	 * @throws IOException
	 */
	public static void readLineFile(String filePath, String fileName) throws IOException {
		FileReader fr = new FileReader(filePath + fileName);
		BufferedReader br = new BufferedReader(fr);
		String line = br.readLine();
		while (line != null) {
			line = br.readLine();
		}
		br.close();
		fr.close();
	}

	/**
	 * 一行一行的读取文件中的数据,转换成字符串
	 * 
	 * @param filePath
	 * @throws IOException
	 */
	public static String readLineFile(String filePath)	throws IOException {
		StringBuffer sb = new StringBuffer();
		FileReader fr = new FileReader(filePath);
		BufferedReader br = new BufferedReader(fr);
		String line = br.readLine();
		while (line != null) {
			sb.append(line);
			line = br.readLine();
		}
		br.close();
		fr.close();
		return sb.toString();
	}

	/**********************************/


	/**
	 * 读取文件已byte流的形式返回,并删除临时文件;
	 * 
	 * @param path
	 *            :文件在服务器上的绝对路径;
	 * @return
	 * @throws Exception
	 */
	public static ByteArrayInputStream file2ByteArrayInputStream(String fileName)
	throws Exception {
		try {
			File file = new File(fileName);
			return file2ByteArrayInputStream(file);
		} catch (Exception e) {
			throw new Exception("将文件转换为流的过程中出现错误!");
		}
	}

	/**
	 * 读取文件已byte流的形式返回,并删除临时文件;
	 * 
	 * @param path
	 *            :文件在服务器上的绝对路径;
	 * @return
	 * @throws Exception
	 */
	public static ByteArrayInputStream file2ByteArrayInputStream(File file)
	throws Exception {
		try {
			FileInputStream is = new FileInputStream(file);
			byte[] b = new byte[is.available()];
			is.read(b);
			is.close();
			//			file.delete();
			return new ByteArrayInputStream(b);
		} catch (Exception e) {
			throw new Exception("将文件转换为流的过程中出现错误!");
		}
	}
	/**
	 * 从url读取文本
	 * @param strURL String url地址
	 * @return String
	 */
	public String readFromURL(String strURL) {
		try{
			URL url = new URL(strURL);
			BufferedReader in = new BufferedReader(new InputStreamReader(url.openStream()));
			String str;
			String rtnStr="";
			while((str=in.readLine())!=null){
				rtnStr = rtnStr+new String(str.getBytes(), "GB2312");
			}
			in.close();
			return rtnStr;
		}catch(MalformedURLException e){
			e.printStackTrace();
			return null;
		}catch(IOException e){
			e.printStackTrace();
			return null;
		}catch(Exception e){
			e.printStackTrace();
			return null;
		}		
	}
	/**
	 * 从输入流中读取内容
	 * @param is InputStream 输入流对象
	 * @throws Exception
	 * @return String
	 */
	public String readFromIS(InputStream is) throws Exception{
		try {			
			String strRtn = "";
			int length = is.available();
			byte[] buf = new byte[length];
			while ((is.read(buf, 0, length)) != -1) {
				strRtn = strRtn + new String(buf, 0, length, "GB2312");
			}			
			return strRtn;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}finally{
			is.close();
		}
	}

	/**
	 * 获取Property值，根据key
	 * @param filePath Property文件路径，classes根目录，例: /config/path.properties
	 * @param key 等号前的key值
	 * @return
	 */
	//static Properties p = null;
	public static String getPropertyValue(String filePath, String key,String... params){
		//if(p != null)
		//	return p.getProperty(key);
		Properties p = null;
		try {
			InputStream is = FileUtils.class.getResourceAsStream(filePath);
			if(is == null)
				return null;
			p = new Properties();
			p.load(is);
			is.close();
			return MessageFormat.format(p.getProperty(key), params);
		} catch (IOException e) {
			
			e.printStackTrace();
			return null;
		}
	}

	public static String getPropertyValue(String filePath, String key){
		//if(p != null)
		//	return p.getProperty(key);
		Properties p = null;
		try {
			InputStream is = FileUtils.class.getResourceAsStream(filePath);
			if(is == null)
				return null;
			p = new Properties();
			p.load(is);
			is.close();
			return p.getProperty(key).toString();
		} catch (IOException e) {
			
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 压缩文件
	 * @param zipFileName
	 * @param inputFile
	 * @throws Exception
	 */
	public static void zip(String zipFileName,String inputFile)throws Exception
	{
		zip(zipFileName,new File(inputFile));
	}
	
	/**
	 * 压缩文件
	 * @param zipFileName
	 * @param inputFile
	 * @throws Exception
	 */
	public static void zip(String zipFileName,File inputFile)throws Exception
	{
		ZipOutputStream out=new ZipOutputStream(new FileOutputStream(zipFileName));
		zip(out,inputFile,"");
		out.close();
	}

	
	/**
	 * 解压缩文件
	 * @param zipFileName
	 * @param outputDirectory
	 * @throws Exception
	 */
	public static void unzip(String zipFileName,String outputDirectory)throws Exception
	{
		ZipInputStream in=new ZipInputStream(new FileInputStream(zipFileName));
		ZipEntry z;
		while ((z=in.getNextEntry() )!= null)
		{
			if (z.isDirectory())
			{
				String name=z.getName();
				name=name.substring(0,name.length()-1);
				File f=new File(outputDirectory+File.separator+name);
				f.mkdir();
				System.out.println("mkdir "+outputDirectory+File.separator+name);
			}
			else{
				File f=new File(outputDirectory+File.separator+z.getName());
				f.createNewFile();
				FileOutputStream out=new FileOutputStream(f);
				int b;
				while ((b=in.read()) != -1)
					out.write(b);
				out.close();
			}
		}

		in.close();
	}

	
	/**
	 * 压缩文件
	 * @param out
	 * @param f
	 * @param base
	 * @throws Exception
	 */
	public static void zip(ZipOutputStream out,File f,String base)throws Exception
	{
		if (f.isDirectory())
		{
			File[] fl=f.listFiles();
			out.putNextEntry(new ZipEntry(base+"/"));
			base=base.length()==0?"":base+"/";
			for (int i=0;i<fl.length ;i++ )
			{
				zip(out,fl[i],base+fl[i].getName());
			}
		}
		else
		{
			out.putNextEntry(new ZipEntry(base));
			FileInputStream in=new FileInputStream(f);
			int b;
			while ((b=in.read()) != -1)
				out.write(b);
			in.close();
		}

	}
	

	public static Object getFileParam(String key,String... params){
		InputStream in;
		try {
			in=FileUtils.class.getResourceAsStream("/config/path.properties");
			Properties properties = new Properties();
			properties.load(in);
			return MessageFormat.format(properties.getProperty(key),params);
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException("获得文件参数错误:"+e.getMessage());
		}catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException("获得文件参数错误:"+e.getMessage());
		}
	}
	
	public static Object getFileParam(String key){
		InputStream in;
		try {
			in=FileUtils.class.getResourceAsStream("/config/path.properties");
			Properties properties = new Properties();
			properties.load(in);
			return properties.getProperty(key);
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			throw new RuntimeException("获得文件参数错误:"+e.getMessage());
		}catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException("获得文件参数错误:"+e.getMessage());
		}
	}
	
	public static String writeMergeExcel(List<String> filesList, String tempMergePath) throws Exception{
		Workbook wb = new XSSFWorkbook();
		String excelPath = tempMergePath + "/" + "excel"+System.currentTimeMillis()+".xlsx";
		FileOutputStream fileOut = new FileOutputStream(excelPath);
		Sheet sheet = wb.createSheet("Result_Merge_Sheet");
		int i = 0;
		int j=0;//增加行数，行数需要不断累加，所以提出来
		int x=0;//判断总数是否超过40000，（excel极限行数65535）
		for (String url : filesList) {
			FileInputStream fin = new FileInputStream(url);
			Workbook readWb = new XSSFWorkbook(fin);
			fin.close();

			Sheet readSheet = readWb.getSheetAt(0);
			int flag = 0;//只有第一行时需要保存标题栏
			for (Iterator rowIterator = readSheet.iterator(); rowIterator.hasNext();j++) {
//				if(i > 0 && flag==0)
//					rowIterator.next();
				
				x++;//不断累加，到40000清零
				
				//超过总数会溢出，所以新增一个sheet，j 清零
				if(j == 20000){
					sheet = wb.createSheet("Result_Merge_Sheet"+i);
					j = 0;
				}
				
				if(x == 40001){
					x=0;
					wb.write(fileOut);
					fileOut.close();
					wb = null;
					
					wb = new XSSFWorkbook();
					excelPath = tempMergePath + "/" + "excel"+System.currentTimeMillis()+".xlsx";
					fileOut = new FileOutputStream(excelPath);
					sheet = wb.createSheet("Result_Merge_Sheet"+i);
					j = 0;
				}
				
				Row row = sheet.createRow((short)j);
				int z=0;//列数下标
				Row readRow = (Row) rowIterator.next();
				
				for (Iterator cellIterator2 = readRow.cellIterator(); cellIterator2.hasNext();z++,flag++) {
					Cell cell = row.createCell(z);
					Cell readCell = (Cell) cellIterator2.next();
					
					switch (readCell.getCellType()) {
					case Cell.CELL_TYPE_STRING:
						cell.setCellValue(readCell.getStringCellValue());
						break;
					case Cell.CELL_TYPE_NUMERIC:
						if(DateUtil.isCellDateFormatted(cell)) {
							cell.setCellValue(readCell.getDateCellValue());
						} else {
							cell.setCellValue(readCell.getNumericCellValue());
						}
						break;
					case Cell.CELL_TYPE_BOOLEAN:
				        cell.setCellValue(readCell.getBooleanCellValue());
				        break;
				      case Cell.CELL_TYPE_FORMULA:
				        cell.setCellValue(readCell.getCellFormula());
				        break;
					default:
						cell.setCellValue("");
						break;
					}
				}
			}
			i++;
		}

		wb.write(fileOut);
		fileOut.close();
		
		return excelPath;
		
	}
	
	public static void main(String[] args) {
		String tempMergePath="D:/workspace/employee/WebApps/export/temp";
		String zipfile="D:/workspace/employee/WebApps/export/20101219171341359_01.zip";
		try {
			FileUtils.zip(zipfile, tempMergePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
