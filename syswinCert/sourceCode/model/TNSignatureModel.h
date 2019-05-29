//
//  TNSignatureModel.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/27.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNSignatureModel : NSObject

@property (nonatomic, copy) NSString *issuerSign;
@property (nonatomic, copy) NSString *proofUrl;
@property (nonatomic, copy) NSString *sourceId;
@property (nonatomic, copy) NSString *targetHash;

@end

