package com.jyx;

import java.util.Arrays;
import java.util.Date;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.json.JSONArray;
import org.json.JSONObject;

import android.annotation.SuppressLint;
import android.content.Intent;
import android.util.Log;

import com.GooglePayUtil;
import com.facebook.AccessToken;
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import com.facebook.appevents.AppEventsConstants;
import com.facebook.appevents.AppEventsLogger;
import com.facebook.login.LoginManager;
import com.facebook.login.LoginResult;
import com.google.billing.utils.GooglePayHandler;

/**
 * @author lyt
 */
public class SDK extends SDKBase {
	private static final String LOG = "com.jyx.SDK";	
	
	public static final String NAME = "enandroid";
	
	public static final String SDK_VER = "";
	
	private static SDK instance = null;
	
	public static String FB_ID = "1406688606069148";

	private CallbackManager callbackManager;// facebook 回调
	
	private double skuPrice = 0; // 支付道具价格
	
//	private String googleKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAk6fQbA97fRZJtdm6CW8u+c7x1NhKL9RwDyzWV6amqFWyRXiFFBYfAYCzO/HJ27j/gzCXdHwq7DX+mBVAZlS7gcW5JevVo5Mged/KLmx10OY0u45n3G6hrgTsSknz8tX9p87FPgrTlQtbL/70Ti9Flr3rTZHBd803GP0EuZJgyMg7rj1+5ksWykFmx0BwXhJodIn71a/OxYaRKKBN33lD9W9K3Y4IS9KikTLttvxGiQYV9lHGxWH7N6GFQ4aOdgA+sTBikAhTEsULYeubqzuwnoUYXEo1oKh/gdOT+hUhxj5YDQLa4gY+EjtkJkgCpPbAhz6r6ZfQh6tsjV2+uwTTTwIDAQAB";// 加入google公钥
	private String googleKey = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAm3z+UZXtWw7b6ZF9uLef+JBPd3Q4lKYYmrxV7NHxhW9/lZwKYKDiHdTeVl2h+zsUCLMu6qI5wPP/y/JmDoeRHkV5Ci0rdhhd+8Fyf0XtZmXcoISGpt5m6Q5IOuh2lZtF62CQRxynNbuw+FHCfUKdmmFvqLYMaY7xOhf6hCK20Pnp2IslgRn4Wpd0GvyE1ja2SgH9t6iLNvlyMmgKODgtuLnCihPaeijRQNayMz4TM2FV1kq/covkvKFobIRh/abudlUnvQEJ+LK21qD/kYzorZIvxkBmUcwO7VTwh/AQyVXuylDquENexab7EVemBW/T6D7qQrxqNKzbLN18219M3QIDAQAB";
	public static SDK getInstance(){
		Log.i(LOG, "sdk init");
		
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
	}
	
	/**
	 * @param rhand
	 */
	public String platformName(){
		String url = "http://192.168.8.30/admin/googlePay";
		GooglePayUtil.getInstance().init(context, url, googleKey, new GooglePayHandler() {
			
			@Override
			public void googlePaySuccess() {
				paySuccess();
			}
			
			@Override
			public void googlePayFail() {
				payFail();
			}
		});
		
		FBInvite.startUp(FB_ID);
        	
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
		DataEyeInfo.paySuccess(skuPrice, "USD");
		FBInvite.paySuccess(skuPrice, "USD");
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
			
			GooglePayUtil.getInstance().pay(iap, param);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @param rhand
	 */
	public void exit(final int rhand){
	}

	@SuppressWarnings("deprecation")
	public void onResume(){
		AppEventsLogger.activateApp(Cocos2dxActivity.getContext(), FB_ID); // facebook统计
		AppEventsLogger.newLogger(Cocos2dxActivity.getContext(), FB_ID).logEvent( // facebook统计
				AppEventsConstants.EVENT_NAME_ACTIVATED_APP);
	}

	@SuppressWarnings("deprecation")
	public void onPause(){
		AppEventsLogger.deactivateApp(Cocos2dxActivity.getContext(), FB_ID); // facebook统计
	}
	
	public void onDestroy(){
		GooglePayUtil.getInstance().onDestroy();
	}
	
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		callbackManager.onActivityResult(requestCode, resultCode, data);
		GooglePayUtil.getInstance().onActivityResult(requestCode, resultCode, data);
	}
	
	public void onStart(){
	}
	
	public void onStop(){
	}
}
