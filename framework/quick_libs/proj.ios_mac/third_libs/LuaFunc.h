//
//  LuaFunc.m
//  sds
//
//  Created by langqi on 15/3/4.
//
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"
#import "CCLuaEngine.h"
#import "CCLuaBridge.h"

using namespace cocos2d;

@interface LuaFunc : NSObject
{
}

// 调用LUA借口
+(void)callFunc:(NSString *)method param:(NSString *)args;
+(void)relogin;

// 回调
+(void)callBack:(NSDictionary *)input param:(NSString *)param;

+(void)callBackArr:(NSDictionary *)input param:(NSArray *) param;
+(void)callBackDict:(NSDictionary *)input param:(NSDictionary *) param;

@end
