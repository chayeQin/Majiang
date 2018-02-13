package com.jyx;

import java.io.InputStreamReader;
import java.io.LineNumberReader;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.cocos2dx.lib.Cocos2dxActivity;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.ActivityManager;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.Context;
import android.content.DialogInterface;
import android.content.SharedPreferences;
import android.content.pm.ApplicationInfo;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.content.pm.Signature;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.util.Base64;
import android.util.Log;
import android.widget.Toast;
import cn.jpush.android.api.JPushInterface;

public class Liblyt {
	/**
	 * 初始SDK
	 * @param context
	 */
	public static void init(Cocos2dxActivity context, SDKBase sdk)
	{
		DownloadApk.context = context;
		VideoActivity.context = context;
		
		// jpush
		JPushInterface.init(context);
		
		LuaCall.add(new ApkInfo());
		LuaCall.add(new DataEyeInfo());
		LuaCall.add(new Notis());
		LuaCall.add(new JpushInfo());
		LuaCall.add(new GVoiceInfo(sdk.getGvoiceId(), sdk.getGvoiceKey()));
		LuaCall.add(sdk);
	}

	public static void onResume(Activity context)
	{
		JPushInterface.onResume(context);
		JPushInterface.clearLocalNotifications(context);
		GVoiceInfo.onResume();
	}

	public static void onPause(Activity context)
	{
		JPushInterface.onPause(context);
		GVoiceInfo.onPause();
	}
	
	public static void onDestroy(Activity context)
	{
	}
	
	public static void tips(String msg){
		Toast.makeText(Cocos2dxActivity.getContext(), msg, Toast.LENGTH_SHORT).show();
	}
	
	public static void msg(String txt){
		AlertDialog.Builder builder = new Builder(Cocos2dxActivity.getContext());
		builder.setMessage(txt);
		builder.setTitle("");
		builder.setPositiveButton("ok", new DialogInterface.OnClickListener() {
			
			@Override
			public void onClick(DialogInterface dialog, int which) {
				dialog.dismiss();
			}
		});
		builder.create().show();
	}
	
	public static String getMac(){
		String mac = shell("cat /sys/class/net/wlan0/address ");

		Context context = Cocos2dxActivity.getContext();
    	
    	if(mac == ""){
    		ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        	boolean result = cm.getNetworkInfo(ConnectivityManager.TYPE_WIFI).getState() == NetworkInfo.State.CONNECTED ? true : false ;
        	if(result){
        		 WifiManager wifiManager = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);   
    	        if (!wifiManager.isWifiEnabled()) {   
    	        	wifiManager.setWifiEnabled(true);    
    	        }   
    	        WifiInfo wifiInfo = wifiManager.getConnectionInfo();       
    	        mac = wifiInfo.getMacAddress();
        	}
    	}
    	
		return md5(mac);
	}
	
	public static String shell(String v){
		try {
			Process pp = Runtime.getRuntime().exec(v);
			InputStreamReader ir = new InputStreamReader(pp.getInputStream());
			LineNumberReader input = new LineNumberReader(ir);

			String result = "";
			while (true){
				String str = input.readLine();
				if (str == null) {
					return result;
				}else{
					 result += str.trim();// 去空格
				}
			}
		} catch (Exception ex) {
		}
		
		return "";
	}
	
	public static String md5(String string) {  
	    byte[] hash;  
	  
	    try {  
	        hash = MessageDigest.getInstance("MD5").digest(string.getBytes("UTF-8"));  
	    } catch (NoSuchAlgorithmException e) {  
	        e.printStackTrace();  
	        return null;  
	    } catch (Exception e) {  
	        e.printStackTrace();  
	        return null;  
	    }  
	  
	    StringBuilder hex = new StringBuilder(hash.length * 2);  
	    for (byte b : hash) {  
	        if ((b & 0xFF) < 0x10)  
	            hex.append("0");  
	        hex.append(Integer.toHexString(b & 0xFF));  
	    }  
	  
	    return hex.toString();  
	}  
	
	public static String keyHash(){
		try {
			Context context = Cocos2dxActivity.getContext();
			PackageInfo info = context.getPackageManager().getPackageInfo(
					context.getPackageName(), 
			PackageManager.GET_SIGNATURES);
			for (Signature signature : info.signatures) {
				MessageDigest md = MessageDigest.getInstance("SHA");
				md.update(signature.toByteArray());
				String key = Base64.encodeToString(md.digest(), Base64.DEFAULT);
				return key;
			}
		} catch (NameNotFoundException e) {
		} catch (NoSuchAlgorithmException e) {
		}
		
		return "";
	}
	
	public static void testKeyHash()
	{
		String key = keyHash();
		Log.e("keyhash", key);
		msg(key);
	}
	
	public static void restart()
	{
		Cocos2dxActivity active = DownloadApk.context;
		ActivityManager manager = (ActivityManager)active.getSystemService(Context.ACTIVITY_SERVICE);  
		String packageName = active.getPackageName();
		manager.restartPackage(packageName);
	}
	
	/**
	 * 获取配置文件数据
	 * @param key
	 * @return
	 */
	public static String getMetaData(String key){
		Context context = Cocos2dxActivity.getContext();
	   	String msg = "";
		try {
			ApplicationInfo info = context.getPackageManager().getApplicationInfo(context.getPackageName(), PackageManager.GET_META_DATA);
			msg = info.metaData.getString(key);
			
		} catch (NameNotFoundException e) {
			e.printStackTrace();
		}
	   	
	   	return msg;
	}
	
	/**
	 * 读取存在本地数据
	 * @param name
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@SuppressLint("WorldReadableFiles")
	public static String load(String name){
		Context context = Cocos2dxActivity.getContext();
        SharedPreferences read = context.getSharedPreferences("jyx_save", Context.MODE_WORLD_READABLE);
        //步骤2：获取文件中的值
        String value = read.getString(name, "");
        
        return value;
	}
	
	/**
	 * 保存数据在本地
	 * @param name
	 * @param value
	 * @return
	 */
	@SuppressWarnings("deprecation")
	@SuppressLint("WorldWriteableFiles")
	public static boolean save(String name, String value){
		Context context = Cocos2dxActivity.getContext();
		SharedPreferences.Editor editor = context.getSharedPreferences("jyx_save", Context.MODE_WORLD_WRITEABLE).edit();
        //步骤2-2：将获取过来的值放入文件
        editor.putString(name, value);
        //步骤3：提交
        return editor.commit();
	}
}
