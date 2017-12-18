package com.jyx;

import java.util.Date;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.DialogInterface;
import android.content.Intent;
import android.util.Log;

import cn.jpush.android.api.JPushInterface;

import com.facebook.CallbackManager;
import com.facebook.FacebookSdk;
import com.snowfish.cn.ganga.helper.SFOnlineApplication;
import com.snowfish.cn.ganga.helper.SFOnlineExitListener;
import com.snowfish.cn.ganga.helper.SFOnlineHelper;
import com.snowfish.cn.ganga.helper.SFOnlineLoginListener;
import com.snowfish.cn.ganga.helper.SFOnlinePayResultListener;
import com.snowfish.cn.ganga.helper.SFOnlineUser;

/**
 * @author lyt
 *
 */
public class SDK extends SDKBase {
	private static final String LOG = "com.jyx.SDK";	
	
	public static final String SDK_VER = "";
	
	private static SDK instance = null;
	
	public static String FB_ID = "1827922904121200";

	private CallbackManager callbackManager;// facebook 回调
	
	private double skuPrice = 0; // 支付道具价格
	
	private String url = "http://g1-new-yhbz.awwgc.com:8080/ws/yjsdkPay"; // 充值回调地址
	
	private String userId = null;
	private int loginRhand = 0;
	
	private String plName = "error";
	private boolean autoName = false; // 自动生成支付名字
	
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
		
		SFOnlineHelper.onCreate(context);
		SFOnlineHelper.setLoginListener(context, new SFOnlineLoginListener() {
			@Override
			public void onLogout(Object arg0) {
				backGame();
				relogin();
			}
			
			@Override
			public void onLoginSuccess(SFOnlineUser user, Object arg1) {
				backGame();
				JSONArray arr = new JSONArray();
				String uid = user.getChannelUserId();
				Log.e(LOG, "登录成功：" + uid);
				uid = uid.replaceAll("[_-`~!@#$%^&*()+=|{}':;',\\[\\].<>/?~！@#￥%……&*（）——+|{}【】‘；：”“’。，、？]", "A");
				uid = plName + uid;
				userId = uid;
				
				if(userId == "" || userId == "0"  || loginRhand == 0)
				{
					Log.e(LOG, "退出登录界面");
					relogin();
					return;
				}
				userId = "";
				
				arr.put(uid);
				callBack(loginRhand, arr.toString());
				loginRhand = 0;
				Log.e(LOG, "回调用游戏");
			}
			
			@Override
			public void onLoginFailed(String arg0, Object arg1) {
				backGame();
				relogin();
			}
		});

		plName = Liblyt.getMetaData("JPUSH_CHANNEL");
		String key1 = Liblyt.getMetaData("JPUSH_APPKEY");
		String key2 = Liblyt.getMetaData("JPUSH_PRIKEY").toLowerCase();
		String key3 = Liblyt.md5(plName + key1 + context.getPackageName()).toLowerCase();
		if(!key2.equals(key3)){
			Liblyt.msg("平台参数不正确!");
			plName = "error";
		}
		Log.e(LOG, plName);
		
