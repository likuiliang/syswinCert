//
//  TNCommonView.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/29.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNCertCommonView.h"

//@implementation TNCertCommonView
//
//- (instancetype)init
//{
//    if (self = [super init]) {
//
//    }
//    return self;
//}
//
//@end


@interface TNImageTitleView ()

@end

@implementation TNImageTitleView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self updateImageTitleViewConstraints];
    }
    return self;
}

- (void)updateImageTitleViewConstraints
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(24, 24));
        make.centerY.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imageView.mas_right).with.offset(10);
        make.height.mas_equalTo(22);
        make.centerY.mas_equalTo(self);
    }];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    return _titleLabel;
}

@end

@interface TNTitleView ()

@end

@implementation TNTitleView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.detailLabel];
        [self updateTitleViewConstraints];
    }
    return self;
}

- (void)updateTitleViewConstraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(46);
        make.size.mas_equalTo(CGSizeMake(90, 22));
        make.centerY.mas_equalTo(self);
    }];
    
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).with.offset(15);
        make.right.mas_equalTo(self).with.offset(-20);
        make.height.mas_equalTo(22);
        make.centerY.mas_equalTo(self);
    }];
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor colorWithHEXString:@"#5C5C5C"];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [UILabel new];
        _detailLabel.font = [UIFont systemFontOfSize:16];
        _detailLabel.textColor = [UIColor colorWithHEXString:@"#5C5C5C"];
    }
    return _detailLabel;
}

@end


