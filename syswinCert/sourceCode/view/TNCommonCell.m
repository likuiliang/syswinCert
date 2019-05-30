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

@interface TNVerifyTitleCell ()

@property (nonatomic, strong) UILabel *bgNomalLabel;
@property (nonatomic, strong) UILabel *bgSelectLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIImageView *rotundityImageView;

@end

@implementation TNVerifyTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.bgNomalLabel];
        [self.contentView addSubview:self.bgSelectLabel];
        [self.contentView addSubview:self.rotundityImageView];
        [self.contentView addSubview:self.headerImageView];
        [self.contentView addSubview:self.titleLabel];
        [self updateVerifyTitleViewConstraints];
    }
    return self;
}

- (void)updateVerifyCellInfoWithModel:(TNVerifyInfoModel *)model
{
    self.bgNomalLabel.backgroundColor = [UIColor colorWithHEXString:@"#E3E4E7"];
    self.titleLabel.text = model.title;
    if (model.isHeaderTItleView) {
        self.rotundityImageView.hidden = YES;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        
    } else {
        self.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    self.headerImageView.image = [UIImage imageNamed:model.imageName];
    if (model.verifyType == TNVerifyBeingType) {
    } else if (model.verifyType == TNVerifySuccessType) {
        self.bgNomalLabel.backgroundColor = [UIColor colorWithHEXString:@"#1FB677"];
    } else if (model.verifyType == TNVerifyFailType && !model.isHeaderTItleView) {
        self.headerImageView.image = [UIImage imageNamed:@"check_error_image"];
        self.titleLabel.textColor = [UIColor colorWithHEXString:@"#C02219"];
    }
}

- (void)updateVerifyTitleViewConstraints
{
    [self.bgNomalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(12);
        make.height.mas_equalTo(self);
        make.left.mas_equalTo(39);
        make.top.mas_equalTo(self);
    }];
    
    [self.bgSelectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.bgNomalLabel);
    }];
    
    [self.rotundityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 6));
        make.left.mas_equalTo(self).with.offset(42);
        make.centerY.mas_equalTo(self);
    }];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(34, 34));
        make.center.mas_equalTo(self.rotundityImageView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(82);
        make.height.mas_equalTo(self);
        make.right.mas_equalTo(self).with.offset(-20);
        make.centerY.mas_equalTo(self);
    }];
}

- (UILabel *)bgNomalLabel
{
    if (!_bgNomalLabel) {
        _bgNomalLabel = [UILabel new];
    }
    return _bgNomalLabel;
}

- (UILabel *)bgSelectLabel
{
    if (!_bgSelectLabel) {
        _bgSelectLabel = [UILabel new];
    }
    return _bgSelectLabel;
}

- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
    }
    return _headerImageView;
}

- (UIImageView *)rotundityImageView
{
    if (!_rotundityImageView) {
        _rotundityImageView = [[UIImageView alloc] init];
        _rotundityImageView.backgroundColor = [UIColor whiteColor];
        _rotundityImageView.layer.masksToBounds = YES;
        _rotundityImageView.layer.cornerRadius = 3;
    }
    return _rotundityImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}

@end