		String payName = Liblyt.getMetaData("PAY_NAME");
		if(payName == "1")
		{
			autoName = true;
		}
	}
	
	/**
	 * @param rhand
	 */
	public String platformName(){
		return plName;
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
		if(this.userId != ""){
			JSONArray arr = new JSONArray();
			arr.put(this.userId);
			callBack(rhand, arr.toString());
			this.userId = "";

			Log.e(LOG, "已经登录，直接进入游戏");
			return;
		}
		
		loginRhand = rhand;
		SFOnlineHelper.login(context, "Login");
	}
	

	public void loginComplete(final JSONObject args, final int rhand){
		super.loginComplete(args, rhand);
		String roleId = "";
		String roleName = "";
		String roleLevel = "";
		String zoneId = "";
		String zoneName = "";
		try {
			roleId = args.getString("uid");
			roleName = args.getString("name");
			roleLevel = args.getString("level");
			zoneId = args.getString("sid");
			zoneName = args.getString("sname");
		} catch (JSONException e) {
			Log.e(LOG, e.getMessage());
		}
		SFOnlineHelper.setRoleData(context, roleId, roleName, roleLevel, zoneId, zoneName);
		
		JSONObject roleInfo = new JSONObject();
		try {
			roleInfo.put("roleId", roleId);
			roleInfo.put("roleName", roleName);  //当前登录的玩家角色名，不能为空，不能为null
			roleInfo.put("roleLevel", roleLevel);   //当前登录的玩家角色等级，必须为数字，且不能为0，若无，传入1
			roleInfo.put("zoneId", zoneId);       //当前登录的游戏区服ID，必须为数字，且不能为0，若无，传入1
			roleInfo.put("zoneName", zoneName);//当前登录的游戏区服名称，不能为空，不能为null
			roleInfo.put("balance", "0");   //用户游戏币余额，必须为数字，若无，传入0
			roleInfo.put("vip", "1");            //当前用户VIP等级，必须为数字，若无，传入1
			roleInfo.put("partyName", "无帮派");//当前角色所属帮派，不能为空，不能为null，若无，传入“无帮派”
			roleInfo.put("roleCTime", (int)(System.currentTimeMillis() / 1000) + "");       //单位为秒，创建角色的时间
			roleInfo.put("roleLevelMTime", (int)(System.currentTimeMillis() / 1000) + "");    //单位为秒，角色等级变化时间
		} catch (JSONException e) {
			e.printStackTrace();
		}

//		创建新角色时调用
		SFOnlineHelper.setData(context,"createrole",roleInfo.toString());
//		玩家升级角色时调用
		SFOnlineHelper.setData(context,"levelup",roleInfo.toString());
//		选择服务器进入时调用
		SFOnlineHelper.setData(context,"enterServer",roleInfo.toString());
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
		SFOnlineHelper.logout(context, "LoginOut");
	}
	
	public void post(final JSONObject args, final int rhand){
		FBInvite.login();
	}
	
	@SuppressLint("DefaultLocale")
	public void pay(final JSONObject args,final int rhand){
		try {
			JSONObject payItem = args.getJSONObject("item");
//			String iap = payItem.getString("iap");
			
			final String sid = args.getString("sid");
			final String uid = args.getString("uid");
			final String payType = payItem.getString("payType");
			final String itemId = payItem.getString("id");
			final String price = payItem.getString("price");
			skuPrice = payItem.getDouble("price");
			int rnd = (int)(new Date().getTime() / 1000);
			final String param =  String.format("%s_%s_%s_%s_%s_%s_%d", sid, uid, payType,itemId, price, plName, rnd);
			
			String itemName = "";
			if(!autoName && payItem.has("name")){
				itemName = payItem.getString("name");
			}
			
			if(autoName || itemName.equals("")){
				if("1".equals(itemId)){
					itemName = "钻石x700";
				}else if("2".equals(itemId)){
					itemName = "钻石x1600";
				}else if("3".equals(itemId)){
					itemName = "钻石x3400";
				}else if("4".equals(itemId)){
					itemName = "钻石x9000";
				}else if("5".equals(itemId)){
					itemName = "钻石x21000";
				}else if("7".equals(itemId)){
					itemName = "钻石x100";
				}
			}

			SFOnlineHelper.pay(context, (int)(skuPrice), itemName, 1, param, url, new SFOnlinePayResultListener() {
				
				@Override
				public void onSuccess(String arg0) {
					backGame();
					paySuccess();
				}
				
				@Override
				public void onOderNo(String arg0) {
				}
				
				@Override
				public void onFailed(String arg0) {
					backGame();
					payFail();
				}
			});

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @param rhand
	 */
	public void exit(final JSONObject args,final int rhand){
		SFOnlineHelper.exit(context, new SFOnlineExitListener() {
			/* onSDKExit
			* @description　当SDK有退出方法及界面，回调该函数
			* @param bool SDK是否退出标志位
			*/
			@Override
			public void onSDKExit(boolean bool) {
				if (bool){
					if(context != null){
						context.finish();
						context = null;
					}
					System.exit(0);
				}
			}
			
			/* onNoExiterProvide
			* @description　SDK没有退出方法及界面，回调该函数，可在此使用游戏
			退出界面
			*/
			@Override
			public void onNoExiterProvide() {
				AlertDialog.Builder builder = new Builder(context);
				builder.setTitle("你是否退出游戏");
				builder.setNegativeButton("取消", new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialog, int which) {
					}
				});
				
				builder.setPositiveButton("退出",
						new DialogInterface.OnClickListener() {
					@Override
					public void onClick(DialogInterface dialog, int which) {
						context.finish();
						System.exit(0);
					}
				});
				builder.show();
			}
		});
	}

	public void onResume(){
		FBInvite.onResume();
		SFOnlineHelper.onResume(context);
	}

	public void onPause(){
		FBInvite.onPause();
		SFOnlineHelper.onPause(context);
	}
	
	public void onDestroy(){
		SFOnlineHelper.onDestroy(context);
	}
	
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		callbackManager.onActivityResult(requestCode, resultCode, data);
	}
	
	public void onStart(){
	}
	
	public void onStop(){
		SFOnlineHelper.onStop(context);
	}
	
	public void onRestart(){
		SFOnlineHelper.onRestart(context);
	}
}
