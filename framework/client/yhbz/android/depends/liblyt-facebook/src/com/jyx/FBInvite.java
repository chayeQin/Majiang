package com.jyx;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Currency;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.app.Activity;
import android.os.Bundle;
import android.util.Log;

import com.facebook.AccessToken;
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.GraphRequest;
import com.facebook.GraphResponse;
import com.facebook.HttpMethod;
import com.facebook.appevents.AppEventsConstants;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.login.LoginManager;
import com.facebook.login.LoginResult;
import com.morefun.facebookInvite.FaceBook_InviteLib;
import com.morefun.facebookInvite.onFaceBookInvite;
import com.morefun.facebookInvite.onListFriends;

/**
 * 邀请
 * @author lyt
 *
 */
public class FBInvite extends LuaFunc {
	private CallbackManager callbackManager = null;
	
	public static final int TYPE_FRIENDS = 1; // 未登陆时,回调类型,获取 好友
	public static final int TYPE_INVITE = 2; // 邀请好友
	public static final int TYPE_GET_INVITE = 3; // 获取被邀请的好友ID
	
	public FBInvite(CallbackManager callbackManager){
		this.callbackManager = callbackManager;
	}
	
	/**
	 * 检查登陆
	 * @return
	 */
	public boolean isLogin(){
		AccessToken token = AccessToken.getCurrentAccessToken();
		return token != null && !token.isExpired();
	}
	
	public void fbLogin(final int type,final JSONObject args, final int rhand)
	{
		//fb 登陆 
		LoginManager.getInstance().logInWithReadPermissions(
				(Cocos2dxActivity)Cocos2dxActivity.getContext(),
				Arrays.asList("public_profile", "user_friends")); // ,"email"
		
		LoginManager.getInstance().registerCallback(callbackManager,
		new FacebookCallback<LoginResult>() {
			@Override
			public void onCancel() {
				Log.e("FB Login Cancle", "");
			}

			@Override
			public void onError(FacebookException arg0) {
				Log.e("facebook Error", arg0 + ",");
			}

			@Override
			public void onSuccess(final LoginResult loginResult) {// facebook授权获取facebookUserId
				if(type == TYPE_FRIENDS){ // 获取好友
					friends(args, rhand);
				}
				else if(type == TYPE_INVITE){ // 邀请
					invite(args, rhand);
				}
				else if(type == TYPE_GET_INVITE){
					getInviteFrom(args, rhand);
				}
			}
		});
	}
	
	/**
	 * 获取好友聊表
	 * @param args
	 * @param rhand
	 */
	public void friends(final JSONObject args, final int rhand){
		if(!isLogin()){
			fbLogin(TYPE_FRIENDS, args, rhand);
			return;
		}
		FaceBook_InviteLib.FacebookFriendsList((Activity) Cocos2dxActivity.getContext(), callbackManager, new onListFriends() {
			@Override
			public void listFriendsCall(String arg0) {
				JSONArray arr = new JSONArray();
				try {
					JSONObject obj = new JSONObject(arg0);
					obj = obj.getJSONObject("friends");
					JSONArray list = obj.getJSONArray("friendsh");
					for(int i = list.length() - 1; i >=0 ; i--){
						JSONObject item1 = list.getJSONObject(i);
						JSONObject item2 = new JSONObject();
						item2.put("id", item1.getString("id"));
						item2.put("name", item1.getString("name"));
						item2.put("picture", item1.getJSONObject("picture").getJSONObject("data").getString("url"));
						
						arr.put(item2);
					}
				} catch (JSONException e) {
					e.printStackTrace();
				}
				callBack(rhand, arr);
			}
		});
	}
	
