//
//  TNIssuerObject.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/23.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <tcardSqlite/TNDBBaseObject.h>

@interface TNIssuerObject : TNDBBaseObject

@property (nonatomic, copy) NSString *issuerPk;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar;

@end

