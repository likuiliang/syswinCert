//
//  TNIssuerCell.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/28.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNIssuerCell.h"

@interface TNIssuerCell()

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIImageView *arrowsImageView;

@end

@implementation TNIssuerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initIssuerSubView];
        [self updateIssuerConstraints];
    }
    
    return self;
}

- (void)initIssuerSubView
{
    [self.contentView addSubview:self.headerImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
    [self.contentView addSubview:self.arrowsImageView];
}

- (void)updateIssuerConstraints
{
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(54, 54));
        make.left.mas_equalTo(self).with.offset(16);
        make.top.mas_equalTo(self).with.offset(20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageView.mas_right).with.offset(16);
        make.top.mas_equalTo(self).with.offset(22);
        make.height.mas_equalTo(24);
        make.right.mas_equalTo(self).with.offset(-40);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(4);
        make.right.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(21);
    }];
    
    [self.arrowsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(6, 10));
        make.right.mas_equalTo(self).with.offset(-16);
        make.centerY.mas_equalTo(self);
    }];
}

- (void)updateCellInfoWithModel:(id)model
{
    if ([model isKindOfClass:[TNReceiverObject class]]) {
        TNReceiverObject *receiverObject = (TNReceiverObject *)model;
        self.titleLabel.text = receiverObject.certName;
        self.subTitleLabel.text = receiverObject.certTime;
        self.headerImageView.image = [TNCertManager formatBase64ImageWithString:receiverObject.certImage];
    } else if ([model isKindOfClass:[TNIssuerObject class]]){
        TNIssuerObject *issuerObject = (TNIssuerObject *)model;
        self.titleLabel.text = issuerObject.name;
        NSArray *array = [[TNSqlManager instance] queryReceiverWithName:issuerObject.issuerPk];
        self.subTitleLabel.text = [NSString stringWithFormat:@"%ld张证书",array.count];
        self.headerImageView.image = [TNCertManager formatBase64ImageWithString:issuerObject.avatar];
    }
}

- (UIImageView *)headerImageView
{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"issuer_headerImage"]];
    }
    return _headerImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel
{
    if (!_subTitleLabel) {
        _subTitleLabel = [UILabel new];
    }
    return _subTitleLabel;
}

- (UIImageView *)arrowsImageView
{
    if (!_arrowsImageView) {
        _arrowsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrows_image"]];
    }
    return _arrowsImageView;
}

@end
