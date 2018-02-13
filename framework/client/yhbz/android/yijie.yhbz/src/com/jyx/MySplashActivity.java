package com.jyx;

import org.cocos2dx.lua.AppActivity;

import android.content.Intent;
import android.graphics.Color;

import com.snowfish.cn.ganga.helper.SFOnlineSplashActivity;

public class MySplashActivity extends SFOnlineSplashActivity {

	@Override
	public int getBackgroundColor() {
		return Color.BLACK;
	}

	@Override
	public void onSplashStop() {
		Intent intent = new Intent(this, AppActivity.class);
		startActivity(intent);
		this.finish();
	}
}
