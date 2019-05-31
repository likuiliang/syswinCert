//
//  TNSqlManager.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/27.
//  Copyright © 2019年 Answer. All rights reserved.
//

#define DBName "syswinCert"
#import "TNSqlManager.h"

#define kSkinDBName         @"syswinCertDB"
#define kSkinDBVersion      @"1"

@interface TNSqlManager ()<TNDBBaseManagerDelegate>

@property (nonatomic, copy) NSString *UUID;

@end

@implementation TNSqlManager

+ (id)instance {
    static TNSqlManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance.UUID = @"fabric";
            instance = [[TNSqlManager alloc] init];
        }
    });
    return instance;
}

- (BOOL)registerCertDBWithUUID:(NSString *)UUID{
    @synchronized(self) {
    _dbManager = [[TNDBBaseManager alloc] init];
    [_dbManager setupDBBaseManagerWithDBName:kSkinDBName withVersion:kSkinDBVersion withUId:@"fabric" withDelegate:self];
        return YES;
    }
}
    
- (void)updateIssuerModel:(TNIssuerObject *)model
{
    if (model) {
        [self.dbManager saveItems:@[model]];
    }
}

- (void)updateReceiverModel:(TNReceiverObject *)model
{
    if (model) {
        [self.dbManager saveItems:@[model]];
    }
}

- (void)deleteReceiverWithName:(NSString *)receiverId
{
    [self.dbManager deleteItemsInTable:[TNReceiverObject class] where:@"receiverId = '%@'", receiverId, nil];
}

- (NSArray *)registerTableClasses {
    return @[[TNIssuerObject class],[TNReceiverObject class]];
}

// 查询版本
- (NSArray *)queryReceiverWithName:(NSString *)receiverPK {
    NSArray *receiverArray = [NSArray array];
    if (!receiverPK || receiverPK.length == 0) {
        receiverArray = [self.dbManager queryItemsInTable:[TNReceiverObject class] where:nil, receiverPK, nil];
    }  else {
        receiverArray = [self.dbManager queryItemsInTable:[TNReceiverObject class] where:@"issuerPK = '%@'", receiverPK, nil];
    }
    return [receiverArray mutableCopy];
}

// 查询版本
- (NSArray *)queryIssuerWithName:(NSString *)issuerPK {
   
    NSArray *receiverArray = [NSArray array];
    if (!issuerPK || issuerPK.length == 0) {
        receiverArray = [self.dbManager queryItemsInTable:[TNIssuerObject class] where:nil, issuerPK, nil];
    } else {
        receiverArray = [self.dbManager queryItemsInTable:[TNIssuerObject class] where:@"issuerPK = '%@'", issuerPK, nil];
    }
    return [receiverArray mutableCopy];
}

@end
