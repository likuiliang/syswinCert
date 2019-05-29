//
//  TNIssuerInfoController.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/29.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNIssuerInfoController.h"
#import "TNDocument.h"
#import "TSBManager.h"
#import "TOONWYGlobalDefinition.h"
#import "TNSqlManager.h"
#import "TNCertManager.h"
#import "TNIssuerInfoView.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "TNCertInfoController.h"

@interface TNIssuerInfoController ()<UIDocumentPickerDelegate,TNIssuerInfoViewDelegate>

@property (nonatomic, strong) TNIssuerInfoView *issuerInfoView;

@end

@implementation TNIssuerInfoController

- (id)init {
    if (self = [super init]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.issuerInfoView];

    NSArray *array = [[TNSqlManager instance] queryReceiverWithName:self.issuerObject.issuerPk];
    [self.issuerInfoView updateTableViewWithDataSource:array];
}

- (void)issuerInfoCellOnClick:(TNReceiverObject *)receiverObject
{
    TNCertInfoController *certInfoVC = [TNCertInfoController new];
    
    [self.navigationController pushViewController:certInfoVC animated:YES];
}

- (TNIssuerInfoView *)issuerInfoView
{
    if (!_issuerInfoView) {
        _issuerInfoView = [[TNIssuerInfoView alloc] initWithFrame:self.view.bounds];
        _issuerInfoView.issuerObject = self.issuerObject;
    }
    return _issuerInfoView;
}

@end
