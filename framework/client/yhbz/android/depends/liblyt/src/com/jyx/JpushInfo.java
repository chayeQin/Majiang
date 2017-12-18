package com.jyx;

import java.lang.reflect.Field;
import java.lang.reflect.Method;

import org.json.JSONException;
import org.json.JSONObject;

import android.app.AppOpsManager;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.provider.Settings;
import cn.jpush.android.api.JPushInterface;
import cn.jpush.android.data.JPushLocalNotification;

/**
 * 本地推送
 * @author lyt
 *
 */
public class JpushInfo extends LuaFunc {
	
	public void open(final JSONObject args, final int rhand){
		callBack(rhand);
	}
	
	public void check(final JSONObject args, final int rhand){
		String result = "true";
		String CHECK_OP_NO_THROW = "checkOpNoThrow";
		String OP_POST_NOTIFICATION = "OP_POST_NOTIFICATION";

		AppOpsManager mAppOps = (AppOpsManager) context.getSystemService(Context.APP_OPS_SERVICE);
        ApplicationInfo appInfo = context.getApplicationInfo();
        String pkg = context.getApplicationContext().getPackageName();
        int uid = appInfo.uid;
        Class appOpsClass = null; /* Context.APP_OPS_MANAGER */
		try {
			appOpsClass = Class.forName(AppOpsManager.class.getName());

            Method checkOpNoThrowMethod = appOpsClass.getMethod(CHECK_OP_NO_THROW, Integer.TYPE, Integer.TYPE, String.class);

            Field opPostNotificationValue = appOpsClass.getDeclaredField(OP_POST_NOTIFICATION);
            int value = Integer.valueOf(opPostNotificationValue.get(Integer.class).toString());

            int status = Integer.valueOf(checkOpNoThrowMethod.invoke(mAppOps,value, uid, pkg).toString());
            if(status != AppOpsManager.MODE_ALLOWED){
            	result = "false";
            }
		} catch (Exception e) 
		{
		} 
		callBack(rhand, result);
	}
	
	public void openSet(final JSONObject args, final int rhand){
		Intent intent = new Intent(Settings.ACTION_DATA_ROAMING_SETTINGS);
		ComponentName cName = new ComponentName("com.android.phone", "android.settings.APPLICATION_SETTINGS");
		intent.setComponent(cName);
		context.startActivity(intent);
	}
	/**
	 * 本地推送
	 * @param args
	 * @param rhand
	 */
	public void send(final JSONObject args, final int rhand){
		openSet(null,1);
		long time = System.currentTimeMillis();
		int delay = 0;
		String title = "";
		String body = "";
		
		try {
			body = args.getString("body");
			delay = args.getInt("delay");
		} catch (JSONException e) {
		}
		
	   try {
		   PackageManager packageManager = context.getPackageManager();
		   PackageInfo packInfo = packageManager.getPackageInfo(context.getPackageName(),0);
		   title = packInfo.applicationInfo.loadLabel(packageManager).toString();
		} catch (NameNotFoundException e) {
		}
		
		JPushLocalNotification ln = new JPushLocalNotification();
		ln.setBuilderId(0);
		ln.setContent(body);
		ln.setTitle(title);
		ln.setNotificationId(time) ;
		ln.setBroadcastTime(time + delay * 1000);

//		Map<String , Object> map = new HashMap<String, Object>() ;
//		map.put("name", "jpush") ;
//		map.put("test", "111") ;
//		JSONObject json = new JSONObject(map) ;
//		ln.setExtras(json.toString()) ;
		ln.setExtras("") ;
		JPushInterface.addLocalNotification(context, ln);
		
		callBack(rhand);
	}
}
