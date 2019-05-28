//
//  TNReceiverObject.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/23.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <tcardSqlite/TNDBBaseObject.h>

@interface TNReceiverObject : TNDBBaseObject

@property (nonatomic, copy) NSString *receiverPK; // 接受者pk
@property (nonatomic, copy) NSString *signFile;  // 文件名称
@property (nonatomic, copy) NSString *issuerPK;  // 发布者PK
@property (nonatomic, copy) NSString *certName;  // 发布者PK
@property (nonatomic, copy) NSString *certTime;  // 发布者PK
@property (nonatomic, copy) NSString *certImage;  // 发布者PK

@end

