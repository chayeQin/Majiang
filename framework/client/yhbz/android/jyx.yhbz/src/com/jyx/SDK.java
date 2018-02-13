package com.jyx;

import java.util.Arrays;
import java.util.Date;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.json.JSONArray;
import org.json.JSONObject;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.util.Log;

import com.facebook.AccessToken;
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import com.facebook.login.LoginManager;
import com.facebook.login.LoginResult;

/**
 * @author lyt
 *
 */
public class SDK extends SDKBase {
	private static final String LOG = "com.jyx.SDK";	
	
	public static final String NAME = "demo";
	
	public static final String SDK_VER = "";
	
	private static SDK instance = null;
	
	public static String FB_ID = "1827922904121200";

	private CallbackManager callbackManager;// facebook 回调
	
	private double skuPrice = 0; // 支付道具价格
	
	public static SDK getInstance(){
		if(instance == null){
			instance = new SDK();
		}
		return instance;
	}
	
	public SDK(){
		FacebookSdk.sdkInitialize(context.getApplicationContext());
		FacebookSdk.setIsDebugEnabled(false); // 测试模式非测试模式改为false
		callbackManager = CallbackManager.Factory.create();// 在SDK初始化之前创建回调
		
		LuaCall.add(new FBInvite(callbackManager));
		FBInvite.startUp(FB_ID);
	}
	
	/**
	 * @param rhand
	 */
	public String platformName(){
		return NAME;
	}
	
	@Override
	public String getGvoiceId() {
		return "1935585816";
	}

	@Override
	public String getGvoiceKey() {
		return "388c97f1364b2f86712e2e9c2fd38b69";
	}

	public void login(final JSONObject args, final int rhand)
	{
		LoginManager.getInstance().logOut();
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
				AccessToken token = AccessToken.getCurrentAccessToken();
				JSONArray arr = new JSONArray();
				arr.put(token.getUserId());
				callBack(rhand,arr.toString());
			}
		});
	}
	

	public void loginComplete(final JSONObject args, final int rhand){
		super.loginComplete(args, rhand);
	}

	// 更新开始
	public void updateStart(final JSONObject args, final int rhand){
		super.updateStart(args, rhand);
	}

	// 更新完成
	public void updateComplete(final JSONObject args, final int rhand){
		super.updateComplete(args, rhand);
	}
	
	public void newUser(final JSONObject args, final int rhand)
	{
		super.newUser(args, rhand);
		
		FBInvite.newUser();
	}
	
	public void guideEnd(final JSONObject args, final int rhand)
	{
		super.guideEnd(args, rhand);
		
		FBInvite.guideEnd();
	}
	
	/**
	 * 支付成功
	 */
	private void paySuccess(){
		double price = skuPrice / 100.0;
		DataEyeInfo.paySuccess(price, "USD");
		FBInvite.paySuccess(price, "USD");
	}
	
	/**
	 * 支付失败纺计
	 */
	private void payFail(){
		DataEyeInfo.payFail();
		FBInvite.payFail();
	}
	
	public void logout(final JSONObject args, final int rhand){
	}
	
	public void post(final JSONObject args, final int rhand){
		FBInvite.login();
	}
	
	@SuppressLint("DefaultLocale")
	public void pay(final JSONObject args,final int rhand){
		try {
			JSONObject payItem = args.getJSONObject("item");
			String iap = payItem.getString("iap");
			
			final String sid = args.getString("sid");
			final String uid = args.getString("uid");
			final String payType = payItem.getString("payType");
			final String itemId = payItem.getString("id");
			final String price = payItem.getString("price");
			skuPrice = payItem.getDouble("price");
			int rnd = (int)(new Date().getTime() / 1000);
			final String param =  String.format("%s_%s_%s_%s_%s_%s_%d", sid, uid, payType,itemId, price, NAME, rnd);
			
//			GooglePayUtil.getInstance().pay(iap, param);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @param rhand
	 */
	public void exit(final int rhand){
	}

	public void onResume(){
		FBInvite.onResume();
	}

	public void onPause(){
		FBInvite.onPause();
	}
	
	public void onDestroy(){
	}
	
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		callbackManager.onActivityResult(requestCode, resultCode, data);
	}
	
	public void onStart(){
	}
	
	public void onStop(){
	}
}
