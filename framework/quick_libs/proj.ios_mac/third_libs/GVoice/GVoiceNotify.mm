//
//  GVoiceNotify.cpp
//  quick_libs
//
//  Created by fd on 2017/6/20.
//  Copyright © 2017年 chukong. All rights reserved.
//

#include "GVoiceNotify.h"

GVoiceNotify::GVoiceNotify()
{
    
}

/**
 * Callback when JoinXxxRoom successful or failed.
 *
 * @param code : a GCloudVoiceCompleteCode code . You should check this first.
 * @param roomName : name of your joining, should be 0-9A-Za-Z._- and less than 127 bytes
 * @param memberID : if success, return the memberID
 */
void GVoiceNotify::OnJoinRoom(GCloudVoiceCompleteCode code, const char *roomName, int memberID)
{
    NSDictionary* result = nil;
    if (code == GV_ON_JOINROOM_SUCC) {
        result = @{
            @"status":@"ok",
            @"rootName":[NSString stringWithUTF8String:roomName],
            @"memberID":[NSString stringWithFormat:@"%d", memberID],
            };
    } else {
        result = @{
                   @"status":@"fail",
                   @"rootName":[NSString stringWithUTF8String:roomName],
            };
    }
    
    [[GVoiceInfo getInstance] callBack:result];
}

/**
 * Callback when dropped from the room
 *
 * @param code : a GCloudVoiceCompleteCode code . You should check this first.
 * @param roomName : name of your joining, should be 0-9A-Za-Z._- and less than 127 bytes
 * @param memberID : if success, return the memberID
 */
void GVoiceNotify::OnStatusUpdate(GCloudVoiceCompleteCode status, const char *roomName, int memberID)
{
    NSLog(@"OnStatusUpdate %u %s %d", status, roomName, memberID);
}

/**
 * Callback when QuitRoom successful or failed.
 *
 * @param code : a GCloudVoiceCompleteCode code . You should check this first.
 * @param roomName : name of your joining, should be 0-9A-Za-Z._- and less than 127 bytes
 */
void GVoiceNotify::OnQuitRoom(GCloudVoiceCompleteCode code, const char *roomName)
{
    NSDictionary* result = nil;
    if (code == GV_ON_QUITROOM_SUCC) {
        result = @{
                   @"status":@"ok",
                   @"rootName":[NSString stringWithUTF8String:roomName],
                   };
    } else {
        result = @{
                   @"status":@"fail",
                   @"rootName":[NSString stringWithUTF8String:roomName],
                   };
    }
    
    [[GVoiceInfo getInstance] callBack:result];
}

/**
 * Callback when someone saied or silence in the same room.
 *
 * @param count: count of members who's status has changed.
 * @param members: a int array composed of [memberid_0, status,memberid_1, status ... memberid_2*count, status]
 * here, status could be 0, 1, 2. 0 meets silence and 1/2 means saying
 */
void GVoiceNotify::OnMemberVoice	(const unsigned int *members, int count)
{
    NSLog(@"OnMemberVoice count = %d", count);
//    for(int i = 0; i < count ; i++)
//    {
//        const unsigned int memberId = members[i * 2];
//        const unsigned int memberStatus = members[i * 2 + 1];
//    }
}

// Voice Message Callback
/**
 * Callback when upload voice file successful or failed.
 *
 * @param code: a GCloudVoiceCompleteCode code . You should check this first.
 * @param filePath: file to upload
 * @param fileID: if success ,get back the id for the file.
 */
void GVoiceNotify::OnUploadFile(GCloudVoiceCompleteCode code, const char *filePath, const char *fileID)
{
    NSDictionary* result = nil;
    if (code == GV_ON_UPLOAD_RECORD_DONE) {
        result = @{
                   @"status":@"ok",
                   @"filePath":[NSString stringWithUTF8String:filePath],
                   @"fileID":[NSString stringWithUTF8String:fileID],
                   };
    } else {
        result = @{
                   @"status":@"fail",
                   @"filePath":[NSString stringWithUTF8String:filePath],
                   };
    }
    
    [[GVoiceInfo getInstance] callBack:result];
}

/**
 * Callback when download voice file successful or failed.
 *
 * @param code: a GCloudVoiceCompleteCode code . You should check this first.
 * @param filePath: file to download to .
 * @param fileID: if success ,get back the id for the file.
 */
void GVoiceNotify::OnDownloadFile(GCloudVoiceCompleteCode code, const char *filePath, const char *fileID)
{
    NSDictionary* result = nil;
    if (code == GV_ON_DOWNLOAD_RECORD_DONE) {
        result = @{
                   @"status":@"ok",
                   @"filePath":[NSString stringWithUTF8String:filePath],
                   @"fileID":[NSString stringWithUTF8String:fileID],
                   };
    } else {
        result = @{
                   @"status":@"fail",
                   @"filePath":[NSString stringWithUTF8String:filePath],
                   };
    }
    
    [[GVoiceInfo getInstance] callBack:result];
}

/**
 * Callback when finish a voice file play end.
 *
 * @param code: a GCloudVoiceCompleteCode code . You should check this first.
 * @param filePath: file had been plaied.
 */
void GVoiceNotify::OnPlayRecordedFile(GCloudVoiceCompleteCode code,const char *filePath)
{
    NSDictionary* result = nil;
    if (code == GV_ON_PLAYFILE_DONE) {
        result = @{
                   @"status":@"ok",
                   @"filePath":[NSString stringWithUTF8String:filePath],
                   };
    } else {
        result = @{
                   @"status":@"fail",
                   @"filePath":[NSString stringWithUTF8String:filePath],
                   };
    }
    
    [[GVoiceInfo getInstance] callBack:result];
}

/**
 * Callback when query message key successful or failed.
 *
 * @param code: a GCloudVoiceCompleteCode code . You should check this first.
 */
void GVoiceNotify::OnApplyMessageKey(GCloudVoiceCompleteCode code)
{
    NSDictionary* result = nil;
    if (code == GV_ON_MESSAGE_KEY_APPLIED_SUCC) {
        result = @{
                   @"status":@"ok",
                   };
    } else {
        result = @{
                   @"status":@"fail",
                   };
    }
    
    [[GVoiceInfo getInstance] callBack:result];
}

// Translate
/**
 * Callback when translate voice to text successful or failed.
 *
 * @param code: a GCloudVoiceCompleteCode code . You should check this first.
 * @param fileID : file to translate
 * @param result : the destination text of the destination language.
 */
void GVoiceNotify::OnSpeechToText(GCloudVoiceCompleteCode code, const char *fileID, const char *result)
{
    NSDictionary* result2 = nil;
    if (code == GV_ON_STT_SUCC) {
        result2 = @{
                   @"status":@"ok",
                   @"fileID":[NSString stringWithUTF8String:fileID],
                   @"result":[NSString stringWithUTF8String:result],
                   };
    } else {
        result2 = @{
                   @"status":@"fail",
                   };
    }
    
    [[GVoiceInfo getInstance] callBack:result2];
}

/**
 * Callback when client is using microphone recording audio
 *
 * @param pAudioData : audio data pointer
 * @param nDataLength : audio data length
 * @param result : void
 */
void GVoiceNotify::OnRecording(const unsigned char* pAudioData, unsigned int nDataLength)
{
    NSLog(@"OnRecording length %d", nDataLength);
}
