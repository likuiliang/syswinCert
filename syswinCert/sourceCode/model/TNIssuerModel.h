//
//  TNIssuerModel.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/27.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TNIssuerModel : NSObject

@property (nonatomic, copy) NSString *issuerCode;
@property (nonatomic, copy) NSString *issuerEmail;
@property (nonatomic, copy) NSString *issuerId;
@property (nonatomic, copy) NSString *issuerImage;
@property (nonatomic, copy) NSString *issuerName;
@property (nonatomic, copy) NSString *issuerPublicKey;
@property (nonatomic, copy) NSString *issuerType;
@property (nonatomic, copy) NSString *issuerUrl;

@end

