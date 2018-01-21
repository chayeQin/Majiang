package com.game;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.game.netty.*;
import com.statics.StaticData;

/**
 * 游戏逻辑的入口
 * @author JOY122468462
 *
 */
public class Start {
	private static final Logger log = Logger.getLogger(Start.class);
	public static String startPath = null; 
	
	public static void main(String[] args) {
		try{
			startPath = Start.class.getResource("../../").getPath();
			PropertyConfigurator.configure(startPath+"../config/log4j.properties");
			log.error("[Start]Game Server Start...");
			//初始化静态数据
			StaticData.init(startPath);
			
			//初始化socket
			GameHandler.init();
			
			log.error("[Start]Game Server Start ok");
		}catch(Exception e){
			e.printStackTrace();
			log.error("[Start] error",e);
		}
	}
}
