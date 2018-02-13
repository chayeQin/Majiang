package com;

import java.util.HashMap;
import java.util.Map;

import android.app.Activity;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.util.Log;
import android.widget.Toast;

import com.google.billing.utils.GooglePayHandler;
import com.google.billing.utils.IabHelper;
import com.google.billing.utils.IabHelper.IabAsyncInProgressException;
import com.google.billing.utils.IabResult;
import com.google.billing.utils.Inventory;
import com.google.billing.utils.Purchase;
import com.jyx.HttpUtil;
import com.jyx.HttpUtilCallback;

/**
 * Google pay SDK 集合
 * @author lyt
 *
 */
public class GooglePayUtil {
	private static final String LOG = "GooglePayUtil";
	private static final String SAVE_KEY = "Google_Pay_SKU_PARAM"; // 保存本地数据使用KEY
	public static GooglePayUtil instance = null;
	public static GooglePayUtil getInstance(){
		if(instance == null){
			instance = new GooglePayUtil();
		}
		
		return instance;
	}
	
	private IabHelper mHelper = null;
	private String base64EncodedPublicKey = null; // 验证BASE64
	private String postUrl = null;// 充值服务器地址
	private final int RC_REQUEST = 10001;
	private boolean isGoogleIniting = true;
	private boolean isGooglePaying = false;
	private int tryCount = 0;
	private ProgressDialog loading = null;
	
	private Activity context = null; 
	private GooglePayHandler callback = null;
	
	IabHelper.OnIabPurchaseFinishedListener mPurchaseFinishedListener = new IabHelper.OnIabPurchaseFinishedListener() {
		public void onIabPurchaseFinished(IabResult result, Purchase purchase) {
			Log.d(LOG, "Purchase finished: " + result + ", purchase: " + purchase);
			if (result.toString().contains("Item Already Owned")) {
				Log.d(LOG, "Purchase finished: not find Item Already Owned");
				callFail();
				isGooglePaying = false;
				return;
			}
			if (result.isFailure()) {
				Log.d(LOG, "Purchase finished: isFailure");
				callFail();
				isGooglePaying = false;
				return;
			}
			Log.d(LOG, "Purchase successful.");
			if (result.isSuccess()) {
				dealPaySuccess(purchase);
			}else{
				isGooglePaying = false;
			}
		}
	};
	
	private IabHelper.OnConsumeFinishedListener mConsumeFinishedListener = new IabHelper.OnConsumeFinishedListener() {
		public void onConsumeFinished(Purchase purchase, IabResult result) {
			Log.d(LOG, "Consumption finished. Purchase: " + purchase + ", result: " + result);
			// 使用成功不理
			hideLoading();
		}
	};
	
	private IabHelper.QueryInventoryFinishedListener mGotInventoryListener = new IabHelper.QueryInventoryFinishedListener() {
		public void onQueryInventoryFinished(IabResult result,
				Inventory inventory) {
			Log.d(LOG, "QueryInventory. result: " + result);
			hideLoading();
			if(inventory == null){
				Log.d(LOG, "QueryInventory. inventory is null");
				isGooglePaying = false;
				return;
			}
			
			String sku = getSku();
			if(sku != "" && inventory.hasPurchase(sku)){
				Purchase gasPurchase = inventory.getPurchase(sku);// sku 商品id
				dealPaySuccess(gasPurchase);
			}else{
				try {
					mHelper.launchPurchaseFlow(context, sku, RC_REQUEST, mPurchaseFinishedListener);
				} catch (IabAsyncInProgressException e) {
					Log.e(LOG, "launchPurchaseFlow:" + e.getMessage());
					isGooglePaying = false;
				}
			}
		}
	};
	
	/**
	 * 初始化SDK
	 * @param context
	 * @param url 上传充值结果地址
	 * @param base64EncodedPublicKey
	 * @param callback
	 */
	public void init(Activity context, String url, String base64EncodedPublicKey, GooglePayHandler callback)
	{
		this.context = context;
		this.base64EncodedPublicKey = base64EncodedPublicKey;
		this.callback = callback;
		this.setPayUrl(url);
		
		mHelper = new IabHelper(context, base64EncodedPublicKey);
		mHelper.enableDebugLogging(false);
		
		mHelper.startSetup(new IabHelper.OnIabSetupFinishedListener() {
			public void onIabSetupFinished(IabResult result) {
				Log.d(LOG, "Setup finished.");
				if (!result.isSuccess()) {
					Log.d(LOG, "Setup fail.");
					return;
				}
				isGoogleIniting = false;
				Log.d(LOG, "Setup successful. Querying inventory.");
			}
		});
	}
	
