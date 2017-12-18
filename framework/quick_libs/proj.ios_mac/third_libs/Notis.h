//
//  Notis.h
//  liaoyuan
//
//  Created by langqi on 14-4-14.
//
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "cocos2d.h"
#import "CCLuaEngine.h"
#import "LuaFunc.h"

@interface Notis : NSObject
{
}

// 评论
+(void)like;

// 分享
+(void)share:(NSDictionary *)args;

// 震动
+(void)shake:(NSDictionary *)args;

// 提醒
+(void)notis:(NSDictionary *)args;

// 播放视频
+(void)play:(NSDictionary *)args;



@end
