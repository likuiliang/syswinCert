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
}

- (TNVerifyInfoView *)verifyView
{
    if (!_verifyView) {
        _verifyView = [[TNVerifyInfoView alloc] initWithFrame:self.view.bounds];
    }
    return _verifyView;
}

@end
