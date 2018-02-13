//
//  LuaCall.m
//  xjmh
//
//  Created by fd on 16/1/26.
//
//

#import <Foundation/Foundation.h>
#import "LuaCall.h"
#import "extra/platform/ios/json/SBJSON.h"

@implementation LuaCall

static NSMutableDictionary* mDict = nil;

+(void) init
{
    if(mDict != nil){
        return;
    }
    mDict = [[NSMutableDictionary alloc]init];
}

+(void)add:(NSObject*)obj
   withKey:(NSString *)key
{
    [LuaCall init];
    [mDict setValue:obj forKey:key];
}

+(void)call:(NSDictionary *)args
{
    NSString *className = [args objectForKey:@"className"];
    NSString *method = [args objectForKey:@"method"];
    NSString* param = [args objectForKey:@"param"];
    
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    id rhand = [args objectForKey:@"rhand"];
    if (rhand != nil){
        [dict setObject:rhand forKey:@"rhand"];
    }
    [dict setObject:[parser objectWithString:[args objectForKey:@"param"]] forKey:@"param"];
    
    SEL func = NSSelectorFromString([NSString stringWithFormat:@"%@:", method]);
    NSLog(@"***args....: %@", args );
    NSObject* obj = [mDict objectForKey:className];
    if (obj && [obj respondsToSelector:func])
    {
        [obj performSelector:func withObject:dict];
    }
}

@end