	/**
	 * 邀请
	 * @param args
	 * @param rhand
	 */
	public void invite(final JSONObject args, final int rhand)
	{
		if(!isLogin()){
			fbLogin(TYPE_INVITE, args, rhand);
			return;
		}

		JSONArray jsonArr = null;
		try {
			jsonArr = args.getJSONArray("friends");
		} catch (JSONException e1) {
			jsonArr = new JSONArray();
		}
		try {
			String title = args.getString("title");
			String msg = args.getString("msg");
			ArrayList<String> list = new ArrayList<String>();
			for(int i = jsonArr.length() - 1; i>=0; i--){
				String uid = jsonArr.getString(i);
				if(uid != null && uid != ""){
					list.add(uid);
				}
			}
			FaceBook_InviteLib.FaceBookInvite((Activity) Cocos2dxActivity.getContext(), msg, title, list, callbackManager, new onFaceBookInvite() {
				@Override
				public void facebookInviteCallback(String arg0) {
					JSONArray arr = null;
					try {
						JSONObject obj = new JSONObject(arg0);
						String str = obj.getString("invite_friends");
						arr = new JSONArray(str);
    					} catch (JSONException e) {
						e.printStackTrace();
					}
					if(arr == null){
						arr = new JSONArray();
					}
					callBack(rhand, arr);
				}
			});
		} catch (JSONException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取被谁邀请者ID
	 * https://developers.facebook.com/docs/graph-api/reference/user/apprequests/
	 * https://graph.facebook.com/me/apprequests?access_token=xxxx 接口
	 * 返回数据:https://developers.facebook.com/docs/graph-api/reference/app-request/
	 * @param args
	 * @param rhand
	 */
	public void getInviteFrom(final JSONObject args, final int rhand)
	{
		if(!isLogin()){
			fbLogin(TYPE_GET_INVITE, args, rhand);
			return;
		}
		Bundle parameters = new Bundle();
		GraphRequest request = new GraphRequest(AccessToken.getCurrentAccessToken(), "/me/apprequests", parameters, HttpMethod.GET, new GraphRequest.Callback() {
			
			@Override
			public void onCompleted(GraphResponse arg0) {
				try {
					JSONObject obj = arg0.getJSONObject();
					JSONArray arr = obj.getJSONArray("data");
					JSONObject item = arr.getJSONObject(0);
					JSONObject human = item.getJSONObject("from");
					getMeInviteFrom(human, rhand);
				} catch (JSONException e) {
					e.printStackTrace();
					callBack(rhand, "");
				}
			}
		});
		request.executeAsync();
	}
	
	/**
	 * 获取 自己信息
	 * @param uid 发起邀请人的ID
	 * @param rhand
	 */
	private void getMeInviteFrom(final JSONObject from, final int rhand)
	{
		GraphRequest request = GraphRequest.newMeRequest(AccessToken.getCurrentAccessToken(), new GraphRequest.GraphJSONObjectCallback() {
			@Override
			public void onCompleted(JSONObject arg0, GraphResponse arg1) {
				String result = "";
				try {
					JSONObject obj = new JSONObject();
					obj.put("fromId", from.getString("id"));
					obj.put("fromName", from.getString("name"));
					obj.put("uid", arg0.getString("id"));
					obj.put("name", arg0.getString("name"));
					obj.put("picture", arg0.getJSONObject("picture").getJSONObject("data").getString("url"));
					result = obj.toString();
				} catch (JSONException e) {
					e.printStackTrace();
				}
				callBack(rhand, result);
			}
		});
		Bundle parameters = new Bundle();
		parameters.putString("fields","id,name,picture.width(100).height(100)");
		request.setParameters(parameters);
		request.executeAsync();
	}
	
	/**
	 * 获取自己信息
	 * @param args
	 * @param rhand
	 */
	public void getMe(final JSONObject args, final int rhand)
	{
		if(!isLogin()){
			fbLogin(TYPE_GET_INVITE, args, rhand);
			return;
		}
		
		GraphRequest request = GraphRequest.newMeRequest(AccessToken.getCurrentAccessToken(), new GraphRequest.GraphJSONObjectCallback() {
			@Override
			public void onCompleted(JSONObject arg0, GraphResponse arg1) {
				String result = "";
				try {
					JSONObject obj = new JSONObject();
					obj.put("uid", arg0.getString("id"));
					obj.put("name", arg0.getString("name"));
					obj.put("picture", arg0.getJSONObject("picture").getJSONObject("data").getString("url"));
					result = obj.toString();
				} catch (JSONException e) {
					e.printStackTrace();
				}
				callBack(rhand, result);
			}
		});
		Bundle parameters = new Bundle();
		parameters.putString("fields","id,name,picture.width(100).height(100)");
		request.setParameters(parameters);
		request.executeAsync();
	}
	
	public static String FB_ID = "";
	
	// 正常启动
	public static void startUp(String fbId)
	{
		FB_ID = fbId;
		AppEventsLogger.newLogger(context, FB_ID).logEvent("startup");
	}

	// 注册统计
	public static void newUser()
	{
		AppEventsLogger.newLogger(context, FB_ID).logEvent(AppEventsConstants.EVENT_NAME_COMPLETED_REGISTRATION);
	}

	// 新手教程
	public static void guideEnd()
	{
		AppEventsLogger.newLogger(context, FB_ID).logEvent(AppEventsConstants.EVENT_NAME_COMPLETED_TUTORIAL);
	}

	// 登陆
	public static void login()
	{
		AppEventsLogger.newLogger(context, FB_ID).logEvent("Login");
	}

	// 支付成功
	public static void paySuccess(double price, String currency)
	{
		AppEventsLogger.newLogger(context, FB_ID).logPurchase(BigDecimal.valueOf(price), Currency.getInstance(currency));
	}

	// 支付失败
	public static void payFail()
	{
		AppEventsLogger.newLogger(context, FB_ID).logEvent("Purchase Fail");
	}
	
	public static void CGStart(){
		AppEventsLogger.newLogger(context, FB_ID).logEvent("CGStart");
	}
	
	public static void CGSkip(){
		AppEventsLogger.newLogger(context, FB_ID).logEvent("CGSkip");
	}
	
	public static void CGComlete(){
		AppEventsLogger.newLogger(context, FB_ID).logEvent("CGComlete");
	}
	
	public static void FlagSelect(){
		AppEventsLogger.newLogger(context, FB_ID).logEvent("FlagSelect");
	}
	
	public static void FirstTask(){
		AppEventsLogger.newLogger(context, FB_ID).logEvent("FirstTask");
	}
	
	public static void Fort(final int level){
		AppEventsLogger.newLogger(context, FB_ID).logEvent("Fort" + level);
	}
	
	@SuppressWarnings("deprecation")
	public static void onResume()
	{
		AppEventsLogger.activateApp(context, FB_ID); // facebook统计
		AppEventsLogger.newLogger(context, FB_ID).logEvent(AppEventsConstants.EVENT_NAME_ACTIVATED_APP);
	}
	
	@SuppressWarnings("deprecation")
	public static void onPause()
	{
		AppEventsLogger.deactivateApp(context, FB_ID); // facebook统计
	}
}
