package com.statics;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Properties;

import org.apache.log4j.Logger;

public class StaticData {
	private static final Logger log = Logger.getLogger(StaticData.class);
	public static final Integer[] library = new Integer[28 * 4];
	/**
	 * 初始化静态数据
	 * @param startPath 
	 */
	public static void init(String startPath) throws Exception{
		log.error("[StaticData] init...");
		File config = new File(startPath+"../config/config.properties");
		log.error("[StaticData] load "+config.getAbsoluteFile());
		if(config.exists() == false){
			throw new Exception("not find "+config.getAbsolutePath());
		}
		initConfig(config);
		initLibrary();
	}
	private static void initLibrary() {
		for(int r = 1;r <= 3;r++){
			for(int i = 1;i <= 9;i++){
				library[(r-1)*9+(i-1)] = r*10+i;
			}
		}
		//1234567
		library[27] = 5;
		System.arraycopy(library, 0, library, 28, 28);
		System.arraycopy(library, 0, library, 56, 28);
		System.arraycopy(library, 0, library, 84, 28);
	}
	private static void initConfig(File file) { 
		try {
			Properties prop = new Properties();
			BufferedInputStream input = new BufferedInputStream(new FileInputStream(file));
			prop.load(input);
			log.error("[StaticData] "+prop.toString());
			
			Config.SERVER_ID = Integer.parseInt(prop.getProperty("server.id", "0"));
			Config.SERVER_IP = prop.getProperty("server.ip", "127.0.0.1");
			Config.SERVER_PORT = Integer.parseInt(prop.getProperty("server.port", "0"));
			
			Config.JDBC_DRIVER = prop.getProperty("jdbc.driver");
			Config.JDBC_URL = prop.getProperty("jdbc.url");
			Config.JDBC_USERNAME = prop.getProperty("jdbc.username");
			Config.JDBC_PASSWORD = prop.getProperty("jdbc.password");
			Config.JDBC_INIT_ACTIVE = Integer.parseInt(prop.getProperty("jdbc.initActive", "0"));
			Config.JDBC_MAX_ACTIVE = Integer.parseInt(prop.getProperty("jdbc.maxActive", "0"));
			input.close();
		} catch (Exception e) {
			log.error("[StaticData] initConfig error",e);
		}
	}
}
