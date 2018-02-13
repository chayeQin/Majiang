#import <Foundation/Foundation.h>

#import "LuaFunc.h"
#import "SDKBase.h"

#import <UIKit/UIKit.h>
#import "include/GCloudVoice.h"
#import "GVoiceNotify.h"

using namespace gcloud_voice;

@interface GVoiceInfo : NSObject
{
}

@property(nonatomic, readwrite) NSString* appId;
@property(nonatomic, readwrite) NSString* appKey;
@property(nonatomic, readwrite) NSString* appOpenId;
@property(nonatomic, readwrite) NSTimer* pollTimer;
@property(nonatomic, readwrite) NSDictionary* callBackData;

+ (GVoiceInfo *) getInstance;
- (void) callBack:(NSDictionary *)dict;
@end
