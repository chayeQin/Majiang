package com.game.netty;

import java.nio.charset.Charset;
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
    
    private int len = -1;
	@Override
	protected void decode(ChannelHandlerContext arg0, ByteBuf in,
			List<Object> out) throws Exception {
		if(in == null)return;
		if(len == -1){
			if(in.readableBytes() < HEADER_SIZE)return;
			len = in.readInt();
		}
		if(len <= 0)return;
		int size = in.readableBytes();
		if(size < len){
			return;
		}
		byte[] buf = new byte[len];
		in.readBytes(buf);
		String text = new String(ZLibUtil.unZLib(buf, 0, len),charset);
		len = -1;
		text = MyUtil.StringReplaceFirst(text, "\"i\":", "\"id\":");
		text = MyUtil.StringReplaceFirst(text, "\"e\":", "\"error\":");
		text = MyUtil.StringReplaceFirst(text, "\"t\":", "\"type\":");
		text = MyUtil.StringReplaceFirst(text, "\"r\":", "\"result\":");
		Request request = JSON.parseObject(text, Request.class);
		out.add(request);
	}

}
