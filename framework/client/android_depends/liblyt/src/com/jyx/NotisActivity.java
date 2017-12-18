package com.jyx;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

/**
 * �����л�
 * @author lyt
 *
 */
public class NotisActivity extends Activity {
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		Log.v("NotisActivity", "onCreate");
	}

	@Override
	protected void onActivityResult(int requestCode, int resultCode, Intent data) {
		super.onActivityResult(requestCode, resultCode, data);
		Log.v("NotisActivity", "onActivityResult");
	}

	@Override
	protected void onResume() {
		super.onResume();
		
		Log.v("NotisActivity", "onResume");
		finish();
	}
}
