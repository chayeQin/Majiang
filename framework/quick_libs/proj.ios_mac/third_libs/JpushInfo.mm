#import "JpushInfo.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@implementation JpushInfo

-(id)init:(NSDictionary *)launchingOption key:(NSString *)key channel:(NSString *)channel isProduction:(bool)isProduction
{
    self = [super init];
    
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    //Required
    // init Push(2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil  )
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchingOption
                           appKey:key
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];
    
    [JPUSHService crashLogON];
    
    return self;
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
//        NSLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        
//        UIViewController *rootViewController = [[UIApplication sharedApplication] keyWindow].rootViewController;
//        [rootViewController addNotificationCount];
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
//        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        
//        UIViewController *rootViewController = [[UIApplication sharedApplication] keyWindow].rootViewController;
//        [rootViewController addNotificationCount];
        
    }
    else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}

// 开启推送
- (void)open:(NSDictionary *)args
{
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound |
                                                        UIUserNotificationTypeAlert)
                                                categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                            UIRemoteNotificationTypeSound |
                                                            UIRemoteNotificationTypeAlert)
                                                  categories:nil];
    }
    
    [LuaFunc callBack:args param:@""];
}

// 检查是否打开
- (void)check:(NSDictionary *)args
{
    NSString* result = @"true";
    
    if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
        if ([[UIApplication sharedApplication] currentUserNotificationSettings].types  == UIRemoteNotificationTypeNone) {
            result = @"false";
        }
    }else{
        if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes]  == UIRemoteNotificationTypeNone)
        {
            result = @"false";
        }
    }
    
    [LuaFunc callBack:args param:result];
}

// 打开设置界面
- (void)openSet:(NSDictionary *)args
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
}

- (void)send:(NSDictionary *)args
{
    NSDictionary* dict = [args objectForKey:@"param"];
    NSString* body = [dict objectForKey:@"body"];
    int delay = [[dict objectForKey:@"delay"] intValue];
    
    UILocalNotification * localNotis = [[UILocalNotification alloc] init];
    if (!localNotis) {
        return;
    }
    
    NSDate *m_time = [NSDate new];
    localNotis.fireDate = [m_time dateByAddingTimeInterval:delay]; // x秒后
    localNotis.repeatInterval = 0 ;// kCFCalendarUnitWeekday 一周一次
    
    localNotis.timeZone = [NSTimeZone defaultTimeZone];
    localNotis.soundName = UILocalNotificationDefaultSoundName;
    localNotis.alertBody = body;
    
    localNotis.applicationIconBadgeNumber = 1;
    
    // 接收消息
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotis];
}

#endif

@end
