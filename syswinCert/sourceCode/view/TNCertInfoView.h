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

@protocol TNCertInfoViewDelegate <NSObject>

- (void)certViewCellDidSelectWithModel:(TNHashCertificateModel *)model;

@end

@interface TNCertInfoView : UIView

@property (nonatomic, weak) id<TNCertInfoViewDelegate> delegate;

- (void)updateCertInfoViewWithModel:(TNHashCertificateModel *)model;

@end

