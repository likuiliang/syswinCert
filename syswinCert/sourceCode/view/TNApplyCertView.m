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
@property (nonatomic, strong) TNTextPkView *pkTextView;
@property (nonatomic, strong) TNButtonView *buttonView;
@property (nonatomic, strong) TNApplyCertModel *applyCertModel;

@end


@implementation TNApplyCertView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.nameTextFieldView];
        [self addSubview:self.emailTextFieldView];
        [self addSubview:self.pkTextView];
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
    
    [self.pkTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.emailTextFieldView.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 80));
        make.left.mas_equalTo(self);
    }];
    
    [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pkTextView.mas_bottom).with.offset(40);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 44));
        make.left.mas_equalTo(self);
    }];
}

- (void)setPubKey
{
    NSString *pubKey = [TSBManager getEccPubKey:@"syswin_tsb_pwd_initializer"];
    self.pkTextView.textView.text = pubKey;
}

- (void)applyCertOnClick
{
    NSMutableDictionary *dictParam = [NSMutableDictionary new];
    [dictParam setValue:self.nameTextFieldView.textField.text forKey:@"receiverName"];
    [dictParam setValue:self.emailTextFieldView.textField.text forKey:@"receiverEmail"];
    [dictParam setValue:self.pkTextView.textView.text forKey:@"publicKey"];
    [dictParam setValue:@"image" forKey:@"receiverImage"];
    
    [self.applyCertModel requestApplyCertWithParam:dictParam block:^(BOOL isSuccess) {
        
    }];
    
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

- (TNTextPkView *)pkTextView
{
    if (!_pkTextView) {
        _pkTextView = [[TNTextPkView alloc] init];
        _pkTextView.titleLabel.text = @"PK";
//        _pkTextView.textField.placeholder = @"请输入公钥地址";
    }
    return _pkTextView;
}

- (TNButtonView *)buttonView
{
    if (!_buttonView) {
        _buttonView = [[TNButtonView alloc] init];
        [_buttonView.buttonView addTarget:self action:@selector(applyCertOnClick) forControlEvents:UIControlEventTouchUpInside];

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

/*
 //    NSString *signString = [TSBManager eccSign:@"likuiliang" withTemail:@"syswin_tsb_pwd_initializer"];
 //    NSString *hash = [TSBManager sm3:@"sdsdjflsdj/sdslflslks920023slksdlklfs"];
 
 //    NSData *basicAuthCredentials = UIImagePNGRepresentation([UIImage imageNamed:@""]);
 //    NSString *base64AuthCredentials = [basicAuthCredentials base64EncodedStringWithOptions:(NSDataBase64EncodingOptions)0];
 */
