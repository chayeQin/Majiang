package com.jyx;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Map;

/**
 * Post 请救
 * @author lyt
 * 
 */
public class HttpUtil {
	
	public HttpUtil(){
	}

	public static void post(final String urlStr, final Map<String, String> params, final HttpUtilCallback callback) {
		StringBuffer sb = new StringBuffer();
//		String pay_param = "developerPayload=" + purchase.getDeveloperPayload() + "&orderId="
//				+ purchase.getOrderId() + "&purchaseToken=" + purchase.getPurchaseToken() + "&package_name="
//				+ purchase.getPackageName() + "&productId=" + purchase.getSku();
		for (Map.Entry<String, String> entry : params.entrySet()) {  
			sb.append(entry.getKey());
			sb.append("=");
			sb.append(entry.getValue());
			sb.append("&");
		}
		sb.append("a=" + System.currentTimeMillis());
		
		final String param = sb.toString();
		new Thread(new Runnable() {
			
			@Override
			public void run() {
				callback.call(call(urlStr, param));
			}
		}).start();
	}
	
	private static String call(String urlStr,String param){
		PrintWriter out = null;
		BufferedReader in = null;
		String result = "";
		try {
			URL realUrl = new URL(urlStr);
			// 打开和URL之间的连接
			URLConnection conn = realUrl.openConnection();
			// 设置通用的请求属性
			conn.setRequestProperty("accept", "*/*");
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			conn.setConnectTimeout(10000);
			conn.setReadTimeout(10000);
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			// 获取URLConnection对象对应的输出流
			out = new PrintWriter(conn.getOutputStream());
			// 发送请求参数
			out.print(param);
			// flush输出流的缓冲
			out.flush();
			// 定义BufferedReader输入流来读取URL的响应
			in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 使用finally块来关闭输出流、输入流
		finally {
			try {
				if (out != null) {
					out.close();
				}
				if (in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		
		return result;
	}
}
