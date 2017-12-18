package com.jyx;

import java.util.HashSet;
import java.util.Set;

import org.json.JSONException;
import org.json.JSONObject;

import cn.jpush.android.api.JPushInterface;
import cn.jpush.android.api.TagAliasCallback;

/**
 * Data封装
 * @author lyt
 */
public class DataEyeInfo extends LuaFunc {
	public static long loginTime = 0;
	public static long updateTime = 0;
	
	public DataEyeInfo(){
		super();
	}
	
	/**
	 * 上传数据
	 * @param roleId
	 * @param roleName
	 * @param roleLevel
	 * @param zoneId
	 * @param zoneName
	 */
	public void post(final JSONObject args, final int rhand){
		try {
			String roleId    = args.getString("uid");
//			String roleName  = args.getString("name");
			String roleLevel = args.getString("level");
			String zoneId	 = args.getString("sid");
//			String zoneName  = args.getString("sname");
			
//			UMGameAgent.setPlayerLevel(Integer.parseInt(roleLevel));
//			UMGameAgent.onProfileSignIn(roleId);

			String puid  = args.getString("puid");
			Set<String> tags = new HashSet<String>();
			tags.add(zoneId);
			tags.add(roleId);
			tags.add(puid);
			JPushInterface.setAliasAndTags(context, puid, tags, new TagAliasCallback() {
				@Override
				public void gotResult(int arg0, String arg1, Set<String> arg2) {
				}
			});
			
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		loginTime = getTime();
//		MobclickAgent.onEvent(context, "loginStart");
	}
	
	/**
	 * 更新特级
	 * @param args
	 * @param rhand
	 */
	public void updateLevel(final JSONObject args, final int rhand){
//		try {
//			UMGameAgent.setPlayerLevel(args.getInt("level"));
//		} catch (JSONException e) {
//		}
	}
	
	public static long getTime(){
		return System.currentTimeMillis() / 1000;
	}
	
	// 正常启动
	public static void startUp(){
//		MobclickAgent.onEvent(context, "startup");
	}
	
	// 完成登陆
	public static void loginComplete(){
//	    int dtime = (int)(getTime() - loginTime);
//	    MobclickAgent.onEventValue(context, "loginComplete", null, dtime);
	}

	// 更新开始
	public static void updateStart(String ver){
//	    updateTime = getTime();
//	    MobclickAgent.onEvent(context, "updateStart", ver);
	}

	// 更新完成
	public static void updateComplete(String ver){
//	    int dtime = (int)(getTime() - updateTime);
//	    Map<String, String> data = new HashMap<String, String>();
//	    data.put("ver", ver);
//	    MobclickAgent.onEventValue(context, "updateComplete", data, dtime);
	}

	// appsflyer 注册统计
	public static void newUser(){
//		MobclickAgent.onEvent(context, "newUser");
	}

	// appsflyer 新手统计
	public static void guideEnd(){
//		MobclickAgent.onEvent(context, "guideEnd");
	}

	// 支付成功
	public static void paySuccess(double price, String currency){
//		UMGameAgent.pay(price, 0, 1);
	}

	// 支付失败
	public static void payFail(){
//		MobclickAgent.onEvent(context, "payFail");
	}
}
