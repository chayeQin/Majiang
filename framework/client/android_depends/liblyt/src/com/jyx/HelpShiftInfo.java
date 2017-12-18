package com.jyx;

import org.json.JSONObject;

/**
 * 帮助
 * @author lyt
 *
 */
public class HelpShiftInfo extends LuaFunc {
	
	/**
	 * 初始化
	 * @param apiKey
	 * @param domain
	 * @param appId
	 */
	public HelpShiftInfo(String apiKey, String domain, String appId)
	{
//		Core.init(Support.getInstance());
//		Core.install(context.getApplication(), apiKey, domain, appId);
	}
	
	/**
	 * 显示客服
	 * @param args
	 * @param rhand
	 */
	public void showConversation(final JSONObject args, final int rhand){
//		Support.showConversation(context);
	}
	
	public void showFAQs(final JSONObject args, final int rhand){
//		Support.showFAQs(context);
	}
	
	public void showFAQSection(final JSONObject args, final int rhand){
//		String sectionPublishId = "";
//		try {
//			sectionPublishId = args.getString("id");
//		} catch (JSONException e) {
//			e.printStackTrace();
//		}
//		Support.showFAQSection(context, sectionPublishId);
	}
	
	public void showSingleFAQ(final JSONObject args, final int rhand){
//		String questionPublishId = "";
//		try {
//			questionPublishId = args.getString("id");
//		} catch (JSONException e) {
//			e.printStackTrace();
//		}
//		Support.showSingleFAQ(context, questionPublishId);
	}
	
	public void setLanguage(final JSONObject args, final int rhand){
//		String lang = "";
//		try {
//			lang = args.getString("lang");
//		} catch (JSONException e) {
//			e.printStackTrace();
//		}
//		Support.setSDKLanguage(lang);
	}
}
