package org.cocos2dx.utils;

import java.net.HttpURLConnection;
import java.net.URL;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo.State;
import android.net.wifi.WifiManager;

public class PSNetwork {
	static ConnectivityManager mConnManager = null;
	static Context mContext;

	public static void init(Context context) {
		mContext = context;
		mConnManager = (ConnectivityManager) context
				.getSystemService(Context.CONNECTIVITY_SERVICE);
	}

	public static boolean isLocalWiFiAvailable() {
		WifiManager wifiManager = (WifiManager)mContext.getSystemService(Context.WIFI_SERVICE);
        int wifiState = 0;
		if(wifiManager != null){
			wifiState = wifiManager.getWifiState();
	    }
		
		return wifiState == WifiManager.WIFI_STATE_ENABLED;
	}

	public static boolean isInternetConnectionAvailable() {
		if (mConnManager == null) {
			return false;
		}

		if (isLocalWiFiAvailable()) {
			return true;
		} 
		
		try {
			State state = mConnManager.getNetworkInfo(
					ConnectivityManager.TYPE_MOBILE).getState();
			return State.CONNECTED == state;
		} catch (Exception e) { 
			return false;
		}
	}

	public static boolean isHostNameReachable(String hostName) {
		int counts = 0;
		if (hostName == null || hostName.length() <= 0) {
			return false;
		}
		while (counts < 3) {
			try {
				URL url = new URL(hostName);
				int state = ((HttpURLConnection) url.openConnection())
						.getResponseCode();
				if (state == 200) {
					return true;
				}
				return false;
			} catch (Exception ex) {
				counts++;
				continue;
			}
		}
		return false;
	}

	public static int getInternetConnectionStatus() {
		if (isLocalWiFiAvailable()) {
			return 1; // wifi
		}
		if (isInternetConnectionAvailable()) {
			return 2; // gprs
		}
		return 0;
	}
}
