package com.rpc.netty;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.rpc.action.GameServerAction;
import com.statics.ErrorException;
import com.statics.TResponseCode;

import io.netty.channel.Channel;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;

/**
 * 消息入口
 */
public class SystemHandler extends ChannelInboundHandlerAdapter{
	private static final Logger log = Logger.getLogger(SystemHandler.class);
	private static boolean shutdown = false;
	
	private static final Map<String, Channel> CHANNEL_MAPS = new ConcurrentHashMap<String, Channel>();
	private static final Map<String, String> USER_CHANNEL = new ConcurrentHashMap<String, String>();
	private static final Map<String, String> CHANNEL_USER = new ConcurrentHashMap<String, String>();

	@Override
	public void channelActive(ChannelHandlerContext ctx) throws Exception {
		super.channelActive(ctx);
		if(log.isInfoEnabled()){
			log.info("[Active] "+ctx.channel().id().asShortText());
		}
	}
	// 业务列表<业务名字,业务对象>
	private static final Map<String, Class<?>> actionMap = new ConcurrentHashMap<String, Class<?>>();
	// 业务方法列表 <业务名字_方法名字_参数数量,方法>
	private static final Map<String, Method> actionMethodMap = new ConcurrentHashMap<String, Method>();
	
	/**
	 * 初始化
	 */
	public static void init() {
		//初始化com.rpc.action*下面的类
		
	}
	
