package com.jyx;

import org.cocos2dx.lib.Cocos2dxActivity;
import org.cocos2dx.lib.Cocos2dxLuaJavaBridge;

import android.app.Activity;
import android.content.Intent;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.Window;
import android.view.WindowManager;
import android.widget.Toast;

/**
 * 视频播放类
 * @author lyt
 */
public class VideoActivity extends Activity implements MediaPlayer.OnCompletionListener{
	private int clickCount = 2;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		
		//隐藏标题栏  
        this.requestWindowFeature(Window.FEATURE_NO_TITLE);  
        //隐藏状态栏  
        this.getWindow().setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN, WindowManager.LayoutParams.FLAG_FULLSCREEN);
        
        VideoView vv = new VideoView(this);
        vv.setVideoURI(VideoActivity.url);
        vv.setOnCompletionListener(this);
        setContentView(vv);
        vv.start();
	}
	
	//当视频播放完后回调此函数
	@Override
	public void onCompletion(MediaPlayer mp) {
		this.finish();
	}
	
	@Override
	public boolean onTouchEvent(MotionEvent event) {
		this.finish();
		return super.onTouchEvent(event);
	}

	@Override
	public boolean onKeyDown(int keyCode, KeyEvent event) {
		switch(keyCode){
		case KeyEvent.KEYCODE_BACK:
			clickCount--;
			if (clickCount < 1){
				this.finish();
			}else{
				Toast.makeText(this,"再点一次退出视频", Toast.LENGTH_SHORT).show();
			}
			return true;
		}
		return super.onKeyDown(keyCode, event);
	}
	
	@Override
	public void finish() {
		context.runOnGLThread(new Runnable() {
			@Override
			public void run() {
				Cocos2dxLuaJavaBridge.callLuaFunctionWithString(rhand, "end");
				Cocos2dxLuaJavaBridge.releaseLuaFunction(rhand);
			}
		});
		super.finish();
	}

	// 弹出UI
	public static Cocos2dxActivity context;
	public static String url;
	public static int rhand;
	public static void play(final String url,final int rhand){
		VideoActivity.url = url;
		VideoActivity.rhand = rhand;
		context.runOnUiThread(new Runnable() {
			@Override
			public void run() {
				Intent intent = new Intent(context,VideoActivity.class);
				context.startActivity(intent);
			}
		});
	}
}
