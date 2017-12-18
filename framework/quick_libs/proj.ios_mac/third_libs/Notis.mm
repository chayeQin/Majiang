//
//  Notis.m
//  liaoyuan
//
//  Created by langqi on 14-4-14.
//
//
#import "Notis.h"
#import <net/if.h>
#import <net/if_dl.h>
#import <sys/socket.h>
#import <sys/sysctl.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation Notis

// 评论
+(void)like
{
    
}

// 分享
+(void)share:(NSDictionary *)args
{
    
}

// 震动
+(void)shake:(NSDictionary *)args
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

// 提醒
+(void)notis:(NSDictionary *)args
{
    NSDictionary* dict = [args objectForKey:@"param"];
    NSString *msg = [dict objectForKey:@"msg"];
    float time = [[dict objectForKey:@"m_time"] floatValue];
    
    UILocalNotification * localNotis = [[UILocalNotification alloc] init];
    if (!localNotis) {
        return;
    }
    NSDate *m_time = [NSDate new];
    localNotis.fireDate = [m_time dateByAddingTimeInterval:time]; // 6秒后
    localNotis.repeatInterval = 0 ;// kCFCalendarUnitWeekday 一周一次
    
    localNotis.timeZone = [NSTimeZone defaultTimeZone];
    localNotis.soundName = UILocalNotificationDefaultSoundName;
    localNotis.alertBody = msg;
    
    //    notis.alertAction = @"打开";
    //    notis.hasAction = YES;
    
    localNotis.applicationIconBadgeNumber = 1;
    
    // 接收消息
    //    NSDictionary *infoDic = [NSDictionary dictionaryWithObject:@"value" forKey:@"key"];
    //    notis.userInfo = infoDic;
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotis];
}

// 播放视频
+(void)play:(NSDictionary *)args
{
}

-(void)openUrl:(NSDictionary *)args
{
    NSDictionary* dict = [args objectForKey:@"param"];
    NSString* str = [dict objectForKey:@"url"];
    NSLog(@"url info ...... %@", str);
    NSURL *url = [NSURL URLWithString:str];
    [[UIApplication sharedApplication] openURL:url];
}




@end
