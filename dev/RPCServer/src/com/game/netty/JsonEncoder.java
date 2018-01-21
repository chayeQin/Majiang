package com.game.netty;

import java.nio.charset.Charset;

import com.alibaba.fastjson.JSON;
import com.util.MyUtil;
import com.util.ZLibUtil;

import io.netty.buffer.ByteBuf;
import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToByteEncoder;

public class JsonEncoder extends MessageToByteEncoder<Response>{
	private final Charset charset = Charset.forName("utf-8");
	@Override
	protected void encode(ChannelHandlerContext arg0, Response response,
			final ByteBuf byteBuf) throws Exception {
		if(null == response){
			throw new Exception("response is null");
		}
		String text = JSON.toJSONString(response);
		text = MyUtil.StringReplaceFirst(text, "\"id\":", "\"i\":");
		text = MyUtil.StringReplaceFirst(text, "\"bean\":", "\"b\":");
		text = MyUtil.StringReplaceFirst(text, "\"method\":", "\"m\":");
		text = MyUtil.StringReplaceFirst(text, "\"params\":", "\"p\":");
		byte[] bytes = ZLibUtil.zLib(text.getBytes(charset));
		int len = bytes.length;
		byteBuf.writeInt(len);
		byteBuf.writeBytes(bytes);
	}
}
