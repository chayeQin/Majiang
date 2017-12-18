package com.jyx;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;

import android.app.ActivityManager;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.net.wifi.WifiInfo;
import android.net.wifi.WifiManager;
import android.telephony.TelephonyManager;

/**
 * 获取手机信息
 * @author lyt
 */
public class ApkInfo extends LuaFunc{
	public void mac(final int rhand){
		ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
    	boolean result = cm.getNetworkInfo(ConnectivityManager.TYPE_WIFI).getState() == NetworkInfo.State.CONNECTED ? true : false ;
    	String mac = "";
    	if(result){
    		 WifiManager wifiManager = (WifiManager) context.getSystemService(Context.WIFI_SERVICE);   
	        if (!wifiManager.isWifiEnabled()) {   
	        	wifiManager.setWifiEnabled(true);    
	        }   
	        WifiInfo wifiInfo = wifiManager.getConnectionInfo();       
	        mac = wifiInfo.getMacAddress();
    	}
		Cocos2dxLuaJavaBridge.callLuaFunctionWithString(rhand,mac);
		Cocos2dxLuaJavaBridge.releaseLuaFunction(rhand);
	}
	
	public void ver(final int rhand){
       // 获取packagemanager的实例
       PackageManager packageManager = context.getPackageManager();
       // getPackageName()是你当前类的包名，0代表是获取版本信息
       PackageInfo packInfo;
       String version = "";
		try {
			packInfo = packageManager.getPackageInfo(context.getPackageName(),0);
			version = packInfo.versionName;
		} catch (NameNotFoundException e) {
			e.printStackTrace();
		}

		Cocos2dxLuaJavaBridge.callLuaFunctionWithString(rhand,version);
		Cocos2dxLuaJavaBridge.releaseLuaFunction(rhand);
	}
	
	// 获得可用的内存
    public void memUse(final int rhand) {
		long MEM_UNUSED;
		// 得到ActivityManager
		ActivityManager am = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
		
		// 创建ActivityManager.MemoryInfo对象  
		
		ActivityManager.MemoryInfo mi = new ActivityManager.MemoryInfo();
		am.getMemoryInfo(mi);
		
		// 取得剩余的内存空间 

        MEM_UNUSED = mi.availMem / 1024;
        callBack(rhand, MEM_UNUSED);
    }

    // 获得总内存
    public void memTolal(final int rhand) {
        long mTotal;
        // /proc/meminfo读出的内核信息进行解释
        String path = "/proc/meminfo";
        String content = null;
        BufferedReader br = null;
        try {
            br = new BufferedReader(new FileReader(path), 8);
            String line;
            if ((line = br.readLine()) != null) {
                content = line;
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        // beginIndex
        int begin = content.indexOf(':');
        // endIndex
        int end = content.indexOf('k');
        // 截取字符串信息

        content = content.substring(begin + 1, end).trim();
        mTotal = Integer.parseInt(content);
        callBack(rhand, mTotal);
    }
     
    /**
     * 电话号码,需要权限 
     * <uses-permission android:nameuses-permissionandroid:name="android.permission.READ_PHONE_STATE"/>
     * @param rhand
     */
    public void phone(final int rhand){
		TelephonyManager tm = (TelephonyManager)context.getSystemService(Context.TELEPHONY_SERVICE);  
//		String deviceid = tm.getDeviceId();//获取智能设备唯一编号  
		String te1  = tm.getLine1Number();//获取本机号码  
//		String imei = tm.getSimSerialNumber();//获得SIM卡的序号  
//		String imsi = tm.getSubscriberId();//得到用户Id 
		callBack(rhand, te1);
    }
    
    /**
     * 运营商，0 未知，1移动，2联通，3电信
     * @param rhand
     */
    public void operator(final int rhand){
		TelephonyManager tm = (TelephonyManager)context.getSystemService(Context.TELEPHONY_SERVICE); 
		String operator = tm.getSimOperator();
		int result = 0;
		if(operator == null){
			
		}else if("46000".equals(operator) || "46002".equals(operator) || "46007".equals(operator)){
			result = 1;
		}else if("46001".equals(operator)){
			result = 2;
		}else if("46003".equals(operator)){
			result = 3;
		}
		callBack(rhand, result);
    }
}
