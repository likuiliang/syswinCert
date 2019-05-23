//
//  TNCommonCell.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/23.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNCommonCell.h"
#import "Masonry.h"

@interface TNCommonCell()

@end

@implementation TNCommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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

@end


@interface TNTextFieldCell()

@property (nonatomic, strong) UITextField *textField;

@end

@implementation TNTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initTextFieldCell];
        [self updateTextFieldCellConstraints];
    }
    return self;
}

- (void)initTextFieldCell
{
    [self addSubview:self.textField];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
}

- (void)updateTextFieldCellConstraints
{
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(16);
        make.height.mas_equalTo(50.0);
        make.top.mas_equalTo(self);
        make.centerX.mas_equalTo(self.mas_centerX);
    }];
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).with.offset(15);
        make.height.mas_equalTo(self);
        make.right.mas_equalTo(self).with.offset(-10);
        make.centerX.mas_equalTo(self);
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
