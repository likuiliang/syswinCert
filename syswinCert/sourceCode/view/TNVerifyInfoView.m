//
//  TNVerifyInfoView.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/30.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNVerifyInfoView.h"
#import "TNCertCommonView.h"
#import "TNCommonCell.h"

@interface TNVerifyInfoView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UILabel *verifyTitleLabel;
@property (nonatomic, strong) UITableView *verifyTableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation TNVerifyInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.verifyTableView];
        self.verifyTableView.tableHeaderView = self.verifyTitleLabel;
        [self initUIView];
    }
    return self;
}

- (void)initUIView
{
    self.dataSource = [TNVerifyInfoModel initDataSourceModel];
    [self.verifyTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *identifier = @"issuerCell";
    TNVerifyTitleCell *issuerCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!issuerCell) {
        issuerCell = [[TNVerifyTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    [issuerCell updateVerifyCellInfoWithModel:self.dataSource[indexPath.row]];
    return issuerCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}

#pragma mark - 懒加载

- (UILabel *)verifyTitleLabel
{
    if (!_verifyTitleLabel) {
        _verifyTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _verifyTitleLabel.text = @"验证凭证中...";
        _verifyTitleLabel.textAlignment = NSTextAlignmentCenter;
        _verifyTitleLabel.backgroundColor = [UIColor colorWithHEXString:@"#355ACF"];
    }
    return _verifyTitleLabel;
}

- (UITableView *)verifyTableView
{
    if (!_verifyTableView) {
        _verifyTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _verifyTableView.delegate = self;
        _verifyTableView.dataSource = self;
        _verifyTableView.tableFooterView = [UIView new];
            if (@available(iOS 11.0, *)) {
                _verifyTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
    }
    return _verifyTableView;
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSArray new];
    }
    return _dataSource;
}

@end