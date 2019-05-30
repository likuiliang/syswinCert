//
//  TNCommonView.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/29.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TOONWYGlobalDefinition.h"

//@interface TNCertCommonView : UIView
//
//@end

@interface TNImageTitleView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end


@interface TNTitleView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@interface TNVerifyTitleView : UIView

@end
