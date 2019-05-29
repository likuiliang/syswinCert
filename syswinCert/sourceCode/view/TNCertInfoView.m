//
//  TNCertInfoView.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/29.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNCertInfoView.h"
#import "TNCertInfoHeaderView.h"
#import "TNCertCommonView.h"

@interface TNCertInfoView() <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *certInfoScrollView;
@property (nonatomic, strong) UIButton *verifyBtn;
@property (nonatomic, strong) TNHashCertificateModel *certMode;
@property (nonatomic, strong) TNCertInfoHeaderView *infoHeaderView;

@end

@implementation TNCertInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.certInfoScrollView];
        [self addSubview:self.verifyBtn];
        [self updateCertInfoViewConstraints];
    }
    return self;
}

- (void)updateCertInfoViewConstraints
{
    [self.certInfoScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 100, 0));
    }];
    
    [self.verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(50);
        make.right.mas_equalTo(self).with.offset(-50);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(self).with.offset(-30);
    }];
}

- (void)initUIView
{
    [self.certInfoScrollView addSubview:self.infoHeaderView];
    TNImageTitleView *issuerImageView = [TNImageTitleView new];
    issuerImageView.imageView.image = [UIImage imageNamed:@"issuer_message_image"];
    issuerImageView.titleLabel.text = @"颁证机构信息";
    issuerImageView.frame = CGRectMake(0, CGRectGetMaxY(self.infoHeaderView.frame) + 25, SCREEN_WIDTH, 40);
    [self.certInfoScrollView addSubview:issuerImageView];
    
    TNTitleView *issuerTitleView = [TNTitleView new];
    issuerTitleView.titleLabel.text = @"机构名称";
    issuerTitleView.detailLabel.text = self.certMode.issuer.issuerName;
    issuerTitleView.frame = CGRectMake(0, CGRectGetMaxY(issuerImageView.frame), SCREEN_WIDTH, 40);
    [self.certInfoScrollView addSubview:issuerTitleView];
    
    TNTitleView *issuerURLView = [TNTitleView new];
    issuerURLView.titleLabel.text = @"机构官网";
    issuerURLView.detailLabel.text = self.certMode.issuer.issuerUrl;
    issuerURLView.frame = CGRectMake(0, CGRectGetMaxY(issuerTitleView.frame), SCREEN_WIDTH, 40);
    [self.certInfoScrollView addSubview:issuerURLView];
    
    TNTitleView *issuerEmailView = [TNTitleView new];
    issuerEmailView.titleLabel.text = @"机构email";
    issuerEmailView.detailLabel.text = self.certMode.issuer.issuerEmail;
    issuerEmailView.frame = CGRectMake(0, CGRectGetMaxY(issuerURLView.frame), SCREEN_WIDTH, 40);
    [self.certInfoScrollView addSubview:issuerEmailView];
    
    TNImageTitleView *receiverImageView = [TNImageTitleView new];
    receiverImageView.imageView.image = [UIImage imageNamed:@"receiver_message_image"];
    receiverImageView.titleLabel.text = @"收证人信息";
    receiverImageView.frame = CGRectMake(0, CGRectGetMaxY(issuerEmailView.frame) + 30, SCREEN_WIDTH, 40);
    [self.certInfoScrollView addSubview:receiverImageView];
    
    TNTitleView *receiverTitleView = [TNTitleView new];
    receiverTitleView.titleLabel.text = @"姓名";
    receiverTitleView.detailLabel.text = self.certMode.receiver.receiverName;
    receiverTitleView.frame = CGRectMake(0, CGRectGetMaxY(receiverImageView.frame), SCREEN_WIDTH, 40);
    [self.certInfoScrollView addSubview:receiverTitleView];

    TNTitleView *receiverCertView = [TNTitleView new];
    receiverCertView.titleLabel.text = @"证件类型";
    receiverCertView.detailLabel.text = self.certMode.receiver.receiverName;
    receiverCertView.frame = CGRectMake(0, CGRectGetMaxY(receiverTitleView.frame), SCREEN_WIDTH, 40);
    [self.certInfoScrollView addSubview:receiverCertView];

    TNTitleView *receiverCertNoView = [TNTitleView new];
    receiverCertNoView.titleLabel.text = @"证件编号";
    receiverCertNoView.detailLabel.text = self.certMode.receiver.receiverEmail;
    receiverCertNoView.frame = CGRectMake(0, CGRectGetMaxY(receiverCertView.frame), SCREEN_WIDTH, 40);
    [self.certInfoScrollView addSubview:receiverCertNoView];
    
    self.certInfoScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(receiverCertNoView.frame) + 10);
    
    self.certInfoScrollView.contentOffset = CGPointMake(0, 0);
}



- (void)updateCertInfoViewWithModel:(TNHashCertificateModel *)model
{
    self.certMode = model;
    [self initUIView];
    [self.infoHeaderView updateCertInfoHeaderViewWithModel:self.certMode];
}

- (void)verifyBtnOnClick
{
    
}

#pragma mark - 懒加载

- (UIScrollView *)certInfoScrollView
{
    if (!_certInfoScrollView) {
        _certInfoScrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _certInfoScrollView.bounces = YES;
        _certInfoScrollView.scrollEnabled = YES;
        _certInfoScrollView.delegate = self;
        _certInfoScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT - 100 - kNewNavigationHeight);
        if (@available(iOS 11.0, *)) {
            _certInfoScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _certInfoScrollView;
}

- (UIButton *)verifyBtn
{
    if (!_verifyBtn) {
        _verifyBtn = [[UIButton alloc] init];
        [_verifyBtn setTitle:@"验证" forState:UIControlStateNormal];
        [_verifyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _verifyBtn.backgroundColor = [UIColor colorWithHEXString:@"#355ACF"];
        [_verifyBtn addTarget:self action:@selector(verifyBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verifyBtn;
}

- (TNCertInfoHeaderView *)infoHeaderView
{
    if (!_infoHeaderView) {
        _infoHeaderView = [[TNCertInfoHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
    }
    return _infoHeaderView;
}

@end
