//
//  LuaFunc.m
//  sds
//
//  Created by langqi on 15/3/4.
//
//

#import "LuaFunc.h"
#import "extra/platform/ios/json/SBJSON.h"

@implementation LuaFunc

// 调用LUA接口
+(void)callFunc:(NSString *)method param:(NSString *)args
{
    LuaEngine* pEngine = LuaEngine::getInstance();
    LuaStack * pStack = pEngine->getLuaStack();
    lua_State* l = pStack->getLuaState();
    lua_getglobal(l, [method UTF8String]);
    const char* stringValue = [args UTF8String];
    pStack->pushString(stringValue);
    pStack->executeFunction(1);
}

// 重登
+(void)relogin
{
    [LuaFunc callFunc:@"relogin" param:@""];
}

// 调用IOS接口
+(void)callBack:(NSDictionary *)input param:(NSString *)param
{
    if(![[input allKeys] containsObject:@"rhand"]){
        NSLog(@"call back not find rhand");
        return;
    }
    
    int rhand = (int)[[input objectForKey:@"rhand"] integerValue];
    LuaBridge::pushLuaFunctionById(rhand);
    LuaStack* stack = LuaBridge::getStack();
    const char* stringValue = [param UTF8String];
    stack->pushString(stringValue);
    stack->executeFunction(1);
    LuaBridge::releaseLuaFunctionById(rhand);
}

+(void)callBackArr:(NSDictionary *)input param:(NSArray *)paramValue
{
    SBJsonWriter* writer = [[SBJsonWriter alloc] init];
    NSString* ret = [writer stringWithObject:paramValue];
    
    [LuaFunc callBack:input param:ret];
}

+(void)callBackDict:(NSDictionary *)input param:(NSDictionary *)paramValue
{
    SBJsonWriter* writer = [[SBJsonWriter alloc] init];
    NSString* ret = [writer stringWithObject:paramValue];
    
    [LuaFunc callBack:input param:ret];
}

@end
