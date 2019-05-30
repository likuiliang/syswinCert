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

@interface TNVerifyInfoController ()

@property (nonatomic, strong) TNVerifyInfoView *verifyView;

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
    
    [self verifyCert];
}

- (void)verifyCert
{
    // 远端hash值
    [[TNCertManager instance] verifyCertGetRemoteHashFilePath:self.model.signature.proofUrl block:^(BOOL isSuccess, TNRecordModel *model) {
        
    }];
    
    BOOL isSign = [[TNCertManager instance] verifyCertSignFilePath:self.receiverObject.signFile];
    
    NSString *hash = [[TNCertManager instance] localHashFilePath:self.receiverObject.signFile];
    
//    NSString * [[TNCertManager instance] localHashFilePath:self.receiverObject.signFile];
    
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
