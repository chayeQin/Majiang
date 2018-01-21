package com.rpc;

import io.netty.bootstrap.ServerBootstrap;
import io.netty.channel.ChannelInitializer;
import io.netty.channel.ChannelOption;
import io.netty.channel.ChannelPipeline;
import io.netty.channel.EventLoopGroup;
import io.netty.channel.nio.NioEventLoopGroup;
import io.netty.channel.socket.SocketChannel;
import io.netty.channel.socket.nio.NioServerSocketChannel;
import io.netty.handler.logging.LogLevel;
import io.netty.handler.logging.LoggingHandler;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.rpc.netty.*;
import com.statics.Config;
import com.statics.StaticData;
import com.util.MySqlUtil;

/**
 * 中间件的启动入口
 * @author JOY122468462
 */
public class Start {
	private static final Logger log = Logger.getLogger(Start.class);
	public static String startPath = null; 
	
	public static void main(String[] args) {
		try{
			startPath = Start.class.getResource("../../").getPath();
			PropertyConfigurator.configure(startPath+"../config/log4j.properties");
			log.error("[Start]RPC Server Start...");
			//初始化静态数据
			StaticData.init(startPath);
			//初始化数据库
			MySqlUtil.initJDBC();
			//初始化socket
			initScoket();
			
			log.error("[Start]RPC Server Start ok");
		}catch(Exception e){
			e.printStackTrace();
			log.error("[Start] error",e);
			System.exit(1);
		}
	}

	private static void initScoket() throws InterruptedException {
		//bossGroup仅接收客户端连接
		EventLoopGroup bossGroup = new NioEventLoopGroup();
		//workerGroup作为worker，处理boss接收的连接的流量和将接收的连接注册进入这个worker
		EventLoopGroup workGroup = new NioEventLoopGroup();
		//serverBootstrap负责建立服务端
		ServerBootstrap sb = new ServerBootstrap();
		sb.group(bossGroup, workGroup);
		//指定使用NioServerSocketChannel产生channel
		sb.channel(NioServerSocketChannel.class);
		//ChannelInitializer用于配置一个新的Channel
		//用于向你的channel当中添加ChannelInBoundHander的实现
		sb.childHandler(new ChannelInitializer<SocketChannel>() {
			@Override
			protected void initChannel(SocketChannel channel) throws Exception {
				//Netty提供了多个解码器，可以进行分包的操作，分别是： 
				//* LineBasedFrameDecoder （回车换行解码器）
				//* DelimiterBasedFrameDecoder（添加特殊分隔符报文来分包） 
				//* FixedLengthFrameDecoder（使用定长的报文来分包） 
				//* LengthFieldBasedFrameDecoder（协议头中会携带长度字段）
				ChannelPipeline p = channel.pipeline();
				p.addLast(new JsonDecoder());
				p.addLast(new JsonEncoder());
				p.addLast(new SystemHandler());
			}
		});
		//对channel的配置
		//BACKLOG用于构造服务器套接字的ServerSocket对象,标识当服务器请求处理线程全满时，
		//用于临时存放已完成三次握手的请求的队列的最大长度。如果未设置或者所设置值小于1，将默认50
		sb.option(ChannelOption.SO_BACKLOG, 128);
		//是否启动心跳保活机制。在双方TCP套接字建立连接后（既都进入ESTABLISHED状态）
		//并且在两个小时左右上层没有任何数据传输的情况下，这套机制才会被激活
		sb.childOption(ChannelOption.SO_KEEPALIVE, true);
		//日志级别
		sb.handler(new LoggingHandler(LogLevel.INFO));
		log.error("[GameStart] bind port ["+Config.SERVER_PORT+"]...");
		//开始监听,sync()会同步等待连接操作结果
		sb.bind(Config.SERVER_PORT).sync();
	}

}
