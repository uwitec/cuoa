package com.oa.framework.utils.file;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ExcelUtil {
	
    
	public static Workbook exportExcel(List<String[]> data) {
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("sheet1");
		int i = 0;
		 CellStyle cellStyle = wb.createCellStyle();
		 cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		 cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_BOTTOM);
		for (String[] aRow : data) {
			Row row = sheet.createRow(i++);
			int j = 0;
			for (String cellValue : aRow) {
				Cell cell = row.createCell(j++);
				cell.setCellValue(cellValue); 
				if(isNumeric(cellValue)) cell.setCellValue(Double.valueOf(cellValue));
				else cell.setCellValue(cellValue);
				cell.setCellStyle(cellStyle);
			}
		}
		return wb;
	}
//2010-9-1
	public static Workbook exportExcelObject(List<Object[]> data) {
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("sheet1");
		int i = 0;
		 CellStyle cellStyle = wb.createCellStyle();
		 cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
		 cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_BOTTOM);
		for (Object[] aRow : data) {
			Row row = sheet.createRow(i++);
			int j = 0;
			for (Object cellValue : aRow) {
				Cell cell = row.createCell(j++);
				cell.setCellValue(cellValue.toString()); 
				if(isNumeric(cellValue.toString())) cell.setCellValue(Double.valueOf(cellValue.toString()));
				else cell.setCellValue(cellValue.toString());
				cell.setCellStyle(cellStyle);
			}
		}
		return wb;
	}
	/**
	 * 生成EXCEL文件
	 * @param filename
	 * @param data
	 */
	public static void exportExcel(String filename,List<Object[]> data,String[] title){
		Workbook wb = new XSSFWorkbook(); 
	    Sheet sheet = wb.createSheet();
	    Row row = sheet.createRow(0);
	    //文件头字体
	    Font font=createFonts(wb,Font.BOLDWEIGHT_BOLD,"宋体",false,(short)200);
	    //设置excel头
	    for(short i=0;i<title.length;i++){
	    	createCell(wb, row,i,title[i],font);
	    }
	    font=createFonts(wb,Font.BOLDWEIGHT_NORMAL,"宋体",false,(short)200);
	    for(int i=0;i<data.size();i++){
	    	row=sheet.createRow(i+1);
	    	for(short j=0;j<title.length;j++){
	    		String tempValue = data.get(i)[j]!=null?data.get(i)[j].toString():"";
    			createCell(wb,row,j,tempValue,font);
	    	}
	    }
	    FileOutputStream fileOut=null;
		try {
			fileOut = new FileOutputStream(filename);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
	    try {
			wb.write(fileOut);
			fileOut.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 创建单元格并设置样式,值
	 * @param wb
	 * @param row
	 * @param column
	 * @param halign
	 * @param valign
	 * @param value
	 */ 
	public static void createCell(Workbook wb, Row row, short column,String value,Font font) {
	    Cell cell = row.createCell(column);
	    if(isNumeric(value)) cell.setCellValue(Double.valueOf(value));
		else cell.setCellValue(value);
	    CellStyle cellStyle = wb.createCellStyle();
	    cellStyle.setAlignment(XSSFCellStyle.ALIGN_CENTER);
	    cellStyle.setVerticalAlignment(XSSFCellStyle.VERTICAL_BOTTOM);
	    cellStyle.setFont(font);
	    cell.setCellStyle(cellStyle);
	}
     
	/**  
     * 设置字体  
     * @param wb  
     * @return  
     */  
    public static Font createFonts(Workbook wb,short bold,String fontName,boolean isItalic,short hight){   
        Font font = wb.createFont();   
        font.setFontName(fontName);   
        font.setBoldweight(bold);
        font.setItalic(isItalic);   
        font.setFontHeight(hight);   
        return font;   
    }   
    /**
     * 判断是否为数字
     * @param str
     * @return
     */
    public static boolean isNumeric(String str){ 
    	if(str==null||"".equals(str.trim())||str.length()>10)return false;
    	Pattern pattern = Pattern.compile("^0|[1-9]\\d*(\\.\\d+)?$"); 
    	return pattern.matcher(str).matches(); 
    } 

    public static void main(String[] args) {
    	System.out.println(Double.SIZE);
		System.out.println(isNumeric("0"));
	}
	/**
	 * 读出excel内容
	 * 
	 * @param in
	 * @return
	 * @throws IOException
	 */

	@SuppressWarnings("deprecation")
	public static List<String[]> getExcelData(File upload) throws IOException {
		// 文件二进制输入流
		InputStream in = new BufferedInputStream(new FileInputStream(upload));
		List<String[]> data = new ArrayList<String[]>();
		// 读取excel工作簿
		XSSFWorkbook wb = new XSSFWorkbook(in);
		SimpleDateFormat sf1 = new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sf2 = new SimpleDateFormat("HH:mm");

		for (int i = 0; i < wb.getNumberOfSheets(); i++) {
			// Excel表
			XSSFSheet sheet = wb.getSheetAt(i);
			// excell的行
			Iterator<Row> rit = sheet.rowIterator();
			while (rit.hasNext()) {
				XSSFRow row = (XSSFRow) rit.next();
				// 行数
				if (row.getRowNum() == 0) {
					continue;
				}
				System.out.println("行数：：："+row.getRowNum());
				String[] strArray = new String[row.getLastCellNum()];
				int count = 0;
				for (short j = 0; j < row.getLastCellNum(); j++) {
					XSSFCell cell = row.getCell(j);
					if (cell == null) {
						strArray[count++] = "";
						continue;
					}
					String cellValue = "";
					switch (cell.getCellType()) {
					case XSSFCell.CELL_TYPE_NUMERIC:
						if (HSSFDateUtil.isCellDateFormatted(cell)) {

							Date date = cell.getDateCellValue();
							GregorianCalendar cal = new GregorianCalendar();
							cal.setTime(date);
							cellValue = cal.get(Calendar.YEAR) < 1950 ? sf2
									.format(date) : sf1.format(date);
						} else {
							cellValue = cell.getNumericCellValue() + "";
							try {
								cellValue = cellValue.substring(0, cellValue
										.indexOf("."));
							} catch (Exception ignore) {
							}
						}
						break;
					case XSSFCell.CELL_TYPE_STRING:
						cellValue = cell.getRichStringCellValue().toString();
						break;
					case XSSFCell.CELL_TYPE_FORMULA:
						cellValue = cell.getNumericCellValue() + "";
						break;
					default:
						cellValue = "";
						break;
					}
					strArray[count++] = cellValue;
				}
				data.add(strArray);
			}
		}
		// 如果is不为空，则关闭InputSteam文件输入流
		if (in != null) {
			in.close();
		}
		return data;
	}

    
}
