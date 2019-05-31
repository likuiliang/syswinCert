//
//  TNVerifyInfoModel.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/30.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNVerifyInfoModel.h"

@implementation TNVerifyInfoModel

+ (NSArray *)initDataSourceModel
{
    NSMutableArray *titleArray = [NSMutableArray new];
    
    TNVerifyInfoModel *formatVerifyModel = [TNVerifyInfoModel new];
    formatVerifyModel.imageName = @"verify_bottom_blue";
    formatVerifyModel.title = @"格式验证";
    formatVerifyModel.isHeaderTItleView = YES;
    
        TNVerifyInfoModel *transactionIdModel = [TNVerifyInfoModel new];
        transactionIdModel.title = @"获取交易ID";
    
        TNVerifyInfoModel *hashIdModel = [TNVerifyInfoModel new];
        hashIdModel.title = @"计算本地hash";
    
        TNVerifyInfoModel *hashRemoteModel = [TNVerifyInfoModel new];
        hashRemoteModel.title = @"获取远程hash";
    
        TNVerifyInfoModel *signRemoteModel = [TNVerifyInfoModel new];
        signRemoteModel.title = @"验证发布者签名";
    
    
    TNVerifyInfoModel *hashVerifyModel = [TNVerifyInfoModel new];
    hashVerifyModel.title = @"哈希比较";
    hashVerifyModel.imageName = @"verify_bottom_blue";
    hashVerifyModel.isHeaderTItleView = YES;
    
        TNVerifyInfoModel *checkhashModel = [TNVerifyInfoModel new];
        checkhashModel.title = @"比较本地和链上hash";
    
    
    TNVerifyInfoModel *revecerVerifyModel = [TNVerifyInfoModel new];
    revecerVerifyModel.title = @"验证接收者";
    revecerVerifyModel.imageName = @"verify_bottom_blue";
    revecerVerifyModel.isHeaderTItleView = YES;
    
        TNVerifyInfoModel *checkReceviceModel = [TNVerifyInfoModel new];
        checkReceviceModel.title = @"验证收证人是否持有私钥";
    
    [titleArray addObject:formatVerifyModel];
    
    [titleArray addObject:transactionIdModel];
    [titleArray addObject:hashIdModel];
    [titleArray addObject:hashRemoteModel];
    [titleArray addObject:signRemoteModel];
    
    
    [titleArray addObject:hashVerifyModel];
    [titleArray addObject:checkhashModel];
    
    [titleArray addObject:revecerVerifyModel];
    [titleArray addObject:checkReceviceModel];
    
    return titleArray;
}

@end
