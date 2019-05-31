//
//  TNIssuerInfoHeaderView.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/29.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNIssuerInfoHeaderView.h"

@interface TNIssuerInfoHeaderView ()

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *issuerImageView;
@property (nonatomic, strong) UILabel *issuerNameLabel;
@property (nonatomic, strong) UILabel *urlLabel;
@property (nonatomic, strong) UILabel *emailLabel;

@end

@implementation TNIssuerInfoHeaderView

- (instancetype)init
{
    if (self = [super init]) {
        [self initIssuerSubView];
        [self updateIssuerConstraints];
    }
    return self;
}

- (void)updateIssuerViewWithModel:(TNIssuerObject *)issuerObject
{
    
    
    self.issuerImageView.image = [TNCertManager formatBase64ImageWithString:issuerObject.avatar];
    
//    self.issuerImageView.image = issuerObject
    self.issuerNameLabel.text = issuerObject.name;
    self.urlLabel.text = issuerObject.url;
    self.emailLabel.text = issuerObject.email;
}

- (void)initIssuerSubView
{
    [self addSubview:self.backgroundImageView];
    [self addSubview:self.issuerImageView];
    [self addSubview:self.issuerNameLabel];
    [self addSubview:self.urlLabel];
    [self addSubview:self.emailLabel];
}

- (void)updateIssuerConstraints
{
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [self.issuerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.top.mas_equalTo(self).with.offset(50);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.issuerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.issuerImageView.mas_bottom).with.offset(20);
        make.left.mas_equalTo(self).with.offset(20);
        make.right.mas_equalTo(self).with.offset(-20);
        make.height.mas_equalTo(25);
    }];
    
    [self.urlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.issuerNameLabel.mas_bottom).with.offset(6);
        make.left.mas_equalTo(self).with.offset(20);
        make.right.mas_equalTo(self).with.offset(-20);
        make.height.mas_equalTo(21);
    }];
    
    [self.emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.urlLabel.mas_bottom).with.offset(6);
        make.left.mas_equalTo(self).with.offset(20);
        make.right.mas_equalTo(self).with.offset(-20);
        make.height.mas_equalTo(21);
    }];
    
}

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"issuer_bg_image"]];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImageView.clipsToBounds = YES;
    }
    return _backgroundImageView;
}

- (UIImageView *)issuerImageView
{
    if (!_issuerImageView) {
        _issuerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"issuer_headerImage"]];
        _issuerImageView.contentMode = UIViewContentModeScaleAspectFit;
//        _issuerImageView.clipsToBounds = YES;
    }
    return _issuerImageView;
}

- (UILabel *)issuerNameLabel
{
    if (!_issuerNameLabel) {
        _issuerNameLabel = [UILabel new];
        _issuerNameLabel.textAlignment = NSTextAlignmentCenter;
        _issuerNameLabel.font = [UIFont boldSystemFontOfSize:20];
        _issuerNameLabel.textColor = [UIColor colorWithHEXString:@"#FFFFFF"];
    }
    return _issuerNameLabel;
}

- (UILabel *)urlLabel
{
    if (!_urlLabel) {
        _urlLabel = [UILabel new];
        _urlLabel.textAlignment = NSTextAlignmentCenter;
        _urlLabel.font = [UIFont systemFontOfSize:15];
        _urlLabel.textColor = [UIColor colorWithHEXString:@"#FFFFFF"];
    }
    return _urlLabel;
}

- (UILabel *)emailLabel
{
    if (!_emailLabel) {
        _emailLabel = [UILabel new];
        _emailLabel.textAlignment = NSTextAlignmentCenter;
        _emailLabel.font = [UIFont systemFontOfSize:15];
        _emailLabel.textColor = [UIColor colorWithHEXString:@"#FFFFFF"];
    }
    return _emailLabel;
}

@end
