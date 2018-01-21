package com.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.zip.Deflater;
import java.util.zip.DeflaterOutputStream;
import java.util.zip.Inflater;
import java.util.zip.InflaterInputStream;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jcraft.jzlib.JZlib;
import com.jcraft.jzlib.ZInputStream;
import com.jcraft.jzlib.ZOutputStream;

/**
 * ZLib压缩工具
 */
@SuppressWarnings("deprecation")
public final class ZLibUtil {
	public static final Log log = LogFactory.getLog(ZLibUtil.class);

	/**
	 * ZLib压缩数据
	 * 
	 * @param object
	 * @return
	 * @throws IOException
	 */
	public static byte[] zLib(byte[] bContent) throws IOException {

		byte[] data = null;
		try {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			ZOutputStream zOut = new ZOutputStream(out,
					JZlib.Z_BEST_COMPRESSION); // 压缩级别,缺省为1级
			DataOutputStream objOut = new DataOutputStream(zOut);
			objOut.write(bContent);
			objOut.flush();
			zOut.close();
			data = out.toByteArray();
			out.close();

		} catch (IOException e) {
			e.printStackTrace();
			throw e;
		}
		return data;
	}

	/**
	 * ZLib解压数据
	 * 
	 * @param object
	 * @return
	 * @throws IOException
	 */
	public static byte[] unZLib(byte[] bContent, int offset, int length)
			throws IOException {
		ByteArrayInputStream in = new ByteArrayInputStream(bContent, offset,
				length);
		ZInputStream zIn = new ZInputStream(in);
		byte[] buf = new byte[256];
		int num = -1;
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		while ((num = zIn.read(buf, 0, buf.length)) != -1) {
			baos.write(buf, 0, num);
		}

		byte[] data = baos.toByteArray();
		baos.flush();
		baos.close();
		zIn.close();
		in.close();
		return data;
	}

	/***
	 * 压缩Zip
	 * 
	 * @param data
	 * @return
	 */
	public static byte[] zip(byte[] data) {
		byte[] b = null;
		try {
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			ZipOutputStream zip = new ZipOutputStream(bos);
			ZipEntry entry = new ZipEntry("zip");
			entry.setSize(data.length);
			zip.putNextEntry(entry);
			zip.write(data);
			zip.closeEntry();
			zip.close();
			b = bos.toByteArray();
			bos.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return b;
	}

	/***
	 * 解压Zip
	 * 
	 * @param data
	 * @return
	 */
	public static byte[] unZip(byte[] data) {
		byte[] b = null;
		try {
			ByteArrayInputStream bis = new ByteArrayInputStream(data);
			ZipInputStream zip = new ZipInputStream(bis);
			while (zip.getNextEntry() != null) {
				byte[] buf = new byte[1024];
				int num = -1;
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				while ((num = zip.read(buf, 0, buf.length)) != -1) {
					baos.write(buf, 0, num);
				}
				b = baos.toByteArray();
				baos.flush();
				baos.close();
			}
			zip.close();
			bis.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return b;
	}

	/**
	 * 压缩
	 * 
	 * @param data
	 *            待压缩数据
	 * @return byte[] 压缩后的数据
	 */
	public static byte[] compress(byte[] data) {
		byte[] output = new byte[0];
		Deflater compresser = new Deflater();
		compresser.reset();
		compresser.setInput(data);
		compresser.finish();
		ByteArrayOutputStream bos = new ByteArrayOutputStream(data.length);
		try {
			byte[] buf = new byte[1024];
			while (!compresser.finished()) {
				int i = compresser.deflate(buf);
				bos.write(buf, 0, i);
			}
			output = bos.toByteArray();
		} catch (Exception e) {
			output = data;
			e.printStackTrace();
		} finally {
			try {
				bos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		compresser.end();
		compresser = null;
		return output;
	}

	/**
	 * 压缩
	 * 
	 * @param data
	 *            待压缩数据
	 * 
	 * @param os
	 *            输出流
	 */
	public static void compress(byte[] data, OutputStream os) {
		DeflaterOutputStream dos = new DeflaterOutputStream(os);
		try {
			dos.write(data, 0, data.length);
			dos.finish();
			dos.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 * 解压缩
	 * 
	 * @param data
	 *            待压缩的数据
	 * @return byte[] 解压缩后的数据
	 */
	public static byte[] uncompress(byte[] data) {
		byte[] output = new byte[0];
		Inflater decompresser = new Inflater();
		decompresser.reset();
		decompresser.setInput(data);

		ByteArrayOutputStream o = new ByteArrayOutputStream(data.length);
		try {
			int count = 0;
			byte[] buf = new byte[1024];
			while (!decompresser.finished()) {
				int i = decompresser.inflate(buf);
				o.write(buf, 0, i);
				count++;
				if (count >= 10000) {
					log.error("uncompress error,data.length=" + data.length);
					break;
				}
			}
			output = o.toByteArray();
		} catch (Exception e) {
			output = data;
			e.printStackTrace();
		} finally {
			try {
				o.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		decompresser.end();
		decompresser = null;
		return output;
	}

	/**
	 * 解压缩
	 * 
	 * @param is
	 *            输入流
	 * @return byte[] 解压缩后的数据
	 */
	public static byte[] uncompress(InputStream is) {
		InflaterInputStream iis = new InflaterInputStream(is);
		ByteArrayOutputStream o = new ByteArrayOutputStream(1024);
		try {
			int i = 1024;
			byte[] buf = new byte[i];
			while ((i = iis.read(buf, 0, i)) > 0) {
				o.write(buf, 0, i);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		return o.toByteArray();
	}

}