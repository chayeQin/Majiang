package com.jyx;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Intent;
import android.util.Log;

/**
 * 对应LUA的方法的基类
 * @author lyt
 *
 */
public class LuaFunc {
	public static Cocos2dxActivity context = null;
	static {
		Log.w("LuaFunc", "init static variable");
		context = (Cocos2dxActivity)Cocos2dxActivity.getContext();
	}

	
	/**
	 * api:call("test",{"fff",2.2,3,true},function(v)
	    print("**** call test",v)
	    end)
	 * @param s
	 * @param f
	 * @param i
	 * @param b
	 * @param rhand
	 */
	public void test(final String s,final double d,final int i,final boolean b,final int rhand){
		final String msg = "test method" + s + "," + d + "," + i + "," + b;
		
		JSONObject obj = new JSONObject();
		try {
			obj.put("msg", msg);
			obj.put("int", 100);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		callBack(rhand, obj.toString());
	}
	
	/**
	 * 调用全局函数
	 * @param luaFunctionName
	 */
	static public void call(final String luaFunctionName) {
		call(luaFunctionName,"");
	}
	
	/**
	 * 调用全局函数
	 * @param luaFunctionName
	 * @param 参数(建议：JSONObject,JSONArray,String)
	 */
	static public void call(final String luaFunctionName,final Object param) {
		context.runOnGLThread(new Runnable() {
			@Override
			public void run() {
				Cocos2dxLuaJavaBridge.callLuaGlobalFunctionWithString(luaFunctionName, param.toString());
			}
		});
	}

	/**
	 * 回调函数
	 * @param rhand
	 */
	protected void callBack(final int rhand){
		callBack(rhand,"",true);
	}

	/**
	 * 回调函数
	 * @param rhand
	 * @param param (String)
	 */
	protected void callBack(final int rhand,final Object param){
		callBack(rhand,param,true);
	}
	
	/**
	 * 回调函数
	 * @param rhand
	 * @param param (String)
	 * @param isRelease 是否释放函数
	 */
	protected void callBack(final int rhand,final Object param,final boolean isRelease){
		context.runOnGLThread(new Runnable() {
			@Override
			public void run() {
				Cocos2dxLuaJavaBridge.callLuaFunctionWithString(rhand,param.toString());
				if(isRelease){
					Cocos2dxLuaJavaBridge.releaseLuaFunction(rhand);
				}
			}
		});
	}

	/**
	 * 返回游戏
	 */
	protected void backGame(){
		Intent intent = new Intent(context,NotisActivity.class);
		context.startActivity(intent);
	}
	
	/**
	 * 重新登录
	 */
	protected void relogin(){
		context.runOnGLThread(new Runnable() {
			@Override
			public void run() {
				Cocos2dxLuaJavaBridge.callLuaGlobalFunctionWithString("relogin", "");
			}
		});
	}
}
