#import "GVoiceInfo.h"

@implementation GVoiceInfo

@synthesize appId;
@synthesize appKey;
@synthesize appOpenId;
@synthesize pollTimer;
@synthesize callBackData;

static GVoiceInfo* instance;
static GVoiceNotify* notify = NULL;

-(id)init:(NSString *)appId key:(NSString *)appKey
{
    self = [super init];
    self.appId = appId;
    self.appKey = appKey;
    
    instance = self;
    
    return self;
}

// 使用语音功能
-(void)open:(NSDictionary *)dict
{
    NSDictionary* args = [dict objectForKey:@"param"];
    self.callBackData = dict;
    
    self.appOpenId = [args objectForKey:@"uid"];
    const char *appID = [self.appId UTF8String];
    const char *appKey = [self.appKey UTF8String];
    const char *openID = [self.appOpenId UTF8String];
    
    gcloud_voice::IGCloudVoiceEngine* gVoice = gcloud_voice::GetVoiceEngine();
    gVoice->SetAppInfo(appID, appKey, openID);
    GCloudVoiceErrno error = gVoice->Init();
    
    if(notify == NULL){
        notify = new (std::nothrow)GVoiceNotify();
        gVoice->SetNotify(notify);
    }
    
    // 语音模式
    int type = [[args objectForKey:@"type"] intValue];
    if(type == 1){
        gVoice->SetMode(gcloud_voice::IGCloudVoiceEngine::RealTime);
    }else if(type == 2){
        gVoice->SetMode(gcloud_voice::IGCloudVoiceEngine::Messages);
    }else{
        gVoice->SetMode(gcloud_voice::IGCloudVoiceEngine::Translation);
    }
    
    // 服务器地址
    NSString* url = [args objectForKey:@"url"];
    gVoice->SetServerInfo([url UTF8String]);
    
    if(self.pollTimer == nil)
    {
        self.pollTimer = [NSTimer scheduledTimerWithTimeInterval:1.000/12 repeats:YES block:^(NSTimer * _Nonnull timer) {
            gcloud_voice::GetVoiceEngine()->Poll();
        }];
    }
    
    gVoice->EnableLog(false);
    int vol = 200;
    if([[args allKeys] containsObject:@"vol"])
    {
        vol = [[args objectForKey:@"vol"] intValue];
    }
    GetVoiceEngine()->SetSpeakerVolume(vol);
    
    [self check:error isBack:true];
}

// 设置语音音量
-(void)setSpeakerVolume:(NSDictionary *)dict
{
    NSDictionary* args = [dict objectForKey:@"param"];
    self.callBackData = dict;
    int vol = [[args objectForKey:@"vol"] intValue];
    GCloudVoiceErrno error = GetVoiceEngine()->SetSpeakerVolume(vol);
    [self check:error isBack:true];
}

// 获取语音
-(void)getSpeakerLevel:(NSDictionary *)dict
{
    NSDictionary* args = [dict objectForKey:@"param"];
    self.callBackData = dict;
    int vol = GetVoiceEngine()->GetSpeakerLevel();
    NSDictionary* result = @{
                             @"status":@"ok",
                             @"vol":@(vol),
                             };
    [self callBack:result];
}

// 加入房间
-(void)jionTeamRoom:(NSDictionary *)dict
{
    NSDictionary* args = [dict objectForKey:@"param"];
    self.callBackData = dict;
    NSString* roomID = [args objectForKey:@"roomID"];
    GCloudVoiceErrno error = GetVoiceEngine()->JoinTeamRoom([roomID cStringUsingEncoding:NSUTF8StringEncoding]);
    [self check:error isBack:false];
}

// 加入房间
-(void)joinNationalRoom:(NSDictionary *)dict
{
    NSDictionary* args = [dict objectForKey:@"param"];
    self.callBackData = dict;
    NSString* roomID = [args objectForKey:@"roomID"];
    int roleType = [[args objectForKey:@"roleType"] intValue];
    
    IGCloudVoiceEngine::GCloudVoiceMemberRole role = IGCloudVoiceEngine::Anchor;
    if (roleType == 2)
    {
        role = IGCloudVoiceEngine::Audience;
    }
    GCloudVoiceErrno error = GetVoiceEngine()->JoinNationalRoom([roomID UTF8String], role);
    [self check:error isBack:false];
}

// 加入房间
-(void)joinFMRoom:(NSDictionary *)dict
{
    NSDictionary* args = [dict objectForKey:@"param"];
    self.callBackData = dict;
    NSString* roomID = [args objectForKey:@"roomID"];
    GCloudVoiceErrno error = GetVoiceEngine()->JoinFMRoom([roomID UTF8String]);
    [self check:error isBack:false];
}

// 退出房间
-(void)quickRoom:(NSDictionary *) dict
{
    NSDictionary* args = [dict objectForKey:@"param"];
    self.callBackData = dict;
    NSString* roomID = [args objectForKey:@"roomID"];
    GCloudVoiceErrno error = GetVoiceEngine()->QuitRoom([roomID UTF8String]);
    [self check:error isBack:false];
}

