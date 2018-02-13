#import <Foundation/Foundation.h>
#import <Foundation/NSObject.h>
#import <Foundation/NSNotification.h>
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>

#import "LuaFunc.h"
#import "extra/platform/ios/json/SBJSON.h"

@interface SDKBase : NSObject
{
}

-(NSString*)platformName;

// 程序版本号
-(NSString*)ver;

-(NSString*)mac;

-(void)platform:(NSDictionary*)args;

-(NSString*)jpush_key;

-(NSString*)gVoiceAppId;
-(NSString*)gVoiceAppKey;

// true 为正式环境
-(bool)jpush_isProduction;

// 上传数据到sdk
-(void)post:(NSDictionary *)args;

-(void)login:(NSDictionary*)args;

-(void)logout:(NSDictionary*)args;

-(void)autologin:(NSDictionary*)args;

-(void)pay:(NSDictionary*)dict;

-(void)newUser:(NSDictionary *)args;

-(void)guideEnd:(NSDictionary *)args;

// 完成登陆
- (void)loginComplete:(NSDictionary*)dict;

// 更新开始
- (void)updateStart:(NSDictionary*)dict;

// 更新完成
- (void)updateComplete:(NSDictionary*)dict;

@end
