//
//  jyxlibs.h
//  sgws
//
//  Created by fd on 16/8/10.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// cocos
#import "cocos2d.h"
#import "CCLuaEngine.h"
#import "LuaCall.h"
#import "extra/platform/ios/json/SBJSON.h"

// 第三方
#import "jpush/JPUSHService.h"

// 自己
#import "SDKBase.h"
#import "LuaCall.h"
#import "Notis.h"
#import "DataEyeInfo.h"
#import "JpushInfo.h"
#import "GVoice/GVoiceInfo.h"

@interface Jyxlibs : NSObject
{
}

+(Jyxlibs *)shareInstance;
@end
