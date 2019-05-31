//
//  TNSqlManager.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/27.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <tcardSqlite/TNDBBaseManager.h>
#import "TNIssuerObject.h"
#import "TNReceiverObject.h"

@interface TNSqlManager : NSObject

@property(nonatomic, strong, readonly) TNDBBaseManager *dbManager;

+ (id)instance;

//用UUID注册数据库
- (BOOL)registerCertDBWithUUID:(NSString *)UUID;

- (void)updateIssuerModel:(TNIssuerObject *)model;

- (void)updateReceiverModel:(TNReceiverObject *)model;

- (NSArray *)queryReceiverWithName:(NSString *)receiverPK;

- (void)deleteReceiverWithName:(NSString *)receiverId;

- (NSArray *)queryIssuerWithName:(NSString *)issuerPK;
@end

