//
//  TNRecordModel.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/30.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNRecordModel : NSObject

@property (nonatomic, copy) NSString *issuerPK;
@property (nonatomic, copy) NSString *recipientPK;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *certHash;

@end

