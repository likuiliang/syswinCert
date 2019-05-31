//
//  TNCertInfoHeaderView.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/29.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNCertInfoHeaderView.h"

@interface TNCertInfoHeaderView ()

@property (nonatomic, strong) UIImageView *certImageView;
@property (nonatomic, strong) UIImageView *issuerImageView;
@property (nonatomic, strong) UILabel *issuerNameLabel;
@property (nonatomic, strong) UILabel *receiverNameLabel;
@property (nonatomic, strong) UILabel *certDetailLabel;
@property (nonatomic, strong) TNHashCertificateModel *model;

@property (nonatomic, strong) UIImageView *figureImageView;
@end

@implementation TNCertInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.certImageView];
        [self addSubview:self.issuerImageView];
        [self addSubview:self.issuerNameLabel];
        [self addSubview:self.figureImageView];
        [self addSubview:self.receiverNameLabel];
        [self addSubview:self.certDetailLabel];
        [self updateCertInfoConstraints];
    }
    return self;
}

- (void)updateCertInfoHeaderViewWithModel:(TNHashCertificateModel *)model
{
    self.model = model;
    self.issuerImageView.image = [TNCertManager formatBase64ImageWithString:model.issuer.issuerImage];
    self.issuerNameLabel.text = model.issuer.issuerName;
    self.receiverNameLabel.text = model.receiver.receiverName;
    self.certDetailLabel.text = model.cert.certDesc;
}

- (void)updateCertInfoConstraints
{
    [self.certImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(20, 20, 20, 20));
    }];
    
    [self.issuerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(45, 45));
        make.top.mas_equalTo(self).with.offset(30);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.issuerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.issuerImageView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(23);
        make.centerX.mas_equalTo(self.certImageView);
    }];
    
    [self.figureImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(30);
        make.right.mas_equalTo(self).with.offset(-30);
        make.top.mas_equalTo(self.issuerNameLabel.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.receiverNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.figureImageView.mas_bottom).with.offset(8);
        make.height.mas_equalTo(21);
        make.centerX.mas_equalTo(self.certImageView);
    }];
    
    [self.certDetailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.receiverNameLabel.mas_bottom).with.offset(7);
        make.height.mas_equalTo(21);
        make.centerX.mas_equalTo(self.certImageView);
    }];
}

- (UIImageView *)certImageView
{
    if (!_certImageView) {
        _certImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cert_bg_image"]];
        _certImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _certImageView;
}

- (UIImageView *)issuerImageView
{
    if (!_issuerImageView) {
        _issuerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"issuer_headerImage"]];
        _issuerImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _issuerImageView;
}

- (UIImageView *)figureImageView{
    if (!_figureImageView) {
        _figureImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"figure_image"]];
        _issuerImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _figureImageView;
}

- (UILabel *)issuerNameLabel
{
    if (!_issuerNameLabel) {
        _issuerNameLabel = [UILabel new];
    }
    return _issuerNameLabel;
}

- (UILabel *)receiverNameLabel
{
    if (!_receiverNameLabel) {
        _receiverNameLabel = [UILabel new];
    }
    return _receiverNameLabel;
}

- (UILabel *)certDetailLabel
{
    if (!_certDetailLabel) {
        _certDetailLabel = [UILabel new];
    }
    return _certDetailLabel;
}

@end
