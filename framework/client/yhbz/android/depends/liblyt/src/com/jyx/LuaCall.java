package com.jyx;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.json.JSONArray;
import org.json.JSONObject;

import android.util.Log;

/**
 * 调用指定类的指定方法
 * @author lyt
 *
 */
public class LuaCall {
	private static final String LOG = "com.jyx.Call";
	
	/** 所有类的方法 */
	private static HashMap<String,HashMap<String,Method>> classMap = new HashMap<String,HashMap<String,Method>>();
	/** 所有对象 */
	private static HashMap<String,LuaFunc> objMap = new HashMap<String,LuaFunc>();
	
	/** 增加一个类 */
	public static void add(LuaFunc obj){
		String className = obj.getClass().getSimpleName();
		if(classMap.containsKey(className)){
			Log.e(LOG, className + "in classMap!!");
			return;
		}
		Method[] list = obj.getClass().getMethods();
		HashMap<String,Method> methodMap = new HashMap<String, Method>();
		for(Method method : list){
			methodMap.put(method.getName(), method);
		}
		classMap.put(className, methodMap);
		objMap.put(className, obj);
	}
	
	/**
	 * 获取现在的对象
	 * @param className
	 * @return
	 */
	public static Object get(String className){
		if(classMap.containsKey(className)){
			return classMap.get(className);
		}
		
		return null;
	}
	
	/** 调用方法 */
	public static void call(final String className,final String methodName,final String json,final int rhand){
		Log.e(LOG,"call " + className + ":" + methodName);
		Log.e(LOG,"call param " + json);
		if(!classMap.containsKey(className)){
			Log.e(LOG,className + " is not find!");
			return;
		}
		
		final Cocos2dxActivity context = (Cocos2dxActivity)Cocos2dxActivity.getContext();
		context.runOnUiThread(new Runnable() {
			
			@Override
			public void run() {
				HashMap<String,Method> methodMap = classMap.get(className);
				Method method = methodMap.get(methodName);
				try {
					ArrayList<Object> args = new ArrayList<Object>();
					if(!"".equals(json)){
						JSONObject obj = new JSONObject(json);
						args.add(obj);
					}
					args.add(rhand);
					method.invoke(objMap.get(className),args.toArray());
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
}
