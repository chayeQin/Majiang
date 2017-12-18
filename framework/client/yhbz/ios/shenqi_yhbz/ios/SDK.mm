//
//  SDK.m
//  xjmh
//
//  Created by fd on 16/1/25.
//
//

#import "SDK.h"
#import "FBInvite.h"
#import "LuaCall.h"

#import "AppsFlyerLib/AppsFlyerUtil.h"
@implementation SDK

@synthesize iospay;
@synthesize iapPrice;

-(id)init
{
    self = [super init];
    self.iospay = [[IOSPay alloc] init];
    self.iospay.delegate = self;
    self.iospay.webUrl = @"http://zd1-yhbz.awwgc.com:8080/ws/";
    
    //appsflyer 初始化广告参数
    [AppsFlyerUtil initSdk:@"1237073611" appKey:@"LSybMALiYuNKWMm3RnC6XT" currencyCode:@"USD"];
    FBInvite* invite = [[FBInvite alloc] init];
    [LuaCall add:invite withKey:@"FBInvite"];

    [FBInvite startUp];
    [AppsFlyerUtil startUp];
    return self;
}

-(NSString*)platformName
{
    return @"mocheng01i";
}

-(NSString*)jpush_key
{
    return @"e8f39d736cb79ab9b3d7cba6";
}
-(NSString*)gVoiceAppId
{
    return @"1935585816";
}
-(NSString*)gVoiceAppKey
{
    return @"388c97f1364b2f86712e2e9c2fd38b69";
}

-(void)payUrl:(NSDictionary *)args
{
    NSDictionary* param = [args objectForKey:@"param"];
    self.iospay.webUrl = [param objectForKey:@"url"];
}

-(void)newUser:(NSDictionary *)args
{
    [super newUser:args];
    
    [FBInvite newUser];
}

-(void)guideEnd:(NSDictionary *)args
{
    [super guideEnd:args];
    
    [FBInvite guideEnd];
}

// 完成登陆
- (void)loginComplete:(NSDictionary*)dict
{
    [super loginComplete:dict];
}

// 更新开始
- (void)updateStart:(NSDictionary*)dict
{
    [super updateStart:dict];
}

// 更新完成
- (void)updateComplete:(NSDictionary*)dict
{
    [super updateComplete:dict];
}

- (void)CGStart:(NSDictionary*)args
{
	[FBInvite CGStart];
	[AppsFlyerUtil CGStart];
}
	
- (void)CGSkip:(NSDictionary*)args
{
	[FBInvite CGSkip];
	[AppsFlyerUtil CGSkip];
}
	
- (void)CGComlete:(NSDictionary*)args
{
	[FBInvite CGComlete];
	[AppsFlyerUtil CGComlete];
}
	
- (void)FlagSelect:(NSDictionary*)args
{
	[FBInvite FlagSelect];
	[AppsFlyerUtil FlagSelect];
}
	
- (void)FirstTask:(NSDictionary*)args
{
	[FBInvite FirstTask];
	[AppsFlyerUtil FirstTask];
}
	
- (void)selectLangShow:(NSDictionary*)args
{
	[AppsFlyerUtil selectLangShow];
}
	
- (void)selectLangClick:(NSDictionary*)args
{
	[AppsFlyerUtil selectLangClick];
}
	
- (void)selectLangClose:(NSDictionary*)args
{
	[AppsFlyerUtil selectLangClose];
}

- (void)Fort:(NSDictionary*)args
{
    NSDictionary* dict = [args objectForKey:@"param"];
    
    int fortLevel = [[dict objectForKey:@"fortLevel"] intValue];
	
    [FBInvite Fort:fortLevel];
    [AppsFlyerUtil Fort:fortLevel];
}

// 登陆完胜，开始加载用户数据（上传数据到sdk）
-(void)post:(NSDictionary *)args
{
    [FBInvite login];
    [AppsFlyerUtil login];
}

-(void)login:(NSDictionary*)args
{
    [FBInvite sdkLogin:args];
}

-(void)logout:(NSDictionary*)args
{
}

-(void)pay:(NSDictionary*)args
{
    NSDictionary* dict = [args objectForKey:@"param"];
    
    NSLog(@"Pay info %@", dict);
    NSString* sid = [dict objectForKey:@"sid"];
    NSString* sname = [dict objectForKey:@"sname"];
    NSString* uid = [dict objectForKey:@"uid"];
    NSString* uname = [dict objectForKey:@"uname"];
    NSString* puid = [dict objectForKey:@"puid"];
    NSDictionary* item = [dict objectForKey:@"item"];
    NSString* itemId = [item objectForKey:@"id"];
    int payType = [[item objectForKey:@"payType"] intValue];
    NSString* product_name = [item objectForKey:@"name"];
    NSString* price = [item objectForKey:@"price"];
    NSString* iap = [item objectForKey:@"iap"];
    
    int rnd = [[NSDate date] timeIntervalSince1970];
    NSString *param = [NSString stringWithFormat:@"%@_%@_%d_%@_%@_%@_%d",sid, uid, payType,itemId, price, [self platformName], rnd];
    
    self.iapPrice = [price doubleValue];
    
    [self.iospay pay:iap param:param];
}

// 支付回调
- (void)payCallBack:(int) state;
{
    NSLog(@"pay call back %d", state);
    if(state == 0){ // success
		double price = self.iapPrice / 100.0;
        [FBInvite paySuccess:price currency:@"USD"];
        [AppsFlyerUtil paySuccess:price];
    }
    else // fail
    {
        [FBInvite payFail];
        [AppsFlyerUtil payFail];
    }
}

@end
