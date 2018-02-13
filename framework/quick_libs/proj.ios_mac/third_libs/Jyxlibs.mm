//
//  HelpShiftInfo.m
//  sgws
//
//  Created by fd on 16/5/10.
//
//

#import <Foundation/Foundation.h>

#import "Jyxlibs.h"

static Jyxlibs* _instance = nil;

@implementation Jyxlibs

+(Jyxlibs *)shareInstance
{
    if(_instance == nil)
    {
        _instance = [[self alloc] init];
    }
    
    return _instance;
}

-(void)init:(SDKBase *)sdk launch:(NSDictionary *) launchOptions
{
    [[UIApplication sharedApplication] setStatusBarHidden: YES];
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
    
    [LuaCall init];
    Notis* notis = [[Notis alloc] init];
    DataEyeInfo* dataeye = [[DataEyeInfo alloc] init];
    
    [LuaCall add:notis withKey:@"Notis"];
    [LuaCall add:sdk withKey:@"SDK"];
    [LuaCall add:dataeye withKey:@"DataEyeInfo"];
    
    // 平台名字
    NSString* platformName = [sdk platformName];

    // JPUSH
    JpushInfo* jpush = [[JpushInfo alloc] init:launchOptions
                key:[sdk jpush_key]
            channel:platformName
       isProduction:[sdk jpush_isProduction]];
    
    [LuaCall add:jpush withKey:@"JpushInfo"];
    
    // 语音
    GVoiceInfo* gVoice = [[GVoiceInfo alloc] init:[sdk gVoiceAppId]
                                              key:[sdk gVoiceAppKey]];
    
    [LuaCall add:gVoice withKey:@"GVoiceInfo"];
}

-(void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

-(void)handleRemoteNotification:(NSDictionary *)userInfo {
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)onResume:(UIApplication *)application
{
    [JPUSHService removeNotification:nil]; // 删除所有本地推送
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [[GVoiceInfo getInstance] onResume];
}

- (void)onPause:(UIApplication *)application
{
    [[GVoiceInfo getInstance] onPause];
}

-(void)showLocalNotificationAtFront:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

@end
