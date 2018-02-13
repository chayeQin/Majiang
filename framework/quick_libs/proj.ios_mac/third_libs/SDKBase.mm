#import "SDKBase.h"

@implementation SDKBase

-(NSString*)platformName
{
    return @"sdk base";
}

// 程序版本号
-(NSString*)ver
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

-(NSString*)mac
{
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

-(void)platform:(NSDictionary*)args
{
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [self platformName], @"name",
                          [self mac], @"mac",
                          [self ver], @"version",
                          @([self isTw]), @"isTw",
                          [NSNumber numberWithInt:1],@"notisGift",
                          @"yes",@"GVoice",
                          nil];
    
    SBJsonWriter* writer = [[SBJsonWriter alloc] init];
    NSString* ret = [writer stringWithObject:dict];
    
    [LuaFunc callBack:args param:ret];
}

-(NSString*)jpush_key
{
    return @"";
}

-(NSString*)gVoiceAppId
{
    return @"";
}
-(NSString*)gVoiceAppKey
{
    return @"";
}

// true 为正式环境
-(bool)jpush_isProduction
{
    return true;
}

-(bool)isTw
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    //zh-Hant-HK
    NSRange range = [currentLanguage rangeOfString:@"Hant"];
    return range.location != NSNotFound;
}

// 上传数据到sdk
-(void)post:(NSDictionary *)args
{
}

-(void)login:(NSDictionary*)args
{
}

-(void)logout:(NSDictionary*)args
{
}

-(void)autologin:(NSDictionary*)args
{
}

-(void)pay:(NSDictionary*)dict
{
}

-(void)newUser:(NSDictionary *)args
{
}

-(void)guideEnd:(NSDictionary *)args
{
}

// 完成登陆
- (void)loginComplete:(NSDictionary*)args
{
}

// 更新开始
- (void)updateStart:(NSDictionary*)args
{
}

// 更新完成
- (void)updateComplete:(NSDictionary*)args
{
}
@end
