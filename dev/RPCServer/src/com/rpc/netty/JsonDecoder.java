package com.rpc.netty;

import java.nio.charset.Charset;
import java.util.Arrays;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.util.MyUtil;
import com.util.ZLibUtil;

import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.ByteToMessageDecoder;

/**
 * 解码器 
 */
public class JsonDecoder extends ByteToMessageDecoder{
	private final static Charset charset = Charset.forName("utf-8");
	//头部信息的大小应该是  int + int
    private static final int HEADER_SIZE = 4;
    
	@Override
	protected void decode(ChannelHandlerContext arg0, ByteBuf in,
			List<Object> out) throws Exception {
		if(in == null)return;
		if(in.readableBytes() < HEADER_SIZE)return;
		in.markReaderIndex();
		int len = in.readInt();
		if(len <= 0){
			in.resetReaderIndex();
			return;
		}
		int size = in.readableBytes();
//		System.out.println("len="+len+", size="+size);
		//byte[] bb = new byte[4];
		//in.getBytes(0, bb);
		//System.out.println(Arrays.toString(bb));
		if(size < len){
			in.resetReaderIndex();
			return;
		}
		try{
			byte[] buf = new byte[len];
			in.readBytes(buf);
			String text = new String(ZLibUtil.unZLib(buf, 0, len),charset);
			text = MyUtil.StringReplaceFirst(text, "\"i\":", "\"id\":");
			text = MyUtil.StringReplaceFirst(text, "\"b\":", "\"bean\":");
			text = MyUtil.StringReplaceFirst(text, "\"m\":", "\"method\":");
			text = MyUtil.StringReplaceFirst(text, "\"p\":", "\"params\":");
			Request request = JSON.parseObject(text, Request.class);
			request.setTime(System.currentTimeMillis());
			out.add(request);
		}catch(Exception e){
			e.printStackTrace();
			throw e;
		}
	}

}
