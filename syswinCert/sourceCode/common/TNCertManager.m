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
#import "TNRecordModel.h"


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

+ (BOOL)checkCertIsvalid:(NSString *)filePath
{
    NSError *error;
    NSString *localFilePath = [KLocalSourceFilePath stringByAppendingPathComponent:filePath];
    NSString *stringJosn = [NSString stringWithContentsOfFile:localFilePath encoding:NSUTF8StringEncoding error:&error];
    NSDictionary *dictObject = [stringJosn tn_JSONObject];
    NSArray *keyList = [dictObject allKeys];
    if (keyList && keyList.count) {
        BOOL isValidCert = [keyList containsObject:@"cert"];
        BOOL isValidsignature = [keyList containsObject:@"signature"];
        if (isValidCert && isValidsignature) {
            return YES;
        }
        return NO;
    } else {
        return NO;
    }
}

- (void)saveCertificateWithFilePath:(NSString *)filePath
{
    // 保存数据库
    NSError *error;
    NSString *localFilePath = [KLocalSourceFilePath stringByAppendingPathComponent:filePath];
    NSString *stringJosn = [NSString stringWithContentsOfFile:localFilePath encoding:NSUTF8StringEncoding error:&error];
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
    receiverObject.receiverId = hashCert.receiver.receiverId;
    receiverObject.receiverPK = hashCert.receiver.receiverPublicKey;
    receiverObject.signFile = filePath;
    receiverObject.issuerPK = hashCert.issuer.issuerPublicKey;
    receiverObject.certName = hashCert.cert.certName;
    receiverObject.certTime = hashCert.cert.certTime;
    receiverObject.certImage = hashCert.cert.certImage;
    
    [[TNSqlManager instance] updateReceiverModel:receiverObject];
}

- (BOOL)verifyCertSignFilePath:(NSString *)filePath
{
    NSError *error;
    NSString *localFilePath = [KLocalSourceFilePath stringByAppendingPathComponent:filePath];
    NSString *stringJosn = [NSString stringWithContentsOfFile:localFilePath encoding:NSUTF8StringEncoding error:&error];
    
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
    
        NSString *pubKey = [sourceObject valueForKeyPath:@"issuerPublicKey"];
    
        BOOL isTure = [TSBManager eccVerifySign:[signatureDict valueForKey:@"issuerSign"] withRaw:signSourceString withKey:pubKey];
    
    return isTure;
    
}

- (NSString *)localHashFilePath:(NSString *)filePath
{
    NSError *error;
    NSString *localFilePath = [KLocalSourceFilePath stringByAppendingPathComponent:filePath];
    NSString *stringJosn = [NSString stringWithContentsOfFile:localFilePath encoding:NSUTF8StringEncoding error:&error];
    
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
    
    NSString *issuerSign = [signatureDict valueForKey:@"issuerSign"];
    
    [signSourceString appendString:issuerSign];
    
    NSString *hashSm3 = [TSBManager sm3:signSourceString];
    
    return hashSm3;
    
    
    
}

- (void)verifyCertGetRemoteHashFilePath:(NSString *)proofUrl block:(void (^)(BOOL, TNRecordModel *))block
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 25.f;
    // 返回的格式 JSON
    //    manager.responseSerializer= [AFJSONResponseSerializer serializer];
    // 可接受的文本参数规格
    manager.responseSerializer.acceptableContentTypes=  [NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",nil];
    
    [manager GET:proofUrl parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nullable responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *dict = [[responseObject valueForKey:@"data"] valueForKey:@"Record"];
            TNRecordModel *hashCertModel = [TNRecordModel deserializeFromDictionary:dict];
            hashCertModel.certHash = [dict valueForKey:@"hash"];
            // UI更新代码
            block ? block(YES, hashCertModel) : nil;
        });
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // UI更新代码
            block ? block(NO, nil) : nil;
        });
    }];

}

+ (UIImage *)formatBase64ImageWithString:(NSString *)base64String
{
    if (!base64String || base64String.length < 8) {
       return [UIImage imageNamed:@"issuer_headerImage"];
    }
    NSString *stringBase64 = base64String;
    
    NSRange range = [stringBase64 rangeOfString:@";base64,"];
    
    NSString *stringImageBase64 = [stringBase64 substringFromIndex:range.length+range.location];
    
    NSData *decodedImageData = [[NSData alloc]
                                initWithBase64EncodedString:stringImageBase64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    
    return decodedImage;
}

@end
