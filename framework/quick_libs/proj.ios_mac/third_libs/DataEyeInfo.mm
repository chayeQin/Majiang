//
//  Info.mm
//
//

#import "DataEyeInfo.h"

@implementation DataEyeInfo

// 上传数据
-(void)post:(NSDictionary *)args
{
    NSDictionary* dict = [args objectForKey:@"param"];
    
    NSString * uid = [dict objectForKey:@"uid"];
    int level = [[dict objectForKey:@"level"] intValue];
    
    // jpush tag
    NSString* sid = [NSString stringWithFormat:@"%@", [dict objectForKey:@"sid"]];
//    NSString* sname = [dict objectForKey:@"sname"];
    NSString* puid = [dict objectForKey:@"puid"];
    NSSet* set = [NSSet setWithObjects:sid, uid, puid, nil];
    NSSet* validSet = [JPUSHService filterValidTags:set];
    
    [JPUSHService setTags:validSet
                 alias:puid
      callbackSelector:@selector(tagsAliasCallback:tags:alias:)
                object:self];
}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

@end
