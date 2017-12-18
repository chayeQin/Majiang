#ifndef SDK_h
#define SDK_h

#import <Foundation/Foundation.h>
#import "LuaFunc.h"
#import "SDKBase.h"
#import "store/IOSPay.h"

@interface SDK : SDKBase <IOSPayDelegate>
{
}

@property(nonatomic, readwrite) IOSPay* iospay;
@property(nonatomic, readwrite) double iapPrice;

@end

#endif /* SDK_h */
