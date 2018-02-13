package com.langqigame;

import android.app.Activity;

import com.iapppay.interfaces.callback.IPayResultCallback;
import com.iapppay.sdk.main.IAppPay;
import com.iapppay.sdk.main.IAppPayOrderUtils;

/**
 * 爱贝接口工具类
 * @author lyt
 *
 */
public class AibeiUtil {
	private static String appId = ""; // 应用ID
	private static String priceKey = ""; // 私钥
	private static String publicKey = ""; // 公钥匙
	private static Activity context = null;
	private static IAibeiCallback payHandler = null;
	
    /**
     * 支付结果回调
     */
    private static IPayResultCallback iPayResultCallback = new IPayResultCallback() {
        @Override
        public void onPayResult(int resultCode, String signvalue, String resultInfo) {
            switch (resultCode) {
                case IAppPay.PAY_SUCCESS:
            		boolean payState = IAppPayOrderUtils.checkPayResult(signvalue, publicKey);
                    if(payState){
                    	payHandler.payRhand();
                    	return;
                    }
                	break;
                default:
                    break;
            }
            
            payHandler.payFhand();// 注意上面return了
        }
    };
	
	public static void init(Activity mContext,boolean isPortrait, String mAppid, String mPriceKey, String mPublicKey, IAibeiCallback mPayHandler)
	{
		context = mContext;
		appId = mAppid;
		priceKey = mPriceKey;
		publicKey = mPublicKey;
		payHandler = mPayHandler;
		int portrait = IAppPay.LANDSCAPE;
		if (isPortrait){
			portrait = IAppPay.PORTRAIT;
		}
		
		IAppPay.init(context, portrait, appId);
	}
	
	/**
	 * 充值
	 * @param uid 角色ID
	 * @param waresid 爱贝的道具ID
	 * @param itemName 道具名字
	 * @param param 自定义参数
	 * @param price 价格(元)
	 * @param cpOrderId 订单号(最大64位)
	 */
	public static void pay(final String uid, final int waresid, final String itemName, final String param, final float price, final String cpOrderId){
		String param2 = getTransdata(uid, param, waresid, itemName, price, cpOrderId);
		IAppPay.startPay(context, param2, iPayResultCallback);
	}
	
    /** 获取收银台参数 */
    private static String getTransdata(String uid, String info, int waresId, String itemName, float price, String cpOrderId) {
        //调用 IAppPayOrderUtils getTransdata() 获取支付参数
        IAppPayOrderUtils orderUtils = new IAppPayOrderUtils();
        orderUtils.setAppid(appId);
        orderUtils.setWaresid(waresId);//传入您商户后台创建的商品编号
        orderUtils.setCporderid(cpOrderId);
        orderUtils.setAppuserid(uid);
        orderUtils.setPrice(price);//单位 元
        orderUtils.setWaresname(itemName);//开放价格名称(用户可自定义，如果不传以后台配置为准)
        orderUtils.setCpprivateinfo(info);
        return orderUtils.getTransdata(priceKey);
    }
}
