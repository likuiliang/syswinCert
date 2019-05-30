//
//  TNCertManager.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/27.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOONWYGlobalDefinition.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <AFNetworking+AutoRetry/AFHTTPRequestOperationManager+AutoRetry.h>
#import "TNRecordModel.h"

@interface TNCertManager : NSObject <UIDocumentPickerDelegate>

+ (id)instance;

- (void)saveCertificateWithFilePath:(NSString *)filePath;

// 验证签名
- (BOOL)verifyCertSignFilePath:(NSString *)filePath;

// 获取远端hash
- (void)verifyCertGetRemoteHashFilePath:(NSString *)proofUrl block:(void (^)(BOOL, TNRecordModel *))block;

// 组装获取本地文件hash值
- (NSString *)localHashFilePath:(NSString *)filePath;

+ (UIImage *)formatBase64ImageWithString:(NSString *)base64String;



@end

