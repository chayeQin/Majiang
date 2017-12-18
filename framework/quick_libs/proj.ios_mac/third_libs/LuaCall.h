//
//  LuaCall.h
//  xjmh
//
//  Created by fd on 16/1/26.
//
//

#ifndef LuaCall_h
#define LuaCall_h

@interface LuaCall : NSObject
{
}

+(void)add:(NSObject*)obj
   withKey:(NSString*)key;

+(void)call:(NSDictionary*)args;

@end

#endif /* LuaCall_h */
