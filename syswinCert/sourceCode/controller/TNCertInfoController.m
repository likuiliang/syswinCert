//
//  TNCertInfoController.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/29.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNCertInfoController.h"
#import "TNCertInfoView.h"
#import "TNHashCertificateModel.h"
#import "TNVerifyInfoController.h"

@interface TNCertInfoController () <TNCertInfoViewDelegate>

@property (nonatomic, strong) TNCertInfoView *infoView;

@end

@implementation TNCertInfoController

- (id)init {
    if (self = [super init]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"证书详情";
    [self.view addSubview:self.infoView];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    NSError *error;
    NSString *localFilePath = [KLocalSourceFilePath stringByAppendingPathComponent:self.receiverObject.signFile];
    NSString *stringJosn = [NSString stringWithContentsOfFile:localFilePath encoding:NSUTF8StringEncoding error:&error];
    NSDictionary *dictObject = [stringJosn tn_JSONObject];
    TNHashCertificateModel *hashCert = [TNHashCertificateModel deserializeFromDictionary:dictObject];
    
    [self.infoView updateCertInfoViewWithModel:hashCert];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"backarrow-black"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (void)backButtonOnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)certViewCellDidSelectWithModel:(TNHashCertificateModel *)model
{
    TNVerifyInfoController *verifyVC = [TNVerifyInfoController new];
    verifyVC.model = model;
    verifyVC.receiverObject = self.receiverObject;
    [self.navigationController pushViewController:verifyVC animated:YES];
}


- (TNCertInfoView *)infoView
{
    if (!_infoView) {
        _infoView = [[TNCertInfoView alloc] initWithFrame:self.view.bounds];
        _infoView.delegate = self;
    }
    return _infoView;
}

@end
