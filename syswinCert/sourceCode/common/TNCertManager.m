//
//  TNCertManager.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/27.
//  Copyright © 2019年 Answer. All rights reserved.
//
//+ (instancetype)deserializeFromDictionary:(NSDictionary *)dictionary
#import "TNCertManager.h"
#import "TSBManager.h"
#import "TNHashCertificateModel.h"

@implementation TNCertManager

+ (id)instance {
    static TNCertManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TNCertManager alloc] init];
        }
    });
    return instance;
}

- (void)saveCertificateWithFilePath:(NSString *)filePath
{
    // 保存数据库
    NSError *error;
    NSString *stringJosn = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    NSDictionary *dictObject = [stringJosn tn_JSONObject];
    TNHashCertificateModel *hashCert = [TNHashCertificateModel deserializeFromDictionary:dictObject];
    
    // 保存发布者信息入库
    TNIssuerObject *issuerObject = [TNIssuerObject new];
    issuerObject.issuerPk = hashCert.issuer.issuerPublicKey;
    issuerObject.name = hashCert.issuer.issuerName;
    issuerObject.avatar = hashCert.issuer.issuerImage;
    issuerObject.email = hashCert.issuer.issuerEmail;
    issuerObject.url = hashCert.issuer.issuerUrl;
    
    [[TNSqlManager instance] updateIssuerModel:issuerObject];
    
    // 保存证书及用户信息入库
    TNReceiverObject *receiverObject = [TNReceiverObject new];
    receiverObject.receiverPK = hashCert.receiver.receiverPublicKey;
    receiverObject.signFile = filePath;
    receiverObject.issuerPK = hashCert.issuer.issuerPublicKey;
    receiverObject.certName = hashCert.cert.certName;
    receiverObject.certTime = @"2017-05-28";
    receiverObject.certImage = hashCert.cert.certImage;
    
    [[TNSqlManager instance] updateReceiverModel:receiverObject];
}

- (void)verifyCertSignFilePath:(NSString *)filePath
{
    NSError *error;
    NSString *stringJosn = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    NSDictionary *dictObject = [stringJosn tn_JSONObject];
    NSMutableDictionary *sourceObject = [NSMutableDictionary new];
    NSMutableArray *arrayMu = [[dictObject allKeys] mutableCopy];
    NSDictionary *signatureDict = [dictObject valueForKey:@"signature"];
    [arrayMu removeObject:@"signature"];
    
    for (NSString *key in arrayMu) {
        [sourceObject addEntriesFromDictionary:[dictObject valueForKeyPath:key]];
    }
    
    NSArray *keyPathArray = [sourceObject allKeys];
    NSArray *afterSortKeyArray = [keyPathArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id _Nonnull obj2) {
        //排序操作
        NSComparisonResult resuest = [obj1 compare:obj2];
        return resuest;
    }];
    
    NSMutableString *signSourceString = [NSMutableString new];
    for (NSString *key in afterSortKeyArray) {
        [signSourceString appendString: [sourceObject valueForKeyPath:key]];
    }
    
        NSString *pubKey = [sourceObject valueForKeyPath:@"orgPublicKey"];
    
        BOOL isTure = [TSBManager eccVerifySign:[signatureDict valueForKey:@"issueSign"] withRaw:signSourceString withKey:pubKey];
    
}



@end
