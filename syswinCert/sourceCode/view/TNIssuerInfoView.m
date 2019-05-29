//
//  TNIssuerInfoView.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/29.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNIssuerInfoView.h"
#import "TOONWYGlobalDefinition.h"
#import "TNIssuerCell.h"
#import "TNIssuerInfoHeaderView.h"

@interface TNIssuerInfoView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *issuerInfoTableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) TNIssuerInfoHeaderView *headerView;

@end

@implementation TNIssuerInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.issuerInfoTableView];
        self.issuerInfoTableView.tableHeaderView = self.headerView;
    }
    return self;
}

- (void)updateTableViewWithDataSource:(NSArray *)dataSource
{
    self.dataSource = dataSource;
    [self.issuerInfoTableView reloadData];
    [self.headerView updateIssuerViewWithModel:self.issuerObject];
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
    TNIssuerCell *issuerCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!issuerCell) {
        issuerCell = [[TNIssuerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [issuerCell updateCellInfoWithModel:self.dataSource[indexPath.row]];
    
    return issuerCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 94;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TNReceiverObject *object = self.dataSource[indexPath.row];
    [self.delegate issuerInfoCellOnClick:object];
}

#pragma mark - 懒加载

- (UITableView *)issuerInfoTableView
{
    if (!_issuerInfoTableView) {
        _issuerInfoTableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _issuerInfoTableView.delegate = self;
        _issuerInfoTableView.dataSource = self;
        _issuerInfoTableView.tableFooterView = [UIView new];
        self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 257);
        if (@available(iOS 11.0, *)) {
            _issuerInfoTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _issuerInfoTableView;
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSArray new];
    }
    return _dataSource;
}

- (TNIssuerInfoHeaderView *)headerView
{
    if (!_headerView) {
        _headerView = [[TNIssuerInfoHeaderView alloc] init];
    }
    return _headerView;
}

@end
