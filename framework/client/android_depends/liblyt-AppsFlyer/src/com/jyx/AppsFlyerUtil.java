package com.jyx;

import java.util.HashMap;
import java.util.Map;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.json.JSONObject;

import com.appsflyer.AFInAppEventParameterName;
import com.appsflyer.AFInAppEventType;
import com.appsflyer.AppsFlyerLib;

public class AppsFlyerUtil {
	public static Cocos2dxActivity context;
	
	public static void init(String key){
		context = (Cocos2dxActivity)Cocos2dxActivity.getContext();
		AppsFlyerLib.getInstance().startTracking(context.getApplication(), key);
	}
	
	public static void startUp(){
		AppsFlyerLib.getInstance().trackEvent(context, "startup", null);
	}
	
	// appsflyer 注册统计接口实现
	public static void newUser(String uid){
		Map<String, Object> eventValue = new HashMap<String, Object>();
		eventValue.put(AFInAppEventParameterName.REGSITRATION_METHOD,"af_complete_registration");
		eventValue.put(AFInAppEventParameterName.CUSTOMER_USER_ID, uid);
		AppsFlyerLib.getInstance().trackEvent(context, AFInAppEventType.COMPLETE_REGISTRATION, eventValue);
	}

	// appsflyer 登录统计接口实现
	public static void login(String uid){
		Map<String, Object> eventValue = new HashMap<String, Object>();
		eventValue.put("AP_LOGIN", "af_login");
		eventValue.put(AFInAppEventParameterName.CUSTOMER_USER_ID, uid);
		AppsFlyerLib.getInstance().trackEvent(Cocos2dxActivity.getContext(), AFInAppEventType.LOGIN, eventValue);
	}
	
	public static void guideEnd(){
		AppsFlyerLib.getInstance().trackEvent(context, AFInAppEventType.TUTORIAL_COMPLETION, null);
	}
	
	public static void loginComplete(){
		AppsFlyerLib.getInstance().trackEvent(context, "loginComplete", null);
	}

	// 更新开始
	public static void updateStart(){
		AppsFlyerLib.getInstance().trackEvent(context, "updateStart", null);
	}

	// 更新完成
	public static void updateComplete(){
		AppsFlyerLib.getInstance().trackEvent(context, "updateComplete", null);
	}
	
	public static void paySuccess(double price, String currency){
		Map<String, Object> eventValue = new HashMap<String, Object>();
		eventValue.put(AFInAppEventParameterName.REVENUE, price);
		eventValue.put(AFInAppEventParameterName.CONTENT_TYPE, "consume");
		eventValue.put(AFInAppEventParameterName.CURRENCY, currency);
		AppsFlyerLib.getInstance().trackEvent(context,
		AFInAppEventType.PURCHASE, eventValue);
	}

	public static void payFail(){
		AppsFlyerLib.getInstance().trackEvent(context, "Purchase Fail", null);
	}

	public static void CGStart(){
		AppsFlyerLib.getInstance().trackEvent(context, "CGStart", null);
	}
	
	public static void CGSkip(){
		AppsFlyerLib.getInstance().trackEvent(context, "CGSkip", null);
	}
	
	public static void CGComlete(){
		AppsFlyerLib.getInstance().trackEvent(context, "CGComlete", null);
	}
	
	public static void FlagSelect(){
		AppsFlyerLib.getInstance().trackEvent(context, "FlagSelect", null);
	}
	
	public static void FirstTask(){
		AppsFlyerLib.getInstance().trackEvent(context, "FirstTask", null);
	}
	
	public static void Fort(final int level){
		AppsFlyerLib.getInstance().trackEvent(context, "Fort" + level, null);
	}
	
	public static void selectLangShow(){
		AppsFlyerLib.getInstance().trackEvent(context, "selectLangShow", null);
	}
	
	public static void selectLangClick(){
		AppsFlyerLib.getInstance().trackEvent(context, "selectLangClick", null);
	}
	
	public static void selectLangClose(){
		AppsFlyerLib.getInstance().trackEvent(context, "selectLangClose", null);
	}
}