// 打开麦克风(同时发送语音)
-(void)openMic:(NSDictionary *) dict
{
    self.callBackData = dict;
    GCloudVoiceErrno error = GetVoiceEngine()->OpenMic();
    [self check:error isBack:true];
}

// 关闭麦克风(同时关闭声音数据)Close players's micro phone and stop to send player's voice data.
-(void)closeMic:(NSDictionary *) dict
{
    self.callBackData = dict;
    GCloudVoiceErrno error = GetVoiceEngine()->CloseMic();
    [self check:error isBack:true];
}

// 打开扬声器
-(void)openSpeaker:(NSDictionary *) dict
{
    self.callBackData = dict;
    GCloudVoiceErrno error = GetVoiceEngine()->OpenSpeaker();
    [self check:error isBack:true];
}

// 关闭扬声器
-(void)closeSpeaker:(NSDictionary *) dict
{
    self.callBackData = dict;
    GCloudVoiceErrno error = GetVoiceEngine()->CloseSpeaker();
    [self check:error isBack:true];
}

// 申请离线语音
-(void)applyMessageKey:(NSDictionary *) dict
{
    self.callBackData = dict;
    GCloudVoiceErrno error = GetVoiceEngine()->ApplyMessageKey();
    [self check:error isBack:false];
}

// MAX录音时间(毫秒)
-(void)maxLength:(NSDictionary *) dict
{
    NSDictionary* args = [dict objectForKey:@"param"];
    self.callBackData = dict;
    int max = [[args objectForKey:@"max"] intValue];
    GCloudVoiceErrno error = GetVoiceEngine()->SetMaxMessageLength(max);
    [self check:error isBack:true];
}

// 开始录音
-(void)startRecording:(NSDictionary *) dict
{
    NSDictionary* args = [dict objectForKey:@"param"];
    self.callBackData = dict;
    NSString* path   = [args objectForKey:@"path"];
    GCloudVoiceErrno error = GetVoiceEngine()->StartRecording([path UTF8String]);
    [self check:error isBack:true];
}

// 停止录音
-(void)stopRecording:(NSDictionary *) dict
{
    self.callBackData = dict;
    GCloudVoiceErrno error = GetVoiceEngine()->StopRecording();
    [self check:error isBack:true];
}

// 上传文件
-(void)uploadFile:(NSDictionary *) dict
{
    NSDictionary* args = [dict objectForKey:@"param"];
    self.callBackData = dict;
    NSString* path   = [args objectForKey:@"path"];
    GCloudVoiceErrno error = GetVoiceEngine()->UploadRecordedFile([path UTF8String]);
    [self check:error isBack:false];
}

// 下载文件
-(void)downFile:(NSDictionary *) dict
{
    NSDictionary* args = [dict objectForKey:@"param"];
    self.callBackData = dict;
    NSString* fileID = [args objectForKey:@"fileID"];
    NSString* path   = [args objectForKey:@"path"];
    GCloudVoiceErrno error = GetVoiceEngine()->DownloadRecordedFile([fileID UTF8String], [path UTF8String]);
    [self check:error isBack:false];
}

// 播放文件
-(void)playFile:(NSDictionary *) dict
{
    NSDictionary* args = [dict objectForKey:@"param"];
    self.callBackData = dict;
    NSString* path = [args objectForKey:@"path"];
    GCloudVoiceErrno error = GetVoiceEngine()->PlayRecordedFile([path UTF8String]);
    [self check:error isBack:false];
}

// 停止播放文件
-(void)stopPlayFile:(NSDictionary *) dict
{
    self.callBackData = dict;
    GCloudVoiceErrno error = GetVoiceEngine()->StopPlayFile();
    [self check:error isBack:true];
}

// 语音转文字（中文）
-(void)speechToText:(NSDictionary *) dict
{
    NSDictionary* args = [dict objectForKey:@"param"];
    self.callBackData = dict;
    NSString* fileID = [args objectForKey:@"fileID"];
    GCloudVoiceErrno error = GetVoiceEngine()->SpeechToText([fileID UTF8String]);
    [self check:error isBack:false];
}

-(void)onResume
{
    GetVoiceEngine()->Resume();
}

-(void)onPause
{
    GetVoiceEngine()->Pause();
}

+ (GVoiceInfo *) getInstance
{
    return instance;
}

// 判断接口返回参数
- (bool)check:(GCloudVoiceErrno) error isBack:(bool)back
{
    if(GCLOUD_VOICE_SUCC == error){
        if(back)
        {
            NSDictionary* result = @{
                @"status":@"ok"
            };
            [self callBack:result];
        }
        return false;
    }
    
    NSDictionary* result = @{
        @"status":@"fail",
        @"error":[NSString stringWithFormat:@"%u", error]
    };
    [self callBack:result];
    
    return true;
}

- (void) callBack:(NSDictionary *)dict
{
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    NSString* roleData = [[NSString alloc] initWithData:jsonData encoding: NSUTF8StringEncoding];
    [LuaFunc callBack:callBackData param:roleData];
}
@end
