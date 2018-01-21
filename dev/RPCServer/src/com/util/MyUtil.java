package com.util;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 自定义工具包
 */
public class MyUtil {
	/***************************TODO String操作***************************/
	/**
	 * 字符串替换(不支持正则表达式)
	 * @param str
	 * @param searchStr
	 * @param repStr
	 * @return
	 */
	public static String StringReplaceAll(String str, String searchStr, String repStr){
		int len = searchStr.length();
		int indexOf = 0;
		while((indexOf = str.indexOf(searchStr)) >= 0 ){
			String s1 = str.substring(0,indexOf);
			String s2 = str.substring(indexOf + len,str.length());
			str = s1 + repStr + s2;
		}
		return str;
	}
	
	/**
	 * 字符串替换(不支持正则表达式)
	 * @param str
	 * @param searchStr
	 * @param repStr
	 * @return
	 */
	public static String StringReplaceFirst(String str, String searchStr, String repStr){
		int len = searchStr.length();
		int indexOf = str.indexOf(searchStr);
		if(indexOf >= 0 ){
			String s1 = str.substring(0,indexOf);
			String s2 = str.substring(indexOf + len,str.length());
			str = s1 + repStr + s2;
		}
		return str;
	}
	
	/**
	 * 获取split里面的值
	 * <p>示例：
	 * 	<p>str = ",1001_qyp1005s554,1002_wwws554,"
	 * 	<p>regex = ","
	 * 	<p>searchValue = "qyp1005s554"
	 * 	<p>return = 1001_qyp1005s554
	 * @param str 目标
	 * @param regex 分隔符的正则表达式
	 * @param searchValue 查询值 
	 * @return 查询结果
	 */
	public static String getSplitValue(String str, String regex, String searchValue) {
		if(null == str || str.contains(searchValue) == false)return null;
		//",1001_qyp1005s554,1002_wwws554,1003_w11wws554,"
		try {
			int beginIndex = str.indexOf(regex+searchValue);
			if(beginIndex >= 0){
				//1.搜索1001
				int endIndex = str.indexOf(regex,beginIndex+1);
				return str.substring(beginIndex+1,endIndex);
			}
			beginIndex = str.indexOf(searchValue+regex);
			if(beginIndex >= 0){
				//2.搜索qyp1005s554
				int endIdex = str.lastIndexOf(regex, beginIndex);
				return str.substring(endIdex+1,beginIndex+searchValue.length());
			}
			//3.未找到完全匹配的结果
			return null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/************************TODO String操作****************************/
	/************************TODO 权重算法 *******************************/
	private static final Random WEIGHT_RANDOM = new Random();
	/**
	 * 储存权重值
	 * @param weights 储存进入此List<0=id,1=权重上限值>中
	 * @param id 数据id
	 * @param weight 数据权重值
	 */
	public static void putWeight(List<Object[]> weights,Object id,int weight){
		 int lastWeight = 0;
		 if(weights.isEmpty() == false){
			 lastWeight = (int) weights.get(weights.size() - 1)[1];
		 }
		 weight += lastWeight;
		 //0=id,1=权重上限值
		 weights.add(new Object[]{id,weight});
	}
	/**
	 * 获取权重值
	 * @param weights putWeight时储存的List
	 * @param clazz 返回的类型
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getWeight(List<Object[]> weights,Class<T> clazz){
		if(weights == null || weights.isEmpty()){
			return null;
		}
		if(weights.size() == 1){
			return (T) weights.get(weights.size() - 1)[0];
		}
		int lastWeight = (int) weights.get(weights.size() - 1)[1];
		if(lastWeight <= 0){
			return null;
		}
		int weight = WEIGHT_RANDOM.nextInt(lastWeight);
		int min = 0;
		int max = weights.size();
		//2分算法搜索权重范围
		while(min <= max){
			//获取中间值
			int tmp = min + (max - min) / 2;
			Object[] objs = weights.get(tmp);
			int tmpWeight = (int)objs[1];
			if(weight == tmpWeight){
				return (T) objs[0]; // 相同
			}else if(weight < tmpWeight && (tmp == 0 || weight > (int)weights.get(tmp-1)[1])){
				return (T) objs[0]; // 在范围内
			}else if(weight < tmpWeight){
				max = tmp;
			}else{
				min = tmp;
			}
		}
		return null;
	}
	/************************TODO 权重算法*******************************/
	
	/************************TODO Class操作*****************************/
	private static final Map<String,Method> classMethods = new ConcurrentHashMap<String, Method>();
	/**
	 * 获取值
	 * @param vo
	 * @param param
	 * @return
	 */
	public static int getMethodValue(Object vo, String param) {
		String key = (vo.getClass().getName()+param);
		Method method = classMethods.get(key);
		try {
			if(null == method){
				method = vo.getClass().getMethod(param);
				classMethods.put(key, method);
			}
		} catch (SecurityException e) {
			e.printStackTrace();
		} catch (NoSuchMethodException e) {
			e.printStackTrace();
		}
		if (method == null) {
			return 0;
		}
		Integer value = null;
		try {
			value = (Integer) method.invoke(vo);
		} catch (IllegalArgumentException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return value;
	}
	
	/**
	 * 获取值传类型
	 * @param vo
	 * @param param
	 * @param clazz
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static <T> T getMethodValue(Object vo, String param, Class<T> clazz) {
		String key = (vo.getClass().getName()+param);
		try {
			Method method = classMethods.get(key);
			if(null == method){
				method = vo.getClass().getMethod(param);
				classMethods.put(key, method);
			}
			return (T) method.invoke(vo);
		} catch (Exception e) {
			e.printStackTrace();
			if (clazz.equals(int.class) || clazz.equals(long.class)) {
				return (T) new Integer(0);
			}
			return null;
		}
	}
	
	/**
	 * 设置值
	 * @param vo
	 * @param param
	 * @param value
	 */
	public static void setMethodValue(Object vo, String param, int value) {
		String key = (vo.getClass().getName()+param);
		Method method = classMethods.get(key);
		if(null == method){
			try {
				method = vo.getClass().getMethod(param,int.class);
				classMethods.put(key, method);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if(null == method)return;
		try {
			method.invoke(vo, value);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 设置值传类型
	 * @param vo
	 * @param param
	 * @param value
	 * @param clazz
	 */
	public static <T> void setMethodValue(Object vo, String param, T value, Class<T> clazz) {
		String key = (vo.getClass().getName()+param);
		Method method = classMethods.get(key);
		if(null == method){
			try {
				method = vo.getClass().getMethod(param,clazz);
				classMethods.put(key, method);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		try{
			if(null == method)return;
			method.invoke(vo, value);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/************************Class操作************************/
}
