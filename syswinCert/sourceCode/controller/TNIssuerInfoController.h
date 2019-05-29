//
//  TNIssuerInfoController.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/29.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNCardHiddenNavigationController.h"
#import "TNIssuerObject.h"

@interface TNIssuerInfoController : TNCardHiddenNavigationController

@property (nonatomic, strong) TNIssuerObject *issuerObject;

@end

