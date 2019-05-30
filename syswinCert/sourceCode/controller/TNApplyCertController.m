//
//  TNApplyCertController.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/23.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNApplyCertController.h"
#import "TNApplyCertView.h"
#import "TSBManager.h"

@interface TNApplyCertController ()

@property (nonatomic, strong) TNApplyCertView *applyCertView;

@end

@implementation TNApplyCertController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请证书";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.applyCertView];
    self.applyCertView.frame = self.view.bounds;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(backButtonOnClick) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"backarrow-black"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
}

- (void)backButtonOnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (TNApplyCertView *)applyCertView
{
    if (!_applyCertView) {
        _applyCertView = [[TNApplyCertView alloc] init];
    }
    return _applyCertView;
}

@end
