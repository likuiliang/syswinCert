//
//  TSBManager.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/24.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TSBManager.h"
#include <TSB/tsbApi.h>
#include <TSB/tsbCommonApi.h>
#include <TSB/algApi.h>

using namespace tsb;
using namespace ALG;
//using namespace cdtp;

static NSString *_workspace;
static NSString *loginPwd;
static NSString *safePwd;

@implementation TSBManager

long keyCallback(std::string tid, long code, std::string &key, tsb::tsbPwd type) {
    key = "111111";
    return code;
}

+ (BOOL)loginWithPwd:(NSString *)pwd withError:(NSError **)error
{
    
    loginPwd = pwd;
    
    tsb::setTSBSDKFolder(NSStr_TO_CStr(TSBManager.getWorkspace));
    tsb::setCallBack(keyCallback);
//
    shared_ptr<tsb::ITSBSDK> itsbsdk = tsb::initTSBSDK("syswin_tsb_pwd_initializer", tsb::TECC);
    
    if (itsbsdk != nullptr)
        return YES;
    else
    {
        long code = tsb::getLatestErrCode();
        if (error != NULL)
        {
            *error = [NSError errorWithDomain:NSStringFromClass(self.class) code:code userInfo:@{NSLocalizedDescriptionKey: @"tsb internal error"}];
        }
        return NO;
    }
    
    return NO;
}

+ (NSString *_Nonnull)getWorkspace {
    if (!_workspace) {
        NSString *libraryDirectory = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
        NSString *path = @"Chat";
        _workspace = [NSString stringWithFormat:@"%@/%@/msgseal", libraryDirectory, path];
        BOOL isDirectory;
        if (![[NSFileManager defaultManager] fileExistsAtPath:_workspace isDirectory:&isDirectory] || !isDirectory) {
            [[NSFileManager defaultManager] createDirectoryAtPath:_workspace withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return _workspace;
}

+ (NSString *)getEccPubKey:(NSString *)temail
{
    shared_ptr<tsb::ITSBSDK> sdk = initTSBSDK(NSStr_TO_CStr(temail), TECC);
    if (sdk)
    {
        BufferArray pubBuffer;
        std::string time;
        int64_t code = sdk->tsbGetPubKey(pubBuffer, time);
        if (code == ERR_SUCCESS)
        {
            std::string pub(pubBuffer.begin(), pubBuffer.end());
            return CStr_TO_NSStr(pub);
        }
    }
    return nil;
}

// hash 值
+ (NSString *)sm3:(NSString *)data
{
    string md;
    sm3(NSStr_TO_CStr(data), md);
    
    return CStr_TO_NSStr(md);
}

+ (NSString *)eccSign:(NSString *)raw withTemail:(NSString *)temail
{
    shared_ptr<tsb::ITSBSDK> sdk = initTSBSDK(NSStr_TO_CStr(temail), TECC);
    if (sdk)
    {
        std::string rawStr = NSStr_TO_CStr(raw);
        BufferArray rawBuffer(rawStr.begin(), rawStr.end());
        BufferArray sigBuffer;
        if (ERR_SUCCESS == sdk->tsbSignature(rawBuffer, sigBuffer))
        {
            std::string sign(sigBuffer.begin(), sigBuffer.end());
            return CStr_TO_NSStr(sign);
        }
    }
    return nil;
}


+ (BOOL)eccVerifySign:(NSString *)sign withRaw:(NSString *)raw withKey:(NSString *)key
{
    shared_ptr<tsb::ITSBSDK> itsbsdk = tsb::initTSBSDK("syswin_tsb_pwd_initializer", tsb::TECC);
    if (itsbsdk)
    {
        std::string rawStr = NSStr_TO_CStr(raw);
        BufferArray rawBuffer(rawStr.begin(), rawStr.end());
        
        std::string signStr = NSStr_TO_CStr(sign);
        BufferArray signBuffer(signStr.begin(), signStr.end());
        
        std::string keyStr = NSStr_TO_CStr(key);
        
        return ERR_SUCCESS == itsbsdk->tsbVerifySignature(rawBuffer, signBuffer, keyStr.c_str());
    }
    
    return false;
    
}

@end
