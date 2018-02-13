package com.google.billing.utils;

/**
 * 支付回调
 * @author lyt
 */
public interface GooglePayHandler {
	public void googlePaySuccess();
	public void googlePayFail();
}
