//
//  TNVerifyInfoController.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/30.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNHashCertificateModel.h"
#import "TNReceiverObject.h"

@interface TNVerifyInfoController : UIViewController

@property (nonatomic, strong) TNHashCertificateModel *model;
@property (nonatomic, strong) TNReceiverObject *receiverObject;

@end

