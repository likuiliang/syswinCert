//
//  TNApplyCertModel.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/23.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNApplyCertModel.h"
#import "TNNetWorkManager.h"

@implementation TNApplyCertModel

- (void)requestApplyCertWithParam:(NSDictionary *)param
{
    [TNNetWorkManager GET:@"http://172.31.238.100:8081/org/list/" Param:param Success:^(NSDictionary *OCJSON) {
        
    } Falied:^(AFCNetFaliedModel *faliedModel) {
        
    }];
}

@end
