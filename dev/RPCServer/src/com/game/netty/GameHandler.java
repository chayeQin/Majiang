package com.game.netty;

import java.lang.reflect.Method;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.log4j.Logger;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.statics.Config;

import io.netty.bootstrap.Bootstrap;
import io.netty.channel.Channel;
import io.netty.channel.ChannelFuture;
import io.netty.channel.ChannelHandlerContext;
import io.netty.channel.ChannelInboundHandlerAdapter;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.ChannelPipeline;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioSocketChannel;

public class GameHandler  extends ChannelInboundHandlerAdapter{
	private static final Logger log = Logger.getLogger(GameHandler.class);
	private static boolean shutdown = false;
	private static Bootstrap bootstrap = null;
	private static Channel channel = null;
	private static Integer id = 0;
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
	public static void init() throws InterruptedException {
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				while(true){
					try{
						//10秒检测一次，如果断线了,就重连
						if(clientIsConnection(channel) == false){
							connection();
						}
					}catch(Exception e){
						log.error("[Start]GameHandler connection error !!!");
					}
					try{
						Thread.sleep(10000);
					}catch(Exception e){}
				}
			}
		}).start();
		
	}
	protected static void connection() throws InterruptedException {
		if(null == bootstrap){
			EventLoopGroup group = new NioEventLoopGroup();
			bootstrap = new Bootstrap();
			bootstrap.group(group);
			bootstrap.channel(NioSocketChannel.class);
			bootstrap.option(ChannelOption.TCP_NODELAY, true);
			bootstrap.handler(new ChannelInitializer<SocketChannel>() {
	
				@Override
				protected void initChannel(SocketChannel channel) throws Exception {
					ChannelPipeline p = channel.pipeline();
					p.addLast(new JsonEncoder());
					p.addLast(new JsonDecoder());
					p.addLast(new GameHandler());
				}
			});
		}
		log.error("[Start]GameHandler connection "+Config.SERVER_IP+":"+Config.SERVER_PORT);
		ChannelFuture f = bootstrap.connect(Config.SERVER_IP, Config.SERVER_PORT).sync();
		if(f.awaitUninterruptibly(5000)){
			if(f.channel().isActive()){
				channel = f.channel();
				id = 0;
				log.error("[Start]GameHandler connection ok !!!");
				
				Thread.sleep(1000);
				boolean rs = send("gameServer","enter", Config.SERVER_ID);
				if(rs == false){
					log.error("[GameHandler] send gameServer enter error, false !!!");
				}
				return;
			}
		}
		log.error("[Start]GameHandler connection error !!!");
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
			String className = "com.game.action."+actionName;
			
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
		Request request = (Request) msg;
		if(null == request.getResult())return;
		if(log.isInfoEnabled()){
			log.info("[Read] "+JSON.toJSONString(request));
		}
		if(request.getError() != 0){
			log.error("[Read] ["+request.getError()+"] "+request.getResult());
			return;
		}
		String bean = null;
		String method = null;
		long start = System.currentTimeMillis();
		try {
			Object[] result = JSON.parseObject(request.getResult().toString(), Object[].class);
			bean = (String) result[0];
			method = (String) result[1];
			Object[] params = JSON.parseObject(result[2].toString(), Object[].class);
			if((bean == null || bean.isEmpty() || method == null || method.isEmpty()) || ("user".equals(bean) && "ping".equals(method))){
				Response resp = new Response();
				resp.setId(request.getId());
				ctx.channel().writeAndFlush(resp);
				return;
			}
			if(params == null || params.length == 0){
				String key = bean+method+0;
				Method tempMethod = getActionMethod(bean, method, key);
				tempMethod.invoke(null);
			}else{
				Class<?>[] paramsClass = getParamsClass(params);
				String key = bean+method+params.length;
				Method tempMethod = getActionMethod(bean, method, key, paramsClass);
				tempMethod.invoke(null,params);
			}
		}catch(Exception e){
			log.error("[Error] SystemHandler",e);
		}
		if(log.isInfoEnabled()){
			long end = System.currentTimeMillis();
			log.info("[Time] "+bean+"."+method+" "+(end-start) + " ms");
		}
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
		ctx.close(); 
		channel = null;
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
	 * 发送消息
	 * @param bean
	 * @param method
	 * @param params
	 * @return
	 */
	public static boolean send(String bean, String method, Object...params) {
		if(clientIsConnection(channel) == false)return false;
		Response resp = new Response();
		resp.setId(--id);
		resp.setBean(bean);
		resp.setMethod(method);
		resp.setParams(params);
		channel.writeAndFlush(resp);
		if(log.isInfoEnabled()){
			log.info("[Write] "+JSON.toJSONString(resp));
		}
		return true;
	}
}