	public void setPayUrl(String url)
	{
		if(url.substring(url.length() - 1) != "/"){
			url += "/";
		}
		this.postUrl = url;
	}
	
	public String getPayUrl()
	{
		return this.postUrl;
	}
	
	public SharedPreferences getShare(){
		return context.getSharedPreferences(SAVE_KEY, Context.MODE_PRIVATE);
	}
	
	public void setSkuParam(String sku,String param){
        Editor editor = getShare().edit();

        editor.putString("sku", sku);
        editor.putString("param", param);
        editor.commit();
	}
	
	public String getSku(){
		SharedPreferences sp = getShare();
		if(sp.contains("sku")){
        	return sp.getString("sku", "");
        }
		
		return "";
	}
	
	public String getParam(){
		SharedPreferences sp = getShare();
		if(sp.contains("param")){
        	return sp.getString("param", "");
        }
		
		return "";
	}
	
	public void pay(String sku, String param){
		if(isGoogleIniting)
		{
			Toast.makeText(context, "google pay initing ...",Toast.LENGTH_SHORT).show();
			return;
		}
		if(isGooglePaying){
			Toast.makeText(context, "google paying ...",Toast.LENGTH_SHORT).show();
			return;
		}
		isGooglePaying = true;
		
		this.setSkuParam(sku, param);
		
		try {
			showLoading();
			tryCount = 3;
			mHelper.queryInventoryAsync(mGotInventoryListener);
		} catch (IabAsyncInProgressException e) {
			Log.e(LOG, "queryInventoryAsync : " + e.getMessage());
			hideLoading();
			
			try {
				mHelper.launchPurchaseFlow(context, sku, RC_REQUEST, mPurchaseFinishedListener);
			} catch (IabAsyncInProgressException e1) {
				Log.e(LOG, "launchPurchaseFlow : " + e.getMessage());
				isGooglePaying = false;
			}
		}
	}

	private void dealPaySuccess(final Purchase purchase) {
		/**
		 * google支付成功后处理数据逻辑
		 */
		Map<String, String> params = new HashMap<String, String>();
		params.put("orderId", purchase.getOrderId());
		params.put("package_name", purchase.getPackageName());
		params.put("productId", purchase.getSku());
		params.put("purchaseToken", purchase.getToken());
		params.put("purchaseData", purchase.getOriginalJson());
		params.put("dataSignature", purchase.getSignature());
		params.put("base64", base64EncodedPublicKey);
		
		params.put("developerPayload", getParam());

		String url = postUrl + "googlePay";
		Log.e(LOG, url);
		showLoading();
		
		HttpUtil.post(url, params, new HttpUtilCallback() {
			@Override
			public void call(String str) {
				final boolean isOk = "ok".equals(str);

				context.runOnUiThread(new Runnable() {
					@Override
					public void run() {
						hideLoading();
						isGooglePaying = false;
						
						try {
							showLoading();
							mHelper.consumeAsync(purchase, mConsumeFinishedListener);
						} catch (IabAsyncInProgressException e) {
							Log.e(LOG, "consumeAsync :" + e.getMessage());
						}
						
						if(isOk){
							Log.e(LOG, "验证成功:" + purchase.getSku());
							callback.googlePaySuccess();
						}else{
							Log.e(LOG, "验证失败:" + purchase.getSku());
							if (tryCount > 0){
								tryCount--;
								Log.e(LOG, "正在重试:" + tryCount);
								dealPaySuccess(purchase);
							}else{
								callback.googlePayFail();
							}
						}
					}
				});
			}
		});
	}
	
	private void showLoading(){
		if(loading != null){
			return;
		}
		
		loading = android.app.ProgressDialog.show(context, "", "Loading ...");
	}
	
	private void hideLoading(){
		if(loading == null){
			return;
		}
		
		loading.dismiss();
		loading = null;
	}
	
	private void callFail(){
		context.runOnUiThread(new Runnable() {
			@Override
			public void run() {
				callback.googlePayFail();
			}
		});
	}
	
	public void onDestroy(){
		if (mHelper != null){
			try {
				mHelper.dispose();
			} catch (Exception e) {
				e.printStackTrace();
			}
			mHelper = null;
		}
	}
	
	public void onActivityResult(int requestCode, int resultCode, Intent data) {
		if(!isGoogleIniting && mHelper != null){
			mHelper.handleActivityResult(requestCode, resultCode, data);
		}
	}
}
