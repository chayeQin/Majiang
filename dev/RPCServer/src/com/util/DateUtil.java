package com.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期工具类
 */
public final class DateUtil {
	public static final DateFormat zone = new SimpleDateFormat("Z");
	public static final DateFormat filename = new SimpleDateFormat(
			"-yyyy-MM-dd-HH-mm-ss-");
	public static final DateFormat format = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");
	public static final DateFormat openact = new SimpleDateFormat("yyyy.MM.dd");
	public static final DateFormat simple = new SimpleDateFormat("yyyy-MM-dd");
	public static final DateFormat sdate = new SimpleDateFormat("yyyyMMdd");
	public static final DateFormat total = new SimpleDateFormat("yyyy/MM/dd");
	public static final DateFormat byrob = new SimpleDateFormat(
			"yy-MM-dd HH:mm");
	public static final DateFormat time = new SimpleDateFormat("HH:mm:ss");
	
	/** 今日0点 **/
	private static long todayZeroTime = 0;
	/** 明日0点 **/
	private static long tomorrowZeroTime = 0;
	
	private static void zeroTime() {
		if(System.currentTimeMillis() > tomorrowZeroTime){
			try {
				todayZeroTime = simple.parse(simple.format(new Date())).getTime();
				tomorrowZeroTime = todayZeroTime + (1*24*60*60*1000);		
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
	}
	/**
	 * 获取今日0点
	 */
	public static long getTodayZeroTime(){
		zeroTime();
		return todayZeroTime;
	}
	/**
	 * 获取明日0点
	 */
	public static long getTomorrowZeroTime(){
		zeroTime();
		return tomorrowZeroTime;
	}
	
	public static Date getSystemTime() {
		return getSystemTime(1);
	}

	public static String getStrSystemTime() {
		return getStrSystemTime(1);
	}

	/**
	 * 获取系统时间
	 * 
	 * @param type
	 *            : 1 获取日期 2 获取详细时间
	 * @return 日期类型时间
	 * @throws ParseException
	 */
	public static Date getSystemTime(int type) {
		DateFormat sdf = format;
		if (type == 1) {
			sdf = simple;
		}

		Calendar calendar = Calendar.getInstance();
		sdf.format(calendar.getTime());
		Date date = null;
		try {
			date = sdf.parse(sdf.format(calendar.getTime()));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	/**
	 * 获取系统时间
	 * 
	 * @param type
	 *            : 1 获取日期 2 获取详细时间
	 * @return 字符串类型时间
	 * @throws ParseException
	 */
	public static String getStrSystemTime(int type) {
		DateFormat sdf = format;
		if (type == 1) {
			sdf = simple;
		}

		Calendar calendar = Calendar.getInstance();
		sdf.format(calendar.getTime());
		String strdate = null;
		strdate = sdf.format(calendar.getTime());
		return strdate;
	}

	/**
	 * 获取日期相差天数
	 * 
	 * @param
	 * @return 日期类型时间
	 * @throws ParseException
	 */
	public static Long getDiffDay(String beginDate, String endDate) {
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Long checkday = 0l;
		// 开始结束相差天数
		try {
			checkday = (formatter.parse(endDate).getTime() - formatter.parse(
					beginDate).getTime())
					/ (1000 * 24 * 60 * 60);
		} catch (ParseException e) {
			e.printStackTrace();
			checkday = null;
		}
		return checkday;
	}

	public static Long getDiffDay(Date beginDate, Date endDate) {
		if (beginDate == null) {
			beginDate = getCurrentDate();
		}
		if (endDate == null) {
			endDate = getCurrentDate();
		}
		String strBeginDate = format.format(beginDate);
		String strEndDate = format.format(endDate);
		return getDiffDay(strBeginDate, strEndDate);
	}

	/**
	 * 获取日期相月数
	 * 
	 * @param
	 * @return 日期类型时间
	 * @throws ParseException
	 */
	public static int getDiffMonth(String beginDate, String endDate) {
		DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		Date dbeginDate = null;
		Date dendDate = null;
		try {
			dbeginDate = formatter.parse(beginDate);
			dendDate = formatter.parse(endDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return getDiffMonth(dbeginDate, dendDate);
	}
	
	/**
	 * 获取当天0点时间戳(毫秒)
	 * @return
	 */
	public static long getDayZero() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(getCurrentDate());
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.MILLISECOND, 001);
		return cal.getTimeInMillis();
	}
	
	public static int getDiffMonth(Date beginDate, Date endDate) {
		Calendar calbegin = Calendar.getInstance();
		Calendar calend = Calendar.getInstance();
		calbegin.setTime(beginDate);
		calend.setTime(endDate);
		int m_begin = calbegin.get(Calendar.MONTH) + 1; // 获得合同开始日期月份
		int m_end = calend.get(Calendar.MONTH) + 1;
		// 获得合同结束日期月份
		int checkmonth = m_end - m_begin
				+ (calend.get(Calendar.YEAR) - calbegin.get(Calendar.YEAR))
				* 12;
		// 获得合同结束日期于开始的相差月份
		return checkmonth;
	}

	// 格式化日期YYYYMMDDHH24MISS为YYYY-MM-DD HH24:MI:SS
	public static String formatdate1(String str) {
		if (str == null || str.length() != 14)
			return "";
		return str.substring(0, 4) + "-" + str.substring(4, 6) + "-"
				+ str.substring(6, 8) + " " + str.substring(8, 10) + ":"
				+ str.substring(10, 12) + ":" + str.substring(12, 14);
	}

	// 格式化日期YYYYMMDDHH24MISS为YYYY年MM月DD日 HH24时MI分SS秒
	public static String formatdate2(String str) {
		if (str == null)
			return "";
		if (str.length() != 14)
			return str;
		return str.substring(0, 4) + "年" + str.substring(4, 6) + "月"
				+ str.substring(6, 8) + "日 " + str.substring(8, 10) + "时"
				+ str.substring(10, 12) + "分" + str.substring(12, 14) + "秒";
	}

	// 格式化日期YYYYMMDDHH24MISS为YYYY年MM月DD日
	public static String formatdate3(String str) {
		if (str == null)
			return "";
		if (str.length() < 8)
			return str;
		return str.substring(0, 4) + "年" + str.substring(4, 6) + "月"
				+ str.substring(6, 8) + "日 ";
	}

	// 格式化日期YYYYMMDDHH24MISS为YYYY年MM月DD日
	public static String formatdate4(String str) {
		if (str == null)
			return "";
		if (str.length() < 8)
			return str;
		return str.substring(0, 4) + "-" + str.substring(4, 6) + "-"
				+ str.substring(6, 8);
	}

	public static String format(String datestr, String format) {
		DateFormat s = new SimpleDateFormat(format);
		Date date = null;
		try {
			date = s.parse(datestr);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return s.format(date);
	}

	/**
	 * 取得当前日期到指定日期剩余天数
	 * 
	 */
	public static long getDateCount(String endtime) {
		DateFormat s = new SimpleDateFormat("yyyy-MM-dd");
		long aa = 0;
		long date = 0;
		try {
			Date now = getCurrentDate();
			Date end = s.parse(endtime);
			aa = end.getTime() - now.getTime();
			date = aa / 1000 / 60 / 60 / 24;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return date;
	}

	/**
	 * 取得30天后的日期
	 */
	public static String getDate() {
		DateFormat s = new SimpleDateFormat("yyyy-MM-dd");

		long aa = 0;
		String date = null;
		try {
			Date now = getCurrentDate();
			aa = now.getTime() + (1000 * 60l * 60 * 24 * 20);
			aa = aa + (1000 * 60l * 60 * 24 * 11);
			now.setTime(aa);
			date = s.format(now);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return date;
	}

	/**
	 * 当前日期count天后的日期
	 * 
	 * @param count指定天数
	 * @return
	 */
	public static String getDate(int count) {
		DateFormat s = new SimpleDateFormat("yyyy-MM-dd");

		long aa = 0;
		String date = null;
		try {
			Date now = getCurrentDate();
			if (count > 20) {
				aa = now.getTime() + (1000 * 60l * 60 * 24 * 20);
				aa = aa + (1000 * 60l * 60 * 24 * (count - 20));
			} else {
				aa = now.getTime() + (1000 * 60l * 60 * 24 * count);
			}
			now.setTime(aa);
			date = s.format(now);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return date;
	}

	/**
	 * 取得当前周的周一的日期
	 */
	public static String getMondayDate() {
		Date date = getCurrentDate();
		DateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		int dayInWeek = getWeekDay(date);// 当前日期的星期数
		int daycount = dayInWeek - 2;// 当前日期于周一相隔的天数

		if (daycount < 0) {
			daycount = 6;
		}
		long monday_time = date.getTime() - (daycount * 24 * 60l * 60 * 1000);
		date.setTime(monday_time);
		String dt = sf.format(date);
		return dt;
	}

	/**
	 * 取得当前日期 yyyy-MM-dd
	 */
	public static String getCurrenDate() {
		Date date = getCurrentDate();
		DateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		String dt = sf.format(date);
		return dt;
	}

	/**
	 * 取得当前日期 yyyy-MM-dd
	 */
	public static String getCurrenDate(String format) {
		Date date = getCurrentDate();
		DateFormat sf = new SimpleDateFormat(format);
		String dt = sf.format(date);
		return dt;
	}

	/**
	 * 取得当前时间 yyyy-MM-dd HH:mm:ss
	 */
	public static String getCurrenTimes() {
		Date date = getCurrentDate();
		DateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String dt = sf.format(date);
		return dt;
	}

	/**
	 * 取得指定日期的在一周中的位置 周日为1
	 */
	public static int getWeekDay(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.setFirstDayOfWeek(Calendar.MONDAY);
		int day = calendar.get(Calendar.DAY_OF_WEEK);
		return day;
	}

	/**
	 * 返回两个日期的天数差
	 * 
	 * @return
	 */
	public static int getShortenedTime(Date startDate, Date endDate) {
		long startlong = startDate.getTime();

		long endlong = endDate.getTime();

		long result = endlong - startlong;

		int returnInt = (int) (result / 1000 / 60l / 60 / 24);

		return returnInt;
	}

	/**
	 * 字符串转换成日期
	 * 
	 * @param str
	 *            格式必须为 '2010-05-14'
	 * @return date 格式为 '2010年05月14日'
	 */
	public static Date StrToDate(String str) {
		if (str == null || str.equals("")) {
			return getCurrentDate();
		}
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date date = getCurrentDate();
		try {
			date = format.parse(str);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return date;
	}

	/**
	 * 字符串encoding字节数
	 */
	public static int strPointAt(String str) {
		int length = str.length();
		int b = 0;
		int c = 0;
		while (length > 0) {
			c = str.codePointAt(length - 1);
			b += (c < 128) ? 1 : ((c < 2048) ? 2 : ((c < 65536) ? 3 : 4));
			length--;
		}
		return b;
	}

	/**
	 * 字符串按字节截取
	 * 
	 * @param str
	 *            原字符
	 * @param len
	 *            截取长度
	 * @param elide
	 *            省略符
	 * @return String
	 * @author liangk
	 * @since 2010.05.25
	 */

	public static String splitString(String str, int len, String elide) {
		if (str == null) {
			return "";
		}
		byte[] strByte = str.getBytes();
		int strLen = strByte.length;
		int elideLen = (elide.trim().length() == 0) ? 0
				: elide.getBytes().length;
		if (len >= strLen || len < 1) {
			return str;
		}
		if (len - elideLen > 0) {
			len = len - elideLen;
		}
		int count = 0;
		for (int i = 0; i < len; i++) {
			int value = (int) strByte[i];
			if (value < 0) {
				count++;
			}
		}
		if (count % 2 != 0) {
			len = (len == 1) ? len + 1 : len - 1;
		}
		return new String(strByte, 0, len) + elide.trim();
	}

	/**
	 * 得到当前日期的前N天 返回Date
	 */
	public static Date getBeginOfN(Date date, int N) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DAY_OF_MONTH, N);
		Date fina_begin = calendar.getTime();
		return fina_begin;
	}

	/**
	 * 获取上个月的同一天
	 * 
	 * @param datestr
	 * @return
	 * @author F.J.wang
	 * @date 2011-9-29
	 */
	public static String getPrevMouth(String datestr, String format) {
		DateFormat sdf = new SimpleDateFormat(format);
		Calendar cal = Calendar.getInstance();
		Date date = null;
		try {
			date = sdf.parse(datestr);
			cal.setTime(date);
			cal.add(Calendar.MONTH, -1);// 取前一个月的同一天
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return sdf.format(cal.getTime());
	}

	/**
	 * 两个日期比较大小
	 * @param startDate 开始日期
	 * @param endDate 结束日期
	 * @return 开始日期 > 结束日期
	 */
	public static boolean compare(String startDate, String endDate) {
		return compare(startDate,endDate,format);
	}
	/**
	 * 两个日期比较大小
	 * @param startDate 开始日期
	 * @param endDate 结束日期
	 * @param sdf 格式化
	 * @return 结束日期
	 */
	public static boolean compare(String startDate, String endDate,DateFormat sdf) {
		if (startDate == null || endDate == null) {
			return false;
		}
		Date date1 = null;
		Date date2 = null;
		try {
			date1 = sdf.parse(startDate);
			date2 = sdf.parse(endDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		return date2.getTime() < date1.getTime();
	}
	/**
	 * 计算两个日期之间相差的天数
	 * 
	 * @param smdate
	 *            较小的时间
	 * @param bdate
	 *            较大的时间
	 * @return 相差天数
	 * @throws ParseException
	 */
	public static int getDaysBetween(Date smdate, Date bdate) {
		if (smdate == null) {
			smdate = getCurrentDate();
		}
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		try {
			smdate = sdf.parse(sdf.format(smdate));
			bdate = sdf.parse(sdf.format(bdate));
		} catch (ParseException e) {
			e.printStackTrace();
		}

		Calendar cal = Calendar.getInstance();
		cal.setTime(smdate);
		long time1 = cal.getTimeInMillis();
		cal.setTime(bdate);
		long time2 = cal.getTimeInMillis();
		long between_days = (time2 - time1) / (1000 * 60l * 60 * 24);

		int days = -1;
		try {
			days = Integer.parseInt(String.valueOf(between_days));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return days;
	}

	/**
	 * 字符串的日期格式的计算
	 */
	public static int getDaysBetween(String smdate, String bdate)
			throws ParseException {
		DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		cal.setTime(sdf.parse(smdate));
		long time1 = cal.getTimeInMillis();
		cal.setTime(sdf.parse(bdate));
		long time2 = cal.getTimeInMillis();
		long between_days = (time2 - time1) / (1000 * 60l * 60 * 24);

		return Integer.parseInt(String.valueOf(between_days));
	}

	/**
	 * 根据日期字符串取得毫秒
	 * 
	 * @param str
	 *            日期字符串
	 * @return 毫秒
	 */
	public static long getTimeByDateStr(String str) {
		if (str == null || str.isEmpty()) {
			return -1;
		}
		try {
			Date date = simple.parse(str);
			return date.getTime();
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	private static long thisTimeDifference ; // 时间偏移量, 主要用于 gm 测试
	public long getThisTimeDifference() {
		return thisTimeDifference;
	}
	public static long getCurrentTimeMillis() {
		long currentTimeMillis = System.currentTimeMillis()
				+ thisTimeDifference;
		return currentTimeMillis;
	}
	
	/** 当前时间戳(秒)*/
	public static long getCurrentTimeSecond(){
		return getCurrentTimeMillis() / 1000 ;
	}

	public static Date getCurrentDate() {
		long currentTimeMillis = System.currentTimeMillis()
				+ thisTimeDifference;
		Date currentDate = new Date(currentTimeMillis);
		return currentDate;
	}

	public static void setCurrentTimeMillis(long currentTimeMillis) {
		thisTimeDifference = currentTimeMillis
				- System.currentTimeMillis();
	}

	public static void resetCurrentTimeMillis() {
		thisTimeDifference = 0;
	}
}