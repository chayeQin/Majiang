package com.jyx;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.cocos2dx.lib.Cocos2dxActivity;

import android.annotation.SuppressLint;
import android.app.AlertDialog.Builder;
import android.content.DialogInterface;
import android.content.DialogInterface.OnClickListener;
import android.content.Intent;
import android.net.Uri;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.view.Gravity;
import android.widget.FrameLayout;
import android.widget.TextView;

@SuppressLint("HandlerLeak")
public class DownloadApk {
	/** 使用并必须持有引用 */
	public static Cocos2dxActivity context = null;
	
	/** 单列 */
	private static DownloadApk _instance = null;
		
	/**
	 * 下载程序
	 * @param url
	 */
	public static void down(final String url)
	{
		context.runOnUiThread(new Runnable() {
			@Override
			public void run() {
				DownloadApk.url = url;
				if(_instance == null) _instance = new DownloadApk();
				_instance.downloadApk();
			}
		});
	}
	
	/** 下载 连接 */
	private static String url = null;
	
	/** 保存地址 */
	private static String downApk = null;
	
	/** 下载进度 */
	private float progress = 0;
	
	/** 进度条对话框 */
	private TextView txtPro = null;
	
	/** 
     * 下载apk 
     */  
    private void downloadApk(){ 
        if (txtPro != null){
        	return;
        }

//    	progressBar = new ProgressBar(context);
//    	 //设置最大值为100
//    	progressBar.setMax(100);
//    	
//    	progressBar.setIndeterminate(false);
////    	progressBar.setProgressDrawable(context.getResources().getDrawable(android.R.drawable.progress_horizontal));  
////    	progressBar.setIndeterminateDrawable(context.getResources().getDrawable(android.R.drawable.progress_indeterminate_horizontal));
////    	progressBar.setLayoutParams(new FrameLayout.LayoutParams(65, 5, Gravity.CENTER_VERTICAL) );
////    	
//    	progressBar.incrementProgressBy(progressBar.getProgress());
    	
    	FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(  
        FrameLayout.LayoutParams.WRAP_CONTENT,  
        FrameLayout.LayoutParams.WRAP_CONTENT);  
        params.topMargin = 0;  
        params.gravity = Gravity.CENTER; 
        
        txtPro = new TextView(context);
        txtPro.setText("下载中...");
    	context.addContentView(txtPro,params);
    	
        //开启另一线程下载  
        Thread downLoadThread = new Thread(downApkRunnable);  
        downLoadThread.start();  
    }  
      
    /** 
     * 从服务器下载新版apk的线程 
     */  
    private Runnable downApkRunnable = new Runnable(){  
        @Override  
        public void run() {  
            if (!android.os.Environment.getExternalStorageState().equals(android.os.Environment.MEDIA_MOUNTED)) {  
                //如果没有SD卡  
                Builder builder = new Builder(context);  
                builder.setTitle("提示");  
                builder.setMessage("当前设备无SD卡，数据无法下载");  
                builder.setPositiveButton("确定", new OnClickListener() {  
                    @Override  
                    public void onClick(DialogInterface dialog, int which) {  
                        dialog.dismiss();  
                    }  
                });  
                builder.show();  
                return;  
            }else{  
                try {  
                    //服务器上新版apk地址  
                    URL url = new URL(DownloadApk.url);  
                    HttpURLConnection conn = (HttpURLConnection)url.openConnection();  
                    conn.connect();  
                    int length = conn.getContentLength();  
                    InputStream is = conn.getInputStream();  
                    File file = new File(Environment.getExternalStorageDirectory().getAbsolutePath() + "/download/");  
                    if(!file.exists()){  
                        //如果文件夹不存在,则创建  
                        file.mkdir();  
                    }  
                    //下载服务器中新版本软件（写文件）  
                    downApk = Environment.getExternalStorageDirectory().getAbsolutePath() + "/download/sds.apk";  
                    File ApkFile = new File(downApk);  
                    FileOutputStream fos = new FileOutputStream(ApkFile);  
                    int count = 0;  
                    byte buf[] = new byte[1024];  
                    do{  
                        int numRead = is.read(buf);  
                        count += numRead;  
                        //更新进度条  
                        progress = (int)(((float) count / length) * 10000) /100;  
                        handler.sendEmptyMessage(1);  
                        if(numRead <= 0){    
                            fos.close();
                            //下载完成通知安装  
                            handler.sendEmptyMessage(0);
                            break;  
                        }  
                        fos.write(buf,0,numRead);  
                    }while(true);  
                } catch (MalformedURLException e) {  
                    e.printStackTrace();  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
            }  
        }  
    };  
      
    /** 
     * 声明一个handler来跟进进度条 
     */  
    private Handler handler = new Handler() {  
        public void handleMessage(Message msg) {  
            switch (msg.what) {  
            case 1:  
                // 更新进度情况  
            	txtPro.setText("下载:" + progress + "%");
                break;  
            case 0:  
                // 安装apk文件  
                installApk();  
                break;  
            default:  
                break;  
            }  
        };  
    };  
      
    /** 
     * 安装apk 
     */  
    private void installApk() {  
        // 获取当前sdcard存储路径  
        File apkfile = new File(downApk);  
        if (!apkfile.exists()) {  
            return;  
        }  
        Intent i = new Intent(Intent.ACTION_VIEW);  
        // 安装，如果签名不一致，可能出现程序未安装提示  
        i.setDataAndType(Uri.fromFile(new File(apkfile.getAbsolutePath())), "application/vnd.android.package-archive");   
        context.startActivity(i);  
    }  
}
