//
//  SDK.m
//  xjmh
//
//  Created by fd on 16/1/25.
//
//

#import "SDK.h"

#import "LuaCall.h"

@implementation SDK

@synthesize iospay;
@synthesize iapPrice;

-(id)init
{
    self = [super init];
  
    
    return self;
}

-(NSString*)platformName
{
    return @"demo";
}

-(NSString*)jpush_key
{
    return @"7719b65de118ee1a7026d925";
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
    
}

-(void)newUser:(NSDictionary *)args
{
    [super newUser:args];
    
    
}

-(void)guideEnd:(NSDictionary *)args
{
    [super guideEnd:args];
    
    
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
	
}
	
- (void)CGSkip:(NSDictionary*)args
{
	
}
	
- (void)CGComlete:(NSDictionary*)args
{
	
}
	
- (void)FlagSelect:(NSDictionary*)args
{
	
}
	
- (void)FirstTask:(NSDictionary*)args
{
	
}
	
- (void)Fort:(NSDictionary*)args
{
    NSDictionary* dict = [args objectForKey:@"param"];
    
    int fortLevel = [[dict objectForKey:@"fortLevel"] intValue];
	
    
}

// 登陆完胜，开始加载用户数据（上传数据到sdk）
-(void)post:(NSDictionary *)args
{
    
}

-(void)login:(NSDictionary*)args
{
    
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
    
}

// 支付回调
- (void)payCallBack:(int) state;
{
    NSLog(@"pay call back %d", state);
    if(state == 0){ // success
		double price = self.iapPrice / 100.0;
        
    }
    else // fail
    {
        
    }
}

@end
