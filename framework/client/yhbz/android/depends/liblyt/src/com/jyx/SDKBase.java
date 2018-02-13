package com.jyx;

import java.util.Locale;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxBitmap;
import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.content.pm.PackageManager.NameNotFoundException;
import android.net.Uri;

public class SDKBase extends LuaFunc {
	private String lang = "";
	
	public String platformName(){
		return "sdkbase";
	}
	
	public String getGvoiceId(){
		return "";
	}
	
	public String getGvoiceKey(){
		return "";
	}
	
	/**
	 * @param rhand
	 */
	public void platform(final JSONObject args, final int rhand){
		DataEyeInfo.startUp();
		
		boolean isRTL = false;
		try {
			this.lang = args.getString("lang");
			isRTL = args.getBoolean("isRTL");
		} catch (JSONException e) {
			e.printStackTrace();
		}
		Cocos2dxBitmap.isRTL = isRTL;
		
    	String mac = Liblyt.getMac();
        PackageManager packageManager = context.getPackageManager();       
        PackageInfo packInfo;
        String version = "";
 		try {
 			packInfo = packageManager.getPackageInfo(context.getPackageName(),0);
 			version = packInfo.versionName;
 		} catch (NameNotFoundException e) {
 			e.printStackTrace();
 		}
 		try{
			JSONObject obj = new JSONObject();
			obj.put("name", platformName());
			obj.put("version", version);
			obj.put("mac", mac);
			obj.put("showExit", showExit());
			obj.put("isTw", isTw());
			obj.put("notisGift", 1);
			obj.put("GVoice", "yes");
			
			final String result = obj.toString();
			new UnZipObb(context).unObb(new Runnable() {
				@Override
				public void run() {
					callBack(rhand, result);
				}
			});
 		}catch(Exception e) {
			e.printStackTrace();
 		}
	}
	
	public boolean showExit(){
		return false;
	}
	
	public void setLang(final JSONObject args, final int rhand){
		boolean isRTL = false;
		try {
			this.lang = args.getString("lang");
			isRTL = args.getBoolean("isRTL");
		} catch (JSONException e) {
			e.printStackTrace();
		}
		Cocos2dxBitmap.isRTL = isRTL;
	}
	
	/**
	 * 是否是繁体
	 * @return
	 */
	private int isTw(){
		Locale locale = context.getResources().getConfiguration().locale;
		String lang = locale.getLanguage();
		String country = locale.getCountry();
		
		if("zh".equals(lang))
		{
			if("CN".equals(country)){
				return 0;
			}else{
				return 1;
			}
		}
		
		return 0;
	}

	public void newUser(final JSONObject args, final int rhand){
		DataEyeInfo.newUser();
	}

	public void guideEnd(final JSONObject args, final int rhand){
		DataEyeInfo.guideEnd();
	}
	
	// 登陆完成
	public void loginComplete(final JSONObject args, final int rhand){
		DataEyeInfo.loginComplete();
	}
	
	/**
	 * 获取版本号
	 * @param args
	 * @return
	 */
	private String getVerName(JSONObject args){
		String ver = "";
		String code = "";
		try {
			ver = args.getString("ver");
			code = args.getString("code");
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		return ver + ":" + code;
	}

	// 更新开始
	public void updateStart(final JSONObject args, final int rhand){
		DataEyeInfo.updateStart(getVerName(args));
	}

	// 更新完成
	public void updateComplete(final JSONObject args, final int rhand){
		DataEyeInfo.updateComplete(getVerName(args));
	}
	
	/**
	 * 
	 * @param url
	 * @param rhand
	 */
	public void openUrl(final JSONObject args,final int rhand){
		String url = "";
		try {
			url = args.getString("url");
		} catch (JSONException e) {
			e.printStackTrace();
		}
		Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
		Cocos2dxActivity.getContext().startActivity(browserIntent);
	}
}
