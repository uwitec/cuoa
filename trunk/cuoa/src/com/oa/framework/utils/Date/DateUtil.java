package com.oa.framework.utils.Date;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

final public class DateUtil {

  private static Map<String,DateFormat> FormatterPool = new HashMap<String,DateFormat>();
  //一天和一年的毫秒数，不精确，只用在一般场合
  private final static long TimeMillis_OneDay = 1000l * 60l * 60l * 24l;
  private final static long TimeMillis_OneYear = 1000l * 60l * 60l * 24l * 365l;
  //private final static long TimeMillis_OneYear2 = 1000 * 60 * 60 * 24 * 365;

  private DateUtil() {
  }

/*  public static void main(String[] args) {
	  Calendar date=Calendar.getInstance();
	  date.set(Calendar.YEAR,2009);
	  date.set(Calendar.MONTH,2);
	  date.set(Calendar.DAY_OF_MONTH,2);
	  System.out.println("cur"+date.getTime());
	  Calendar lastdate=Calendar.getInstance();
	  System.out.println("last:"+lastdate.getTime());
	  System.out.println(date.getTime().after(lastdate.getTime()));
  }
*/

  public static String getCurrentTime(String pattern) {
    return formatTime(pattern, DateUtil.getCurrentTime());
  }

  private static DateFormat getFormatter(String pattern) {
    DateFormat df =  FormatterPool.get(pattern);
    if (df == null) {
      df = new SimpleDateFormat(pattern);
      FormatterPool.put(pattern, df);
    }
    return df;
  }

  public static String formatTime(String pattern, Date time) {
    return getFormatter(pattern).format(time);
  }

  public static Date parseTime(String value, String pattern) throws
      ParseException {
    return getFormatter(pattern).parse(value);
  }

  public static Date getCurrentTime() {
    return Calendar.getInstance().getTime();
  }

  /**
   * 得到离当前时间之前或者之后的时间
   * @param indicator int - 标识，必须是Calendar类中的常量，比如Calendar.YEAR
   * @param amount int - 之前或之后多长时间
   * @return Date
   */
  public static Date beyondCurrent(int indicator, int amount) {
    Calendar currentTime = Calendar.getInstance();
    currentTime.add(indicator, amount);
    return currentTime.getTime();
  }

  public static String getCurrentTime(String pattern, Locale locale) {
    return new SimpleDateFormat(pattern,
                             locale).format(Calendar.getInstance().getTime());
  }

  public static Integer getAge(Date birthdate) {
    if (birthdate == null) {
      return null;
    }
    return new Integer(getDiffer(birthdate, getCurrentTime(), Calendar.YEAR));
  }

  /**
   * 计算两个时间之间的差距
   * @param beginTime Date - 开始天数
   * @param endTime Date - 结束天数
   * @param indicator int - 差额的单位，年或日
   * @return int
   */
  public static int getDiffer(Date beginTime,
                              Date endTime,
                              int indicator) {
    long betweenTimeMillis = endTime.getTime() - beginTime.getTime();
    //System.out.println("?????????????"+indicator);
    switch (indicator) {
      
      case Calendar.YEAR: {
        return (int) (betweenTimeMillis / TimeMillis_OneYear + 0.5);
      }
      case Calendar.DATE: {
        return (int) (betweenTimeMillis / TimeMillis_OneDay + 0.5);
      }
    }
    return 0;
  }

  /**
   * 得到一个日期值的边界时间
   * @param date Date
   * @return Date[]
   */
  public static Date[] getDayBounds(Date date) {
    if (date == null) {
      return null;
    }
    Date[] bounds = new Date[2];
    Calendar c1 = Calendar.getInstance();
    c1.setTime(date);
    c1.set(Calendar.HOUR_OF_DAY, 0);
    c1.set(Calendar.MINUTE, 0);
    c1.set(Calendar.SECOND, 0);
    bounds[0] = c1.getTime();

    c1.add(Calendar.DATE, 1);
    bounds[1] = c1.getTime();
    return bounds;
  }

