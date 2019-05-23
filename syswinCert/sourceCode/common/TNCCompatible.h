//
//  TNCCompatible.h
//  CompatibleService
//
//  Created by ZhuBruce on 15-6-4.
//  Copyright (c) 2015年 Syswin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TNCCompatible : NSObject

+ (TNCCompatible*)sharedTNCCompatible;

- (NSString*)getDescriptionStringWithErrorCode:(NSInteger)errorCode;
- (NSString*)getDescriptionStringWithCode:(NSInteger)code;

- (NSString*)getDescriptionStringWithErrorCodeString:(NSString*)errorCode;
- (NSString*)getDescriptionStringWithCodeString:(NSString*)code;

/**
 *  网络错误提示
 *
 *  @param error error
 */
+ (void)networkErrorTipsMethodWithError:(NSError *)error;

+ (void)networkSensitiveWordsWithError:(NSError *)error;
+ (void)networkSensitiveWordsWithError:(NSError *)error withOtherMsg:(NSString *)errMsg;
@end

@interface TNCCompatible (Group)

+ (BOOL)isNoNetWithError:(NSError *)error;
+ (NSString *)nameForTipImage:(BOOL)isSuccess;


/**
 小组 - 处理网路请求的失败case。先判断网络，无网会先提示网络错误，再根据error.code来查询对应的提示语，若未找到，则提示holderMsg，
 网络错误不带icon，其他错误都会显示+ (NSString *)nameForTipImage:(BOOL)isSuccess中得到的icon
 
 @param error 错误对象
 @param holderMsg 默认提示
 */
+ (void)showToastWithError:(NSError *)error holderMsg:(NSString *)holderMsg onView:(UIView *)aView;

@end
