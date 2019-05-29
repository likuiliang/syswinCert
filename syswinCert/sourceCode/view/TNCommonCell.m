//
//  TNCommonCell.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/23.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNCommonCell.h"
#import "Masonry.h"

@interface TNCertCommonView()

@end

@implementation TNCertCommonView

- (instancetype)init
{
    if (self = [super init]) {
        [self initCommon];
        [self updateCommonConstraints];
    }
    return self;
}

- (void)initCommon
{
    
}

- (void)updateCommonConstraints
{
    
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor colorWithHEXString:@"#8E8E93"];
    }
    return _titleLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor colorWithHEXString:@"#E1E1E1"];
        //        _lineView.sakura.backgroundColor(@"Global.separator_color");
    }
    return _lineView;
}

@end


@interface TNTextFieldView()


@end

@implementation TNTextFieldView

- (instancetype)init
{
    if (self = [super init]) {
        [self initTextFieldCell];
        [self updateTextFieldCellConstraints];
    }
    return self;
}

- (void)initTextFieldCell
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.textField];
    [self addSubview:self.lineView];
}

- (void)updateTextFieldCellConstraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(16);
        make.size.mas_equalTo(CGSizeMake(100, 50));
        make.top.mas_equalTo(self);
    }];
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self.titleLabel.mas_right).with.offset(15);
        make.height.mas_equalTo(self);
        make.right.mas_equalTo(self).with.offset(-10);
    }];

    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_bottom).with.offset(-0.5);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(self).with.offset(16);
        make.right.mas_equalTo(self);
    }];
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请填写";
    }
    return _textField;
}

@end


@interface TNButtonView ()

@end

@implementation TNButtonView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.buttonView];
        [self updateButtonConstraints];
    }
    return self;
}

- (void)updateButtonConstraints
{
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(40);
        make.right.mas_equalTo(self).with.offset(-50);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(self);
    }];
}

- (UIButton *)buttonView
{
    if (!_buttonView) {
        _buttonView = [[UIButton alloc] init];
        [_buttonView setTitle:@"提交申请" forState:UIControlStateNormal];
        [_buttonView setBackgroundColor:[UIColor colorWithHEXString:@"#355ACF"]];
        _buttonView.layer.masksToBounds = YES;
        _buttonView.layer.cornerRadius = 5;
    }
    return _buttonView;
}

@end
