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

@interface TNCommonView : UIView

@property (strong, nonatomic) UILabel *titleLabel;

@property (nonatomic, strong) UIView *lineView;

@end

@interface TNTextFieldView : TNCommonView

@property (nonatomic, strong) UITextField *textField;

@end

@interface TNButtonView : TNCommonView

@property (nonatomic, strong) UIButton *buttonView;

@end
