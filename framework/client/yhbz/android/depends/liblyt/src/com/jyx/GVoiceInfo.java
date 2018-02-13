package com.jyx;

import org.json.JSONException;
import org.json.JSONObject;

import android.util.Log;

import com.tencent.gcloud.voice.GCloudVoiceEngine;
import com.tencent.gcloud.voice.GCloudVoiceErrno;
import com.tencent.gcloud.voice.IGCloudVoiceNotify;

public class GVoiceInfo extends LuaFunc {
	public static final String TAG = "GVoiceInfo";
	public String appId = null;
	public String appKey = null;
	public int callbackRhand = 0;
	private Thread thread = null;
	
	public GVoiceInfo(String appId, String appKey)
	{
		this.appId = appId;
		this.appKey = appKey;
		GCloudVoiceEngine.getInstance().init(context.getApplicationContext(), context);
	}
	
	/**
	 * 使用语音功能
	 * @param obj
	 * @param rhand
	 */
	public void open(final JSONObject obj, final int rhand)
	{
		String uid = "";
		int mode = GCloudVoiceEngine.Mode.Messages;
		String url = "";
		int vol = 200;
		try {
			uid = obj.getString("uid");
			url = obj.getString("url");
			int type = obj.getInt("type");
			if(type == 1){
				mode = GCloudVoiceEngine.Mode.RealTime;
		    }else if(type == 2){
		    	mode = GCloudVoiceEngine.Mode.Messages;
		    }else{
		    	mode = GCloudVoiceEngine.Mode.Translation;
		    }
			if(obj.has("vol"))
			{
				vol = obj.getInt("vol");
			}
		} catch (JSONException e1) {
			e1.printStackTrace();
		}
		
		int error = GCloudVoiceEngine.getInstance().SetAppInfo(this.appId, this.appKey, uid);
		error = GCloudVoiceEngine.getInstance().Init();
		error = GCloudVoiceEngine.getInstance().SetNotify(motify);
		error = GCloudVoiceEngine.getInstance().SetMode(mode);
		error = GCloudVoiceEngine.getInstance().SetServerInfo(url);
		error = GCloudVoiceEngine.getInstance().SetSpeakerVolume(vol);
		
		if(error == GCloudVoiceErrno.GCLOUD_VOICE_SUCC && thread == null){
			thread = new Thread(new Runnable() {
				@Override
				public void run() {
					while(thread != null)
					{
						try {
							Thread.sleep((long) 100);
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
						GCloudVoiceEngine.getInstance().Poll();
					}
				}
			});
			
			thread.start();
		}
		
		check(rhand, error, true);
	}

	/**
	 * 设置语音音量
	 * @param args
	 * @param rhand
	 */
	public void setSpeakerVolume(final JSONObject args, final int rhand)
	{
	    int vol = 200;
		try {
			vol = args.getInt("vol");
		} catch (JSONException e) {
			e.printStackTrace();
		}
	    int error = GCloudVoiceEngine.getInstance().SetSpeakerVolume(vol);
	    check(rhand, error, true);
	}

	/**
	 * 获取语音
	 * @param args
	 * @param rhand
	 */
	public void getSpeakerLevel(final JSONObject args, final int rhand)
	{
	    int vol = GCloudVoiceEngine.getInstance().GetSpeakerLevel();
	    JSONObject obj = new JSONObject();
	    try {
			obj.put("status", "ok");
		    obj.put("vol", vol);
		} catch (JSONException e) {
			e.printStackTrace();
		}
	    callBack(rhand, obj);
	}

	/**
	 * 加入房间
	 * @param args
	 * @param rhand
	 */
	public void jionTeamRoom(final JSONObject args, final int rhand)
	{
		String roomID = "";
		try {
			roomID = args.getString("roomID");
		} catch (JSONException e) {
			e.printStackTrace();
		}
		int error = GCloudVoiceEngine.getInstance().JoinTeamRoom(roomID, 60000);
	    check(rhand, error, false);
	}

	/**
	 * 加入房间
	 * @param args
	 * @param rhand
	 */
	public void joinNationalRoom(final JSONObject args, final int rhand)
	{
		String roomID = "";
		int roleType = 1;
		try {
			roomID = args.getString("roomID");
			roleType = args.getInt("roleType");
		} catch (JSONException e) {
			e.printStackTrace();
		}
	    int error = GCloudVoiceEngine.getInstance().JoinNationalRoom(roomID, roleType, 60000);

	    check(rhand, error, false);
	}

	/**
	 * 加入房间
	 * @param args
	 * @param rhand
	 */
	public void joinFMRoom(final JSONObject args, final int rhand)
	{
	}

	// 退出房间
	public void quickRoom(final JSONObject args, final int rhand)
	{
		String roomID = "";
		try {
			roomID = args.getString("roomID");
		} catch (JSONException e) {
			e.printStackTrace();
		}
		int error = GCloudVoiceEngine.getInstance().QuitRoom(roomID, 60000);
	    check(rhand, error, false);
	}

	/**
	 * 打开麦克风(同时发送语音)
	 * @param args
	 * @param rhand
	 */
	public void openMic(final JSONObject args, final int rhand)
	{
		int error = GCloudVoiceEngine.getInstance().OpenMic();
	    check(rhand, error, true);
	}

	/**
	 * 关闭麦克风(同时关闭声音数据)Close players's micro phone and stop to send player's voice data.
	 * @param args
	 * @param rhand
	 */
	public void closeMic(final JSONObject args, final int rhand)
	{
		int error = GCloudVoiceEngine.getInstance().CloseMic();
	    check(rhand, error, true);
	}

	/**
	 * 打开扬声器
	 * @param args
	 * @param rhand
	 */
	public void openSpeaker(final JSONObject args, final int rhand)
	{
		int error = GCloudVoiceEngine.getInstance().OpenSpeaker();
	    check(rhand, error, true);
	}

	/**
	 * 关闭扬声器
	 * @param args
	 * @param rhand
	 */
	public void closeSpeaker(final JSONObject args, final int rhand)
	{
		int error = GCloudVoiceEngine.getInstance().CloseSpeaker();
	    check(rhand, error, true);
	}

	/**
	 * 申请离线语音
	 * @param args
	 * @param rhand
	 */
	public void applyMessageKey(final JSONObject args, final int rhand)
	{
		int error = GCloudVoiceEngine.getInstance().ApplyMessageKey(60000);
	    check(rhand, error, false);
	}

	/**
	 * MAX录音时间(毫秒)
	 * @param args
	 * @param rhand
	 */
	public void maxLength(final JSONObject args, final int rhand)
	{
		int max = 2 * 60 * 1000;
		try {
			max = args.getInt("max");
		} catch (JSONException e) {
			e.printStackTrace();
		}
		int error = GCloudVoiceEngine.getInstance().SetMaxMessageLength(max);
	    check(rhand, error, true);
	}

	/**
	 * 开始录音
	 * @param args
	 * @param rhand
	 */
	public void startRecording(final JSONObject args, final int rhand)
	{
		String path = "";
		try {
			path = args.getString("path");
		} catch (JSONException e) {
			e.printStackTrace();
		}
		int error = GCloudVoiceEngine.getInstance().StartRecording(path);
	    check(rhand, error, true);
	}

	/**
	 * 停止录音
	 * @param args
	 * @param rhand
	 */
	public void stopRecording(final JSONObject args, final int rhand)
	{
		int error = GCloudVoiceEngine.getInstance().StopRecording();
	    check(rhand, error, true);
	}

	/**
	 * 上传文件
	 * @param args
	 * @param rhand
	 */
	public void uploadFile(final JSONObject args, final int rhand)
	{
		String path = "";
		try {
			path = args.getString("path");
		} catch (JSONException e) {
			e.printStackTrace();
		}

		int error = GCloudVoiceEngine.getInstance().UploadRecordedFile(path, 60000);
	    check(rhand, error, false);
	}

	/**
	 * 下载文件
	 * @param args
	 * @param rhand
	 */
	public void downFile(final JSONObject args, final int rhand)
	{
		String fileID = "";
		String path = "";
		try {
			fileID = args.getString("fileID");
			path = args.getString("path");
		} catch (JSONException e) {
			e.printStackTrace();
		}

		int error = GCloudVoiceEngine.getInstance().DownloadRecordedFile(fileID, path, 60000);
	    check(rhand, error, false);
	}

	/**
	 * 播放文件
	 * @param args
	 * @param rhand
	 */
	public void playFile(final JSONObject args, final int rhand)
	{
		String path = "";
		try {
			path = args.getString("path");
		} catch (JSONException e) {
			e.printStackTrace();
		}

		int error = GCloudVoiceEngine.getInstance().PlayRecordedFile(path);
	    check(rhand, error, false);
	}

	/**
	 * 停止播放文件
	 * @param args
	 * @param rhand
	 */
	public void stopPlayFile(final JSONObject args, final int rhand)
	{
		int error = GCloudVoiceEngine.getInstance().StopPlayFile();
	    check(rhand, error, true);
	}

	/**
	 * 语音转文字（中文）
	 * @param args
	 * @param rhand
	 */
	public void speechToText(final JSONObject args, final int rhand)
	{
		String path = "";
		try {
			path = args.getString("path");
		} catch (JSONException e) {
			e.printStackTrace();
		}

		int error = GCloudVoiceEngine.getInstance().SpeechToText(path, 60000, 12000);
	    check(rhand, error, false);
	}

	public static void onResume()
	{
		GCloudVoiceEngine.getInstance().Resume();
	}

	public static void onPause()
	{
		GCloudVoiceEngine.getInstance().Pause();
	}

	/**
	 * 判断接口返回参数
	 * @return
	 */
	public boolean check(final int rhand, final int error, final boolean isBack)
	{
	    if(GCloudVoiceErrno.GCLOUD_VOICE_SUCC == error){
	        if(isBack)
	        {
	        	JSONObject result = new JSONObject();
	        	try {
					result.put("status", "ok");
				} catch (JSONException e) {
					e.printStackTrace();
				}
	        	this.callBack(rhand, result);
	        }
	        else
	        {
	        	this.callbackRhand = rhand; // 用于异步回调
	        }
	        return false;
	    }
	    
    	JSONObject result = new JSONObject();
    	try {
			result.put("status", "fail");
	    	result.put("error", String.valueOf(error));
		} catch (JSONException e) {
			e.printStackTrace();
		}
    	this.callBack(rhand, result);
	    
	    return true;
	}
	
	private IGCloudVoiceNotify motify = new IGCloudVoiceNotify() {
		
		@Override
		public void OnUploadFile(int code, String filePath, String fileID) {
			JSONObject obj = new JSONObject();
			if(GCloudVoiceCompleteCode.GV_ON_UPLOAD_RECORD_DONE == code){
				try{
					obj.put("status", "ok");
					obj.put("filePath", filePath);
					obj.put("fileID", fileID);
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}else{
				try{
					obj.put("status", "fail");
					obj.put("filePath", filePath);
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}
			callBack(callbackRhand, obj);
		}
		
		@Override
		public void OnStreamSpeechToText(int code, int arg1, String arg2) {
			Log.e(TAG, "OnStatusUpdate" + code);
		}
		
		@Override
		public void OnStatusUpdate(int code, String arg1, int arg2) {
			Log.e(TAG, "OnStatusUpdate" + code);
		}
		
		@Override
		public void OnSpeechToText(int code, String fileID, String result) {
			JSONObject obj = new JSONObject();
			if(GCloudVoiceCompleteCode.GV_ON_STT_SUCC == code){
				try{
					obj.put("status", "ok");
					obj.put("fileID", fileID);
					obj.put("result", result);
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}else{
				try{
					obj.put("status", "fail");
					obj.put("fileID", fileID);
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}
			callBack(callbackRhand, obj);
		}
		
		@Override
		public void OnRecording(char[] arg0, int nDataLength) {
			Log.e(TAG, "OnRecording length %d" + nDataLength);
		}
		
		@Override
		public void OnQuitRoom(int code, String roomName) {
			JSONObject obj = new JSONObject();
			if(GCloudVoiceCompleteCode.GV_ON_QUITROOM_SUCC == code){
				try{
					obj.put("status", "ok");
					obj.put("roomName", roomName);
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}else{
				try{
					obj.put("status", "fail");
					obj.put("roomName", roomName);
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}
			callBack(callbackRhand, obj);
		}
		
		@Override
		public void OnPlayRecordedFile(int code, String filePath) {
			JSONObject obj = new JSONObject();
			if(GCloudVoiceCompleteCode.GV_ON_PLAYFILE_DONE == code){
				try{
					obj.put("status", "ok");
					obj.put("filePath", filePath);
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}else{
				try{
					obj.put("status", "fail");
					obj.put("filePath", filePath);
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}
			callBack(callbackRhand, obj);
		}
		
		@Override
		public void OnMemberVoice(int[] arg0, int count) {
			Log.e(TAG, "OnMemberVoice count %d" + count);
//		    for(int i = 0; i < count ; i++)
//		    {
//		        const unsigned int memberId = members[i * 2];
//		        const unsigned int memberStatus = members[i * 2 + 1];
//		    }
		}
		
		@Override
		public void OnJoinRoom(int code, String roomName, int memberID) {
			JSONObject obj = new JSONObject();
			if(GCloudVoiceCompleteCode.GV_ON_JOINROOM_SUCC == code){
				try {
					obj.put("status", "ok");
					obj.put("roomName", roomName);
					obj.put("memberID", String.valueOf(memberID));
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}else{
				try {
					obj.put("status", "fail");
					obj.put("roomName", roomName);
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}
			callBack(callbackRhand, obj);
		}
		
		@Override
		public void OnDownloadFile(int code, String filePath, String fileID) {
			JSONObject obj = new JSONObject();
			if(GCloudVoiceCompleteCode.GV_ON_DOWNLOAD_RECORD_DONE == code){
				try{
					obj.put("status", "ok");
					obj.put("filePath", filePath);
					obj.put("fileID", fileID);
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}else{
				try{
					obj.put("status", "fail");
					obj.put("filePath", filePath);
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}
			callBack(callbackRhand, obj);
		}
		
		@Override
		public void OnApplyMessageKey(int code) {
			JSONObject obj = new JSONObject();
			if(GCloudVoiceCompleteCode.GV_ON_MESSAGE_KEY_APPLIED_SUCC == code){
				try{
					obj.put("status", "ok");
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}else{
				try{
					obj.put("status", "fail");
				} catch (JSONException e) {
					Log.e(TAG, e.getMessage());
				}
			}
			callBack(callbackRhand, obj);
		}
	};
}
