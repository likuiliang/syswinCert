//
//  TNVerifyInfoController.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/30.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNVerifyInfoController.h"
#import "TNVerifyInfoView.h"
#import "TOONWYGlobalDefinition.h"
#import "TNCertManager.h"
#import "TSBManager.h"

@interface TNVerifyInfoController ()

@property (nonatomic, strong) TNVerifyInfoView *verifyView;
@property (nonatomic, copy) NSString* remoteHash;
@property (nonatomic, copy) NSString* localHash;

@end

@implementation TNVerifyInfoController

- (id)init {
    if (self = [super init]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.verifyView];
    self.title = @"验证结果";
    [self.verifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"backarrow-black"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self verifyCert];
}

- (void)verifyCert
{
    [self postNotification:@"0" success:YES];
    // 验证交易Id是否存在
    if (self.model.signature.proofUrl.length) {
        [self postNotification:@"1" success:YES];
    } else {
        [self postNotification:@"1" success:NO];
        return;
    }
    
    // 计算本地hash
    self.localHash = [[TNCertManager instance] localHashFilePath:self.receiverObject.signFile];
    if (self.localHash.length) {
        [self postNotification:@"2" success:YES];
    } else {
        [self postNotification:@"2" success:NO];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    // 远端hash值
    [[TNCertManager instance] verifyCertGetRemoteHashFilePath:self.model.signature.proofUrl block:^(BOOL isSuccess, TNRecordModel *model) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.remoteHash = model.certHash;
            if (isSuccess && model.certHash.length) {
                [self postNotification:@"3" success:YES];
            } else {
                [self postNotification:@"3" success:NO];
                return;
            }
            // 验证发布者签名
            BOOL isSign = [[TNCertManager instance] verifyCertSignFilePath:self.receiverObject.signFile];
            [self postNotification:@"4" success:isSign];
            if (!isSign) {
                return;
            }
            [self postNotification:@"5" success:YES];
            // 检查hash
            if ([self.localHash isEqualToString:self.remoteHash]) {
                [self postNotification:@"6" success:YES];
            } else {
                [self postNotification:@"6" success:NO];
                return;
            }
            
            [self postNotification:@"7" success:YES];
            
            // 验证接收者签名
            NSString *signString = [TSBManager eccSign:weakSelf.model.issuer.issuerPublicKey withTemail:@"syswin_tsb_pwd_initializer"];
            
           BOOL receiverSign =  [TSBManager eccVerifySign:signString withRaw:weakSelf.model.issuer.issuerPublicKey withKey:weakSelf.model.receiver.receiverPublicKey];
            [self postNotification:@"8" success:receiverSign];
            if (!receiverSign) {
                return;
            }
        });
    }];
    
}

- (void)postNotification:(NSString *)key success:(BOOL)success
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TNCertVerifyNotification" object:@{@"key":key, @"success":success ? @"3" : @"2"}];
}

- (void)backButtonOnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (TNVerifyInfoView *)verifyView
{
    if (!_verifyView) {
        _verifyView = [[TNVerifyInfoView alloc] initWithFrame:self.view.bounds];
    }
    return _verifyView;
}

@end
