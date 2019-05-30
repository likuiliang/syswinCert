//
//  TNApplyCertModel.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/23.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNApplyCertModel.h"
#import "TNNetWorkManager.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import <AFNetworking+AutoRetry/AFHTTPRequestOperationManager+AutoRetry.h>
#import "MBProgressHUD+Extend.h"
//#import <TJson/NSDictionaryTNJson>

@implementation TNApplyCertModel

- (void)requestApplyCertWithParam:(NSDictionary *)param block:(void (^)(BOOL isSuccess))block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    // 返回的格式 JSON
//    manager.responseSerializer= [AFJSONResponseSerializer serializer];
    // 可接受的文本参数规格
    manager.responseSerializer.acceptableContentTypes=  [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",nil];
    // 开始设置请求头
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // uid是每个用户对应的ID  cipherText是密码
    // set the network timeout duration to 30 seconds
//    manager.requestSerializer = [[AFHTTPRequestSerializerWithTimeout alloc] initWithTimeout:30];
    [manager POST:@"http://172.28.11.230:8081/receiver/register" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // success, parse the response here
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            [MBProgressHUD showMessage:@"注册成功!" inView:nil];
            
            block ? block(YES) : nil;
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // failure, e.g. network error
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            [MBProgressHUD showMessage:@"注册失败!" inView:nil];
            block ? block(NO) : nil;
        });
        
    } autoRetry:1];
    
}

@end
