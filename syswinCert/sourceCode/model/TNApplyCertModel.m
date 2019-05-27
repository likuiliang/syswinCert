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
//#import <TJson/NSDictionaryTNJson>

@implementation TNApplyCertModel

- (void)requestApplyCertWithParam:(NSDictionary *)param
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
    [manager POST:@"http://172.31.238.100:8081/user/register" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // success, parse the response here
        NSLog(@"responseObject=====%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // failure, e.g. network error
        NSLog(@"");
    } autoRetry:1];
    
    
    
//    [TNNetWorkManager GET:@"http://172.31.238.100:8081/org/list/" Param:param Success:^(NSDictionary *OCJSON) {
//
//    } Falied:^(AFCNetFaliedModel *faliedModel) {
//
//    }];
    
//    [TNNetWorkManager POST:@"http://172.31.238.100:8081/user/register" Param:param Success:^(NSDictionary *OCJSON) {
//
//    } Falied:^(AFCNetFaliedModel *faliedModel) {
//
//    }];
}

@end