	public static Class<?> getActionClass(String bean){
		try {
			bean = bean.toLowerCase();
			Class<?> actionObj = actionMap.get(bean);
			if(null != actionObj){
				return actionObj;
			}
			String actionName = bean + "Action";
			actionName = (actionName.charAt(0) + "").toUpperCase() + actionName.substring(1);
			String className = "com.rpc.action."+actionName;
			
			ClassLoader loader = Thread.currentThread().getContextClassLoader();			
			Class<?> clazz = loader.loadClass(className);
			actionMap.put(bean, clazz);
			return clazz;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	private static Method getActionMethod(String bean, String method, String key,Class<?>... parameterTypes) throws NoSuchMethodException, SecurityException {
		Method tempMethod = actionMethodMap.get(key);
		if(null == tempMethod){
			Class<?> actionClass = getActionClass(bean);
			if(null == parameterTypes || parameterTypes.length == 0){		
				tempMethod = actionClass.getMethod(method);
			}else{
				tempMethod = actionClass.getMethod(method,parameterTypes);
			}
			actionMethodMap.put(key, tempMethod);
		}
		return tempMethod;
	}
	@Override
	public void channelRead(ChannelHandlerContext ctx, Object msg)
			throws Exception {
		//如果关机状态,不做任何操作
		if(shutdown){
			return;
		}
		if(!clientIsConnection(ctx.channel())){
			return;
		}
		String client = ctx.channel().id().asShortText();
		Request request = (Request) msg;
		if(!CHANNEL_MAPS.containsKey(client)){
			CHANNEL_MAPS.put(client, ctx.channel());
		}
		if(log.isInfoEnabled()){
			log.info("[Read] ["+client+"] "+JSON.toJSONString(request));
		}
		String bean	  = request.getBean();
		String method = request.getMethod();
		Object[] params = request.getParams();
		Response resp = new Response();
		if((bean == null || bean.isEmpty() || method == null || method.isEmpty()) || ("user".equals(bean) && "ping".equals(method))){
			resp.setId(request.getId());
			ctx.channel().writeAndFlush(resp);
			return;
		}
		try {
			resp.setId(request.getId());
			//GameServer登录
			if("gameServer".equals(bean) && "enter".equals(method)){
				int gameServerId = (int) params[0];
				GameServerAction.enter(gameServerId, client);
				return;
			}
			//用户登录
			if(params != null && params.length >= 1 && params[0] instanceof String){
				String uid = (String) params[0];
				login(uid, client);
			}
			if(resp.getError() == 0){
				Object actionReturn = null;
				if(params == null || params.length == 0){
					String key = bean+method+0;
					Method tempMethod = getActionMethod(bean, method, key);
					actionReturn = tempMethod.invoke(null);
					resp.setError(0);
				}else{
					Class<?>[] paramsClass = getParamsClass(params);
					if(params[0] instanceof String){
						if(CHANNEL_USER.containsKey(client)){
							params[0] = CHANNEL_USER.get(client);
						}
					}
					String key = bean+method+params.length;
					Method tempMethod = getActionMethod(bean, method, key, paramsClass);
					actionReturn = tempMethod.invoke(null,params);
					resp.setError(0);
				}
				resp.setResult(actionReturn);
			}
		} catch (InvocationTargetException ex) {
			Throwable e = ex.getTargetException();
			if(e instanceof ErrorException){
				resp.setError(1);
				resp.setResult(((ErrorException) e).getMsg());
			}else{
				log.error("[Error] SystemHandler",e);
				resp.setError(100);
			}
		}catch(Exception e){
			log.error("[Error] SystemHandler",e);
			resp.setError(100);
		}finally{
			if(resp.getError() != 0 || (resp.getError() == 0 && resp.getResult() != null)){
				if(log.isInfoEnabled()){
					log.info("[Write] ["+client+"] "+JSON.toJSONString(resp));
				}
				ctx.channel().writeAndFlush(resp);
			}
		}
		if(log.isInfoEnabled()){
			long end = System.currentTimeMillis();
			log.info("[Time] "+bean+"."+method+" "+(end-request.getTime()) + " ms");
		}
	}
	/**
	 * 是否连接中
	 * @param channel
	 * @return
	 */
	private static boolean clientIsConnection(Channel channel) {
		if(null == channel){
			return false;
		}
		return channel.isOpen() && channel.isActive() && channel.isRegistered() && channel.isWritable();
	}

	/**
	 * 是否连接中
	 * @param channel
	 * @return
	 */
	public static boolean hasConnection(String channel) {
		if(null == channel){
			return false;
		}
		return clientIsConnection(CHANNEL_MAPS.get(channel));
	}
	
	private Class<?>[] getParamsClass(Object[] params) {
		Class<?>[] paramsClass = new Class[params.length];
		for (int i = 0; i < paramsClass.length; i++) {
			if(params[i]==null)params[i]="";
			if (params[i] instanceof Integer) {
				paramsClass[i] = int.class;
			} else if (params[i] instanceof Double) {
				paramsClass[i] = double.class;
			} else if (params[i] instanceof Float) {
				paramsClass[i] = float.class;
			} else if (params[i] instanceof Long) {
				paramsClass[i] = long.class;
			} else if (params[i] instanceof Boolean) {
				paramsClass[i] = boolean.class;
			}else if(params[i] instanceof String){
				paramsClass[i] = String.class;
				params[i] = params[i].toString().trim();
			}else if(params[i] instanceof JSONArray){
				Object[] array = ((JSONArray)params[i]).toArray();
				Class<?> clazz = null;
				//检测类型,纯字符串数组,纯int数组,混合Object数组
				for (int j = 0; j < array.length; j++) {
					if(null == clazz){
						clazz = array[j].getClass();
					}else if(clazz.equals(array[j].getClass()) == false){
						clazz = null;
						break;
					}
				}
				if(clazz == null){
					paramsClass[i] = Object[].class;
					Object[] t = new Object[array.length];
					for(int j = 0;j < t.length;j++){
						t[j] = array[j];
					}
					params[i] = t;
				}else{
					if (array[0] instanceof Integer) {
						paramsClass[i] = int[].class;
						int[] t = new int[array.length];
						for(int j = 0;j < t.length;j++){
							t[j] = (int)array[j];
						}
						params[i] = t;
					}else if(array[0] instanceof String){
						paramsClass[i] = String[].class;
						String[] t = new String[array.length];
						for(int j = 0;j < t.length;j++){
							t[j] = (String) array[j];
						}
						params[i] = t;
					}
				}
			}else{
				paramsClass[i] = params[i].getClass();
			}
		}
		return paramsClass;
	}
	@Override
	public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause)
			throws Exception {
		ctx.close();  
	}
	@Override
	public void channelUnregistered(ChannelHandlerContext ctx) throws Exception {
		super.channelUnregistered(ctx);
		String client = ctx.channel().id().asShortText();
		if(log.isInfoEnabled()){
			log.info("[Close] "+client);
		}
		if( GameServerAction.isServer(client) ){
			GameServerAction.exit(client);
		}
		if(CHANNEL_MAPS.containsKey(client)){
			CHANNEL_MAPS.remove(client);
		}
		if(CHANNEL_USER.containsKey(client)){
			String uid = CHANNEL_USER.get(client);
			if(null != uid){
				logout(uid);
			}
		}
		ctx.close();
	}
	/**
	 * 发送消息
	 * @param uid 玩家uid
	 * @param type {@link TResponseCode}
	 * @param result 参数
	 */
	public static void send(String uid, int type, Object...result) {
		//如果关机状态,不做任何操作
		if(shutdown){
			return;
		}
		if(!USER_CHANNEL.containsKey(uid))return;
		String client = USER_CHANNEL.get(uid);
		if(null == client)return;
		Channel channel = CHANNEL_MAPS.get(client);
		if(clientIsConnection(channel) == false)return;
		Response resp = new Response();
		resp.setType(type);
		resp.setResult(result);
		channel.writeAndFlush(resp);
		if(log.isInfoEnabled()){
			log.info("[Write] ["+client+"] "+JSON.toJSONString(resp));
		}
	}
	/**
	 * 发送消息
	 * @param channel 通道
	 * @param bean 类
	 * @param method 方法 
	 * @param result 参数
	 * @return 
	 */
	public static boolean send(String client, String bean, String method, Object...params) {
		Channel channel = CHANNEL_MAPS.get(client);
		if(clientIsConnection(channel) == false)return false;
		Response resp = new Response();
		resp.setType(0);
		resp.setResult(new Object[]{bean, method, params});
		channel.writeAndFlush(resp);
		if(log.isInfoEnabled()){
			log.info("[Write] ["+client+"] "+JSON.toJSONString(resp));
		}
		return true;
	}
	/**
	 * 登录
	 */
	private void login(String uid, String client) {
		if(null == uid || uid.isEmpty())return;
		//如果已存在
		String client_old = USER_CHANNEL.get(uid);
		if(null != client_old && client_old.equals(client) == false){
			logout(uid);//断线重连
		}else if(client_old != null && client_old.equals(client)){
			return;//重复登录
		}
		USER_CHANNEL.put(uid, client);
		CHANNEL_USER.put(client, uid);

	}
	/**
	 * 退出
	 */
	private void logout(String uid) {
		if(null == uid || uid.isEmpty())return;
		String client = USER_CHANNEL.get(uid);
		if(null != client){
			Channel channel = CHANNEL_MAPS.get(client);
			if(null != channel && channel.isActive() && channel.isOpen()){
				CHANNEL_MAPS.remove(client);
				channel.close();
			}
		}
		String uuid = CHANNEL_USER.get(client);
		if(uid.equals(uuid)){
			USER_CHANNEL.remove(uid);
			CHANNEL_USER.remove(client);
		}
	}
	/**
	 * 关机操作
	 */
	public static void shutdown(){
		shutdown = true;
	}
}
