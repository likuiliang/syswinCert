//
//  TNCCompatible.m
//  CompatibleService
//
//  Created by ZhuBruce on 15-6-4.
//  Copyright (c) 2015年 Syswin. All rights reserved.
//

#import "TNCCompatible.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+Extend.h"
@interface TNCCompatible()

@property (nonatomic, retain) NSDictionary* errorCodeDictionary;

@end

@implementation TNCCompatible

#pragma -mark Setter & Getter 

+ (TNCCompatible*)sharedTNCCompatible
{
    static id sharedObject = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
    });
    
    return sharedObject;
}

- (NSDictionary *)errorCodeDictionary
{
    
    
    if (!_errorCodeDictionary) {
        NSString* filename = [[NSBundle mainBundle] pathForResource:@"TNACodeDefination" ofType:@"plist"];
        _errorCodeDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filename];
    }

    return _errorCodeDictionary;
}

#pragma -mark Public interface

- (NSString*)getDescriptionStringWithCode:(NSInteger)code
{
    NSString* codeString = [NSString stringWithFormat:@"%ld", (long)code];
    return [self getDescriptionStringWithCodeString:codeString];
}

- (NSString*)getDescriptionStringWithErrorCode:(NSInteger)errorCode
{
    return [self getDescriptionStringWithCode:errorCode];
}

- (NSString*)getDescriptionStringWithCodeString:(NSString*)code
{
    if ([code isKindOfClass:[NSString class]]) {
        NSString *str = [self.errorCodeDictionary valueForKey:code];
        return str;
    }
    else
    {
        NSInteger integerCode = (NSInteger)code;
        return [self getDescriptionStringWithCode:integerCode];
    }
    return nil;
}

- (NSString*)getDescriptionStringWithErrorCodeString:(NSString*)errorCode
{
    return [self getDescriptionStringWithCodeString:errorCode];
}


/**
 *  网络错误提示
 *
 *  @param error error
 */
+ (void)networkErrorTipsMethodWithError:(NSError *)error
{
    NSString *errorStr = [[TNCCompatible sharedTNCCompatible] getDescriptionStringWithErrorCode:error.code];
    if (errorStr.length > 0) {
        [MBProgressHUD showMessage:[[TNCCompatible sharedTNCCompatible] getDescriptionStringWithErrorCode:error.code] inView:nil];
    } else {
        [MBProgressHUD showMessage:[[TNCCompatible sharedTNCCompatible] getDescriptionStringWithErrorCodeString:@"3000"] inView:nil];
    }
}

+ (void)networkSensitiveWordsWithError:(NSError *)error {
    if (error.code == 101005) {
        NSString *msg = error.userInfo[@"meta"][@"message"];
        [MBProgressHUD showMessage:msg inView:nil];
    } else {
        [self networkErrorTipsMethodWithError:error];
    }
}

+ (void)networkSensitiveWordsWithError:(NSError *)error withOtherMsg:(NSString *)errMsg {
    if (error.code == 101005) {
        NSString *msg = error.userInfo[@"meta"][@"message"];
        [MBProgressHUD showMessage:msg inView:nil];
    } else {
        [MBProgressHUD showMessage:errMsg inView:nil];
    }
}
@end

#pragma mark - ------------------ <#title#>


@implementation TNCCompatible (Group)

+ (BOOL)isNoNetWithError:(NSError *)error
{
    return error.code == -1009;
}

+ (NSString *)nameForTipImage:(BOOL)isSuccess
{
    NSString *imgName = @"common_success";
    
    if(!isSuccess){
        imgName = @"common_failure";
    }
    
    return imgName;
}

+ (void)showToastWithError:(NSError *)error holderMsg:(NSString *)holderMsg onView:(UIView *)aView
{
    //错误case
    if([error isKindOfClass:[NSError class]]){
        
        NSString *alertMsg = nil;
        NSString *imgName = nil;
        
        //只有在非网络错误时，才有icon
        if(![TNCCompatible isNoNetWithError:error]){
            imgName = [TNCCompatible nameForTipImage:NO];
        }
        
        alertMsg = [[TNCCompatible sharedTNCCompatible] getDescriptionStringWithCode:error.code];
        if(!alertMsg){
            alertMsg = NSLocalizedString(holderMsg, nil);
        }
        
        if(imgName.length > 0){
            [MBProgressHUD showMessage:alertMsg withImageName:imgName inView:aView];
        }else{
            [MBProgressHUD showMessage:alertMsg inView:aView];
        }
    }
}

@end

