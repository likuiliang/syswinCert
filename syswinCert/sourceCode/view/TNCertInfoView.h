//
//  TNCertInfoView.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/29.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOONWYGlobalDefinition.h"
#import "TNHashCertificateModel.h"

@interface TNCertInfoView : UIView

- (void)updateCertInfoViewWithModel:(TNHashCertificateModel *)model;

@end

