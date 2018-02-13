package com.jyx;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipException;
import java.util.zip.ZipFile;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager.NameNotFoundException;
import android.os.Environment;
import android.util.Log;

public class UnZipObb {
	public final static String TAG = "UnZipObb";
	public final static String EXP_PATH = "/Android/obb/";
	public final static String SAVE_KEY = "obb_unzip";

	private Context context = null;
	private ProgressDialog loading = null;
	
	public UnZipObb(Context context){
		this.context = context;
	}
	/**
	 * LUA 解压OBB
	 * @param rhand
	 */
	public void unObb(final Runnable rhand){
		hideLoading();
		loading = android.app.ProgressDialog.show(context, "Extracting resources", "Please wait for 1 minutes...");
		
		new Thread(new Runnable() {
			@Override
			public void run() {
				unZipObb();
				hideLoading();
				rhand.run();
			}
		}).start();
	}
	
	private void hideLoading(){
		if(loading == null){
			return;
		}
		
		loading.dismiss();
		loading = null;
	}
	
	/**
	 * 解压OBB
	 * @param ver
	 * @param path 判断文件
	 */
	public void unZipObb() {
		if (!Environment.getExternalStorageState().equals(Environment.MEDIA_MOUNTED)) {
			return;
		}
		
		String packageName = context.getPackageName();
		
		// OBB 所在路径
		File root = Environment.getExternalStorageDirectory();
		File expPath = new File(root.toString() + EXP_PATH + packageName);

		// Check that expansion file path exists
		if (!expPath.exists()) {
			return;
		}
		
		// 主文件
		String strMainPath = null;
		File main = null;
		int ver = 1;
		try {
			PackageInfo pi = context.getPackageManager().getPackageInfo(context.getPackageName(), 0);
	        ver = pi.versionCode;
		} catch (NameNotFoundException e1) {
		}
		
        String unzipVer = Liblyt.load(SAVE_KEY);
        if(unzipVer.equals("ver" + ver)){
        	Log.e(TAG, "obb had unzip on ver " + ver);
        	return;
        }
		
		// 查找文件
        for(int i = ver ;i > 0 ; i--){
	        strMainPath = expPath + File.separator + "main." + i + "." + packageName + ".obb";
	        main = new File(strMainPath);
	        if(main.exists() && main.isFile()){
	        	break;
	        }else{
	        	main = null;
	        }
        }
        
		if (main == null || !main.exists() || !main.isFile()) {
			Liblyt.save(SAVE_KEY, "ver" + ver);
			return;
		}
		
		try {
			String path = context.getFilesDir().getAbsolutePath() + File.separator;
			upZipFile(main, path);
			Liblyt.save(SAVE_KEY, "ver" + ver);
		} catch (Exception e) {
			Log.e(TAG, e.getMessage());
		}
	}
	
	/**
    * 解压缩功能.
    * 将zipFile文件解压到folderPath目录下.
    * @throws Exception
	*/
    @SuppressWarnings("rawtypes")
	public int upZipFile(File zipFile, String folderPath)throws ZipException,IOException {
        ZipFile zfile=new ZipFile(zipFile);
        Enumeration zList=zfile.entries();
        ZipEntry ze=null;
        byte[] buf=new byte[1024];
        while(zList.hasMoreElements()){
            ze=(ZipEntry)zList.nextElement();    
            if(ze.isDirectory()){
                String dirstr = folderPath + ze.getName();
                dirstr = new String(dirstr.getBytes("8859_1"), "GB2312");
                File f=new File(dirstr);
                f.mkdir();
                continue;
            }
            OutputStream os=new BufferedOutputStream(new FileOutputStream(getRealFileName(folderPath, ze.getName())));
            InputStream is=new BufferedInputStream(zfile.getInputStream(ze));
            int readLen=0;
            while ((readLen=is.read(buf, 0, 1024))!=-1) {
                os.write(buf, 0, readLen);
            }
            is.close();
            os.close();    
        }
        zfile.close();
        return 0;
    }
    
    /**
    * 给定根目录，返回一个相对路径所对应的实际文件名.
    * @param baseDir 指定根目录
    * @param absFileName 相对路径名，来自于ZipEntry中的name
    * @return java.io.File 实际的文件
    */
    public File getRealFileName(String baseDir, String absFileName){
        String[] dirs=absFileName.split("/");
        File ret=new File(baseDir);
        String substr = null;
        if(dirs.length>1){
            for (int i = 0; i < dirs.length-1;i++) {
                substr = dirs[i];
                try {
                    //substr.trim();
                    substr = new String(substr.getBytes("8859_1"), "GB2312");
                    
                } catch (UnsupportedEncodingException e) {
                    e.printStackTrace();
                }
                ret=new File(ret, substr);
                
            }
            if(!ret.exists())
                ret.mkdirs();
            substr = dirs[dirs.length-1];
            try {
                substr = new String(substr.getBytes("8859_1"), "GB2312");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            
            ret=new File(ret, substr);
            return ret;
        }
        return ret;
    }
}
