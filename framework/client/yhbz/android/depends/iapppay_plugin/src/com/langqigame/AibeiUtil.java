package com.langqigame;

import android.app.Activity;

import com.iapppay.interfaces.callback.IPayResultCallback;
import com.iapppay.sdk.main.IAppPay;
import com.iapppay.sdk.main.IAppPayOrderUtils;

/**
 * �����ӿڹ�����
 * @author lyt
 *
 */
public class AibeiUtil {
	private static String appId = ""; // Ӧ��ID
	private static String priceKey = ""; // ˽Կ
	private static String publicKey = ""; // ��Կ��
	private static Activity context = null;
	private static IAibeiCallback payHandler = null;
	
    /**
     * ֧������ص�
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
            
            payHandler.payFhand();// ע������return��
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
	 * ��ֵ
	 * @param uid ��ɫID
	 * @param waresid �����ĵ���ID
	 * @param itemName ��������
	 * @param param �Զ������
	 * @param price �۸�(Ԫ)
	 * @param cpOrderId ������(���64λ)
	 */
	public static void pay(final String uid, final int waresid, final String itemName, final String param, final float price, final String cpOrderId){
		String param2 = getTransdata(uid, param, waresid, itemName, price, cpOrderId);
		IAppPay.startPay(context, param2, iPayResultCallback);
	}
	
    /** ��ȡ����̨���� */
    private static String getTransdata(String uid, String info, int waresId, String itemName, float price, String cpOrderId) {
        //���� IAppPayOrderUtils getTransdata() ��ȡ֧������
        IAppPayOrderUtils orderUtils = new IAppPayOrderUtils();
        orderUtils.setAppid(appId);
        orderUtils.setWaresid(waresId);//�������̻���̨��������Ʒ���
        orderUtils.setCporderid(cpOrderId);
        orderUtils.setAppuserid(uid);
        orderUtils.setPrice(price);//��λ Ԫ
        orderUtils.setWaresname(itemName);//���ż۸�����(�û����Զ��壬��������Ժ�̨����Ϊ׼)
        orderUtils.setCpprivateinfo(info);
        return orderUtils.getTransdata(priceKey);
    }
}
