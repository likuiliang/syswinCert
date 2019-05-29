//
//  TNCommonCell.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/23.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNCBaseItemCell.h"
#import "UIColor+Extension.h"

@interface TNCertCommonView : UIView

@property (strong, nonatomic) UILabel *titleLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@interface TNTextFieldView : TNCertCommonView

@property (nonatomic, strong) UITextField *textField;

@end

@interface TNButtonView : TNCertCommonView

@property (nonatomic, strong) UIButton *buttonView;

@end
