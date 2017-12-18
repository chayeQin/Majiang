//
//  GVoiceNotify.hpp
//  quick_libs
//
//  Created by fd on 2017/6/20.
//  Copyright © 2017年 chukong. All rights reserved.
//

#ifndef GVoiceNotify_hpp
#define GVoiceNotify_hpp

#import <Foundation/Foundation.h>
#include <stdio.h>
#import "include/GCloudVoice.h"
#import "GVoiceInfo.h"

using namespace gcloud_voice;

class GCLOUD_VOICE_API GVoiceNotify : public IGCloudVoiceNotify
{
public:
    GVoiceNotify();
public:
    virtual void OnJoinRoom(GCloudVoiceCompleteCode code, const char *roomName, int memberID) ;
    virtual void OnStatusUpdate(GCloudVoiceCompleteCode status, const char *roomName, int memberID) ;
    virtual void OnQuitRoom(GCloudVoiceCompleteCode code, const char *roomName) ;
    virtual void OnMemberVoice	(const unsigned int *members, int count) ;
    virtual void OnUploadFile(GCloudVoiceCompleteCode code, const char *filePath, const char *fileID) ;
    virtual void OnDownloadFile(GCloudVoiceCompleteCode code, const char *filePath, const char *fileID) ;
    virtual void OnPlayRecordedFile(GCloudVoiceCompleteCode code,const char *filePath) ;
    virtual void OnApplyMessageKey(GCloudVoiceCompleteCode code) ;
    virtual void OnSpeechToText(GCloudVoiceCompleteCode code, const char *fileID, const char *result) ;\
    virtual void OnRecording(const unsigned char* pAudioData, unsigned int nDataLength);
};

#endif /* GVoiceNotify_hpp */
