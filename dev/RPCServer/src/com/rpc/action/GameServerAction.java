package com.rpc.action;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.log4j.Logger;

import com.model.rpc.server.GameServer;
import com.rpc.netty.SystemHandler;

/**
 * 游戏服务器管理
 */
public class GameServerAction {
	private static final Logger log = Logger.getLogger(GameServerAction.class);
	/** 游戏服务器的列表 **/
	private static final Map<Integer, GameServer> gameServerAll = new ConcurrentHashMap<>();
	/** 游戏服务器的连接信息 **/
	private static final Map<String, Integer> gameServerChannel = new ConcurrentHashMap<>();
	
	/** 游戏服务器的顺序<服务器id,第几个>  **/
	private static final Map<Integer, Integer> serverSort = new HashMap<>();
	/** 游戏服务器的顺序<第几个,服务器id> **/
	private static final Map<Integer, Integer> sortServer = new HashMap<>();
	/** 游戏服务器的权重值<服务器id,权重值> **/
	private static final Map<Integer, Integer> serverWeight = new HashMap<>();
	
	/**
	 * 服务器进入
	 * @param id 服务器的id 
	 * @param channel 连接
	 */
	public static void enter(int id,String channel){
		Integer gameServerId = gameServerChannel.get(channel);
		if(null != gameServerId && id != gameServerId){
			log.error("[GameServerAction] enter error,gameServer existing,gameServerId="+gameServerId);
			return;
		}
		log.error("[GameServerAction] server "+id+" enter...");
		gameServerChannel.put(channel, id);
		GameServer gameServer = gameServerAll.get(id);
		if(null == gameServer){
			gameServer = new GameServer();
			gameServer.setServerId(id);
			gameServer.setChannel(channel);
			gameServerAll.put(id, gameServer);
		}else{
			gameServer.setChannel(channel);
			gameServer.setPlayerSize(0);
			gameServer.setRoomSize(0);
		}
		updateServerWeight(id, 0);
	}
	/**
	 * 服务器退出
	 * @param channel 连接
	 */
	public static void exit(String channel){
		Integer gameServerId = gameServerChannel.get(channel);
		if(null == gameServerId)return;
		log.error("[GameServerAction] server "+gameServerId+" exit...");
		gameServerAll.remove(gameServerId);
		//更新服务器的权重
		updateServerWeight(gameServerId, Integer.MAX_VALUE-1);
	}
	/**
	 * 更新服务器的权重
	 * @param serverId
	 * @param weight 越大排序越靠前
	 */
	private static void updateServerWeight(int serverId, int weight) {
		synchronized (serverSort) {
			if(serverSort.isEmpty()){
				serverSort.put(serverId, 1);
				serverWeight.put(serverId, weight);
				sortServer.put(1, serverId);
				return;
			}
			Integer sort = serverSort.get(serverId);
			//默认最后一名
			if(null == sort){
				sort = serverSort.size()+1;
				serverSort.put(serverId, sort);
				sortServer.put(sort, serverId);
			}
			Integer tmp = serverWeight.get(serverId);
			//默认权重为上升
			if(null == tmp){
				tmp = -1;
			}
			serverWeight.put(serverId, weight);
	
			//检测排名是上升还是下降
			if(weight > tmp){
				//上升
				while(true){
					//一直跟我上一名进行比较
					Integer upServerId = sortServer.get(sort - 1);
					if(null == upServerId)break; //没有上一名了
					Integer upWeight = serverWeight.get(upServerId);
					if(weight <= upWeight)break; //没有上一名大
					//和我的上一名进行交换
					sortServer.put(sort, upServerId);
					serverSort.put(upServerId, sort);
					
					sortServer.put(sort-1, serverId);
					serverSort.put(serverId, sort-1);
					sort--;
				}
			}else{
				//下降
				while(true){
					//一直跟我的下一名比较
					Integer downServerId = sortServer.get(sort + 1);
					if(null == downServerId)break; //没有下一名
					Integer downWeight = serverWeight.get(downServerId);
					if(weight >= downWeight)break; //比下一名大
					//交换
					sortServer.put(sort, downServerId);
					serverSort.put(downServerId, sort);
					
					sortServer.put(sort+1, serverId);
					serverSort.put(serverId, sort+1);
					sort++;
				}
			}
		}
	}
	/**
	 * 根据权重获取1个服务器,取出权重值最小的那个
	 * @return -1=未找到
	 */
	public static int getServerByWeight(){
		if(sortServer.isEmpty())return -1;
		
		Integer serverId = sortServer.get(sortServer.size());
		if(null == serverId) return -1;
		GameServer gameServer = gameServerAll.get(serverId);
		if(null == gameServer)return -1;
		return gameServer.getServerId();
	}
	/**
	 * 发送到游戏服务器
	 * @param serverId
	 * @param bean
	 * @param method
	 * @param params
	 */
	public static boolean send(int serverId,String bean, String method, Object...params) {
		GameServer gameServer = gameServerAll.get(serverId);
		if(null == gameServer)return false;
		String channel = gameServer.getChannel();
		if(null == channel)return false;
		
		return SystemHandler.send(channel, bean, method, params);		
		
	}
	/**
	 * 是否连接中
	 * @param serverId
	 * @return
	 */
	public static boolean hasConnection(int serverId){
		GameServer gameServer = gameServerAll.get(serverId);
		if(null == gameServer)return false;
		String channel = gameServer.getChannel();
		if(null == channel)return false;
		return SystemHandler.hasConnection(channel);
	}
	
	/**
	 * 是否是服务器
	 * @param channel
	 * @return
	 */
	public static boolean isServer(String channel){
		return gameServerChannel.containsKey(channel);
	}
	
}
