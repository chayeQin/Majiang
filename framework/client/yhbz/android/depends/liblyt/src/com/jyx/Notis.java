package com.jyx;

import java.util.HashMap;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import cn.jpush.android.api.JPushInterface;
import cn.jpush.android.data.JPushLocalNotification;

public class Notis extends LuaFunc {
	public void notis(final JSONObject args, final int rhand) {
		try {
			String msg = args.getString("msg");
			int time = args.getInt("time");
			long notificationId = args.getLong("notificationId");
			JPushLocalNotification ln = new JPushLocalNotification();
			ln.setContent(msg);
			ln.setNotificationId(notificationId);
			ln.setBroadcastTime(System.currentTimeMillis() + 1000 * time);
			JPushInterface.addLocalNotification(context, ln);
		} catch (JSONException e) {
			e.printStackTrace();
		}
	}
	
	public void removeLocalNotification(final JSONObject args, final int rhand){
		try {
			long notificationId = args.getLong("notificationId");
			JPushInterface.removeLocalNotification(context, notificationId);
		} catch (JSONException e) {
			e.printStackTrace();
		}
	}
	
	public void shake(final JSONObject args, final int rhand){
		
	}

}
