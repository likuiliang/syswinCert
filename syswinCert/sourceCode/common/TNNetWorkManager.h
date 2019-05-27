//
//  TNNetWorkManager.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/24.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class AFCNetFaliedModel;

/*
 
  * 请求成功block
 
  */

typedef void (^AFCSuccessBlock)(NSDictionary * OCJSON);

/*
 
  * 请求失败block
 
  */

typedef void (^AFCFaliedBlock)(AFCNetFaliedModel * faliedModel);

/*
 
  * 视频上传进度
 
  */

typedef void(^ UploadProgress)(CGFloat Progress);

@interface TNNetWorkManager : NSObject

/** GET请求*/

+(void)GET:(NSString *)urlStr Param:(NSDictionary *)param Success:(AFCSuccessBlock)success Falied:(AFCFaliedBlock)falied;

/** POST请求*/

+(void)POST:(NSString *)urlStr Param:(NSDictionary *)param Success:(AFCSuccessBlock)success Falied:(AFCFaliedBlock)falied;

/** POST上传单张图片*/

+(void)POST:(NSString *) urlStr Param:(NSDictionary *)param image:(UIImage *) image Success:(AFCSuccessBlock)

succes Falied:(AFCFaliedBlock) falied;

/** POST提交视频*/

+(void)POST:(NSString *) urlStr Param:(NSDictionary *)param videoData:(NSData *) data UploadProgress:(UploadProgress ) progress Success:(AFCSuccessBlock) succes Falied:(AFCFaliedBlock) falied;

/** POST上传单张图片 scale*/

+(void)POST:(NSString *) urlStr Param:(NSDictionary *)param image:(UIImage *) image scale:(CGFloat)scale Success:(AFCSuccessBlock)

success Falied:(AFCFaliedBlock) falied;

@end

@interface AFCNetFaliedModel : NSObject

@property(nonatomic,assign)  NSInteger code;

@property(nonatomic,copy)    NSString * message;

@property(nonatomic,copy)    NSError  * error;

@end

