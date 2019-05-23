//
//  TNReceiverObject.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/23.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <tcardSqlite/TNDBBaseObject.h>

@interface TNReceiverObject : TNDBBaseObject

@property (nonatomic, copy) NSString *receiverPk;
@property (nonatomic, copy) NSString *signFile;

@end

