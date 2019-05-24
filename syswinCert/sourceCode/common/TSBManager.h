//
//  TSBManager.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/24.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NSStr_TO_CStr(str) ((str.length > 0) ? str.UTF8String : "")
#define CStr_TO_NSStr(str) ((str.length() > 0) ? ([NSString stringWithCString:str.c_str() encoding:NSUTF8StringEncoding] ?: @"") : @"")

@interface TSBManager : NSObject

//+ (instancetype _Nonnull)sharedInstance;

@property(nonatomic, copy) NSString *uid;
@property(nonatomic, copy) NSString *version;
@property(nonatomic, copy) NSString *tips;
@property(nonatomic, assign) int64_t createtime;
+ (BOOL)loginWithPwd:(NSString *)pwd withError:(NSError **)error;

+ (NSString *)getEccPubKey:(NSString *)temail;

// 解密
+ (NSString *)eccDecryptData:(NSString *)temail encrypto:(NSString *)encrypto;

// 签名
+ (NSString *)eccSign:(NSString *)raw withTemail:(NSString *)temail;

// 验签  key:公钥  raw:签名内容  sign：签名
+ (BOOL)eccVerifySign:(NSString *)sign withRaw:(NSString *)raw withKey:(NSString *)key;
@end


/**
 [TSBManager loginWithPwd:@"111111" withError:nil];
 
 //    NSString *string =  [TSBManager eccDecryptData:@"likuiliang@syswin.com" encrypto:@"123456"];
 
 NSString *pubKey = [TSBManager getEccPubKey:@"syswin_tsb_pwd_initializer"];
 
 
 NSString *signString = [TSBManager eccSign:@"likuiliang" withTemail:@"syswin_tsb_pwd_initializer"];
 
 bool isTure = [TSBManager eccVerifySign:signString withRaw:@"likuiliang" withKey:pubKey];
 
 //    NSLog(@"string:%@----pubkey:%@", string, pubKey);
 NSLog(@"string:----pubkey:%@", pubKey);
 */