  /**
   * 获取当月第一天<br/>
   * @return Date - 当月第一天凌晨(00:00:00)
   */
  public static Date getFirstDayOfCurrentMonth() {
    Calendar c = Calendar.getInstance();
    c.set(Calendar.HOUR_OF_DAY, 0);
    c.set(Calendar.MINUTE, 0);
    c.set(Calendar.SECOND, 0);
    c.set(Calendar.DAY_OF_MONTH, 1);
    return c.getTime();
  }

  /**
   * 获取当月最后一天<br/>
   * @return Date - 当月最后一天的凌晨00:00:00
   */
  public static Date getLastDayOfCurrentMonth() {
    Calendar c = Calendar.getInstance();
    c.set(Calendar.HOUR_OF_DAY, 0);
    c.set(Calendar.MINUTE, 0);
    c.set(Calendar.SECOND, 0);
    c.set(Calendar.DAY_OF_MONTH, c.getActualMaximum(Calendar.DAY_OF_MONTH));
    return c.getTime();
  }

  /**
   * 判断两个日期是否同一天
   * 如果日期都为空，则返回false
   * @param d1 Date
   * @param d2 Date
   * @return boolean
   */
  public static boolean isSameDay(Date d1, Date d2) {
    if (d1 == null || d2 == null) {
      return false;
    }
    Calendar c1 = Calendar.getInstance();
    c1.setTime(d1);
    Calendar c2 = Calendar.getInstance();
    c2.setTime(d2);
    if (c1.get(Calendar.DAY_OF_YEAR) != c2.get(Calendar.DAY_OF_YEAR)) {
      return false;
    }
    if (c1.get(Calendar.YEAR) != c2.get(Calendar.YEAR)) {
      return false;
    }
    return true;

  }
  
  /*
   * 获取给定日期的前n周的周五
   */
  public static Date getFriday(Date date,int n)
  {
	  Calendar calendar=Calendar.getInstance();
	  System.out.println("getFriday():"+date);
	  calendar.setTime(date);   
	  calendar.set(Calendar.WEEK_OF_MONTH,calendar.get(Calendar.WEEK_OF_MONTH)-n);
	  Date newdate=calendar.getTime();
	  SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	  Date d = null;
	  try
	  {
	   d = format.parse(format.format(newdate));
	  }
	  catch(Exception e)
	  {
	   e.printStackTrace();
	  }
	  Calendar cal = Calendar.getInstance();
	  cal.setTime(d);
	  cal.set(Calendar.DAY_OF_WEEK,Calendar.FRIDAY);
	  return cal.getTime();
  }
  
  /*
	 * 返回给定日期的那周的周一的日期
	 */
	public static Date getMonday(Date date)
	 {
	  SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	  Date d = null;
	  try
	  {
	   d = format.parse(format.format(date));
	  }
	  catch(Exception e)
	  {
	   e.printStackTrace();
	  }
	  Calendar cal = Calendar.getInstance();
	  cal.setTime(d);
	  cal.set(Calendar.DAY_OF_WEEK,Calendar.MONDAY);
	  return cal.getTime();
	 }

