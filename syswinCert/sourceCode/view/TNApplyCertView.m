//
//  TNApplyCertView.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/23.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNApplyCertView.h"
#import "TNCommonCell.h"
#import "Masonry.h"
#import "TOONWYGlobalDefinition.h"
#import "TSBManager.h"
#import "TNApplyCertModel.h"

@interface TNApplyCertView ()

@property (nonatomic, strong) TNTextFieldView *nameTextFieldView;
@property (nonatomic, strong) TNTextFieldView *emailTextFieldView;
@property (nonatomic, strong) TNTextFieldView *pkTextFieldView;
@property (nonatomic, strong) TNButtonView *buttonView;
@property (nonatomic, strong) TNApplyCertModel *applyCertModel;

@end


@implementation TNApplyCertView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.nameTextFieldView];
        [self addSubview:self.emailTextFieldView];
        [self addSubview:self.pkTextFieldView];
        [self addSubview:self.buttonView];
        [self updateApplyConstraints];
        [self setPubKey];
    }
    return self;
}

- (void)updateApplyConstraints
{
    [self.nameTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
        make.left.mas_equalTo(self);
    }];
    
    [self.emailTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameTextFieldView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 50));
        make.left.mas_equalTo(self);
    }];
    
    [self.pkTextFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.emailTextFieldView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 80));
        make.left.mas_equalTo(self);
    }];
    
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pkTextFieldView.mas_bottom).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 44));
        make.left.mas_equalTo(self);
    }];
}

- (void)setPubKey
{
    NSString *pubKey = [TSBManager getEccPubKey:@"syswin_tsb_pwd_initializer"];
    self.pkTextFieldView.textField.text = pubKey;
//    NSString *signString = [TSBManager eccSign:@"likuiliang" withTemail:@"syswin_tsb_pwd_initializer"];
//    NSString *hash = [TSBManager sm3:@"sdsdjflsdj/sdslflslks920023slksdlklfs"];
    
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    [dictParam setValue:self.nameTextFieldView.textField.text forKey:@""];
    [dictParam setValue:self.nameTextFieldView.textField.text forKey:@""];
    [dictParam setValue:self.nameTextFieldView.textField.text forKey:@""];
    
    [self.applyCertModel requestApplyCertWithParam:[NSDictionary new]];
    
}



- (TNTextFieldView *)nameTextFieldView
{
    if (!_nameTextFieldView) {
        _nameTextFieldView = [[TNTextFieldView alloc] init];
        _nameTextFieldView.titleLabel.text = @"收件人姓名";
    }
    return _nameTextFieldView;
}

- (TNTextFieldView *)emailTextFieldView
{
    if (!_emailTextFieldView) {
        _emailTextFieldView = [[TNTextFieldView alloc] init];
        _emailTextFieldView.titleLabel.text = @"收件人Email";
    }
    return _emailTextFieldView;
}

- (TNTextFieldView *)pkTextFieldView
{
    if (!_pkTextFieldView) {
        _pkTextFieldView = [[TNTextFieldView alloc] init];
        _pkTextFieldView.titleLabel.text = @"PK";
        _pkTextFieldView.textField.placeholder = @"请输入公钥地址";
    }
    return _pkTextFieldView;
}

- (TNButtonView *)buttonView
{
    if (!_buttonView) {
        _buttonView = [[TNButtonView alloc] init];
    }
    return _buttonView;
}

- (TNApplyCertModel *)applyCertModel
{
    if (!_applyCertModel) {
        _applyCertModel = [[TNApplyCertModel alloc] init];
    }
    return _applyCertModel;
}

@end