	/**
	 * 返回给定日期的后N天的日期
	 */
	public static Date getAfter(Date date,int n)
	{
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		try {
			cal.setTime(format.parse(format.format(date)));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		cal.add(Calendar.DATE, n);
		return cal.getTime();
	}
	
	/**
	 * 得到指定域指定值和的时间
	 * @param date
	 * @param field
	 * @param n
	 * @return
	 */
	public static Date getAddDate(Date date,int field,int n){
		Calendar cal=Calendar.getInstance();
		cal.setTime(date);
		cal.add(field,n);
		return cal.getTime();
	}
	
	public static java.util.Map<String,String> getDate() {
        java.util.Map<String,String> result = new java.util.HashMap<String,String>();
        Calendar now = getToday();
        Calendar compare = getCurrentMonthFirstDay();
        int difference = getBaysbetween(now, compare);
        // System.out.println("difference---" + getBaysbetween(now, compare));
        if (difference == 0) {// 如果是当月的第一天时
            result.put("startdate", getCalendarToString(getBeforeMonthFirstDay()));// 上月的第一天
            result.put("enddate", getCalendarToString(getBeforeMonthLastDay()));// 上月的最后一天
        } else {
            result.put("startdate", getCalendarToString(getCurrentMonthFirstDay()));// 本月的第一天
            result.put("enddate", getCalendarToString(getYesterday()));// 昨天
        }
        return result;
    }
    // --相隔的天数
    private static int getBaysbetween(java.util.Calendar d1, java.util.Calendar d2) {
        if (d1.after(d2)) { 
            java.util.Calendar swap = d1;
            d1 = d2;
            d2 = swap;
        }
        int days = d2.get(java.util.Calendar.DAY_OF_YEAR) - d1.get(java.util.Calendar.DAY_OF_YEAR);
        int y2 = d2.get(java.util.Calendar.YEAR);
        if (d1.get(java.util.Calendar.YEAR) != y2) {
            d1 = (java.util.Calendar) d1.clone();
            do {
                days += d1.getActualMaximum(java.util.Calendar.DAY_OF_YEAR);
                d1.add(java.util.Calendar.YEAR, 1);
            } while (d1.get(java.util.Calendar.YEAR) != y2);
        }
        return days;
    }
    // --上月第一天
    public static Calendar getBeforeMonthFirstDay() {
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
        Calendar cpcalendar = new GregorianCalendar();
        cpcalendar.add(Calendar.MONTH, -1);
        cpcalendar.set(Calendar.DAY_OF_MONTH, 1);
        format.format(cpcalendar.getTime());
        // System.out.println("上月第一天--" + now);
        return cpcalendar;
    }
    // -- 上月的最后一天
    public static Calendar getBeforeMonthLastDay() {
        java.text.SimpleDateFormat format2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
        Calendar cpcalendar = new GregorianCalendar();
        cpcalendar.set(Calendar.DATE, 1);// 设为当前月的1号
        cpcalendar.add(Calendar.DATE, -1);// 减一天，变为上月最后一天
        java.util.Date date = cpcalendar.getTime();
        format2.format(date);
        // System.out.println("上月最后一天--" + now);
        return cpcalendar;
    }
    // -- 本月第一天
    public static Calendar getCurrentMonthFirstDay() {
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
        Calendar cpcalendar = new GregorianCalendar();
        cpcalendar.set(Calendar.DAY_OF_MONTH, 1);
        format.format(cpcalendar.getTime());
        // System.out.println("本月第一天--" + now);
        return cpcalendar;
    }
    // --本月最后一天
    public static Calendar getCurrentMonthLastDay() {
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
        Calendar cpcalendar = new GregorianCalendar();
        cpcalendar.set(Calendar.DAY_OF_MONTH, 1);
        cpcalendar.add(Calendar.MONTH, 1);
        cpcalendar.add(Calendar.DATE, -1);
        format.format(cpcalendar.getTime());
        // System.out.println("本月最后第一天--" + now);
        return cpcalendar;
    }
    // --昨天
    public static Calendar getYesterday() {
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
        Calendar cpcalendar = new GregorianCalendar();
        cpcalendar.add(Calendar.DATE, -1);
        format.format(cpcalendar.getTime());
        // System.out.println("昨天--" + now);
        return cpcalendar;
    }
	// --当天日期
	public static Calendar getTodayDate() {
		Calendar cpcalendar = Calendar.getInstance();
		cpcalendar = new GregorianCalendar(cpcalendar.get(Calendar.YEAR),
				cpcalendar.get(Calendar.MONTH), cpcalendar
						.get(Calendar.DATE));
		return cpcalendar;
	}
    // --当天
    public static Calendar getToday() {
        java.text.SimpleDateFormat format = new java.text.SimpleDateFormat("yyyy-MM-dd");
        Calendar cpcalendar = new GregorianCalendar();
        format.format(cpcalendar.getTime());
        // System.out.println("当天--" + now);
        return cpcalendar;
    }
    // --字符日期转换成日期
    public static Calendar getStringtoDate(String targetDate) {
        Calendar cpcalendar = new GregorianCalendar();
        try {
            java.text.SimpleDateFormat parseTime = new java.text.SimpleDateFormat("yyyy-MM-dd");
            java.util.Date date = parseTime.parse(targetDate);
            cpcalendar.setTime(date);
        } catch (java.text.ParseException e) {
            e.printStackTrace();
        }
        return cpcalendar;
    }
    // -- 将Calendar 变 String
    public static String getCalendarToString(Calendar carlendar) {
        java.text.SimpleDateFormat dateformat = new java.text.SimpleDateFormat("yyyy-MM-dd");
        return dateformat.format(carlendar.getTime());
    }
 // -- 将Calendar 变 String
    public static String getCalendarToStringFolder() {
        java.text.SimpleDateFormat dateformat = new java.text.SimpleDateFormat("yyyyMMdd");
        Calendar cpcalendar = new GregorianCalendar();
        return dateformat.format(cpcalendar.getTime());
    }
   
    /**
     * 判断当前日期是否在周五17点之前
     * @param date1
     * @param date2
     * @return
     */
    public static boolean nowIsBeforeFriday()
    {
    	 Date now=new Date();
		 Date friday=getFriday(now, 0);
		 friday.setHours(17);
		 friday.setMinutes(0);
//		 Calendar calendar1=Calendar.getInstance();
//    	 calendar1.setTime(now);
//         Calendar calendar2=Calendar.getInstance();
//         calendar2.setTime(friday);
//         System.out.println("friday:"+calendar2.getTime());
         return now.before(friday);
    }
    
    /**
     * 判断一个日期是否在周一9点之后
     * @param date1
     * @param date2
     * @return
     */
    public static boolean nowIsAfterMonday()
    {
    	Date now=new Date();
		Date monday=getMonday(now);
		monday.setHours(9);
		monday.setMinutes(0);
//    	Calendar calendar1=Calendar.getInstance();
//        calendar1.setTime(now);
//        Calendar calendar2=Calendar.getInstance();
//        calendar2.setTime(monday);
//        System.out.println("monday:"+calendar2.getTime());
        return now.after(monday);
    }
    /**
     * 判断当前时间是否在当年9月1日之前
     * @param
     * @param
     * @return
     */
    public static boolean comptosempone(){
    	//得到当前时间
		java.sql.Timestamp ctime = new java.sql.Timestamp(System.currentTimeMillis());
	  int cyear = Calendar.getInstance().get(Calendar.YEAR);  
		String year_str = String.valueOf(cyear);
	  Calendar comp =Calendar.getInstance();
		comp.set(Calendar.YEAR, cyear);
		comp.set(Calendar.MONTH, 8);
		comp.set(Calendar.DAY_OF_MONTH,1);
		comp.set(Calendar.HOUR_OF_DAY, 0);
		comp.set(Calendar.MINUTE, 0);
		comp.set(Calendar.SECOND, 0);
		if(ctime.after(comp.getTime()))
	  return true;
		else
	  return false;
    }
    
    /**
     * 获取当前日期是星期几
     * 
     * @param dt
     * @return 当前日期是星期几
     */
    public static String getWeekOfDate(Date dt) {
        String[] weekDays = {"星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"};
        Calendar cal = Calendar.getInstance();
        cal.setTime(dt);

        int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
        if (w < 0)
            w = 0;

        return weekDays[w];
    }


   public static void main(String[]args) {
	   try {
		Date start=parseTime("2010-9-6", "yyyy-MM-dd");
		Date end=parseTime("2011-1-4", "yyyy-MM-dd");
		StringBuffer buffer=new StringBuffer();
		int i=0;
		while(start.before(end)){
			i++;
			buffer.append(","+formatTime("yyyy-MM-dd", start));
			start=getAfter(start, 7);
		}
		System.out.println("abc:"+i+buffer.toString());
		
		
	} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
   }
	   
    
}