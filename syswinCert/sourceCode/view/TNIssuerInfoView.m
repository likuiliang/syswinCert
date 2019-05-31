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
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) TNIssuerInfoHeaderView *headerView;
@property (strong, nonatomic) UIButton *leftButton;

@end

@implementation TNIssuerInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.issuerInfoTableView];
        [self addSubview:self.leftButton];
        self.issuerInfoTableView.tableHeaderView = self.headerView;
    }
    return self;
}

- (void)cardGoBack
{
    [self.delegate backOnClick];
}

- (void)updateTableViewWithDataSource:(NSArray *)dataSource
{
    self.dataSource = [dataSource mutableCopy];
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
        issuerCell.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 删除数据源的数据,self.cellData是你自己的数据
        TNReceiverObject *object = self.dataSource[indexPath.row];
        [[TNSqlManager instance] deleteReceiverWithName:object.receiverId];
        [self.dataSource removeObjectAtIndex:indexPath.row];
        // 删除列表中数据
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
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

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
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

- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [UIButton new];
        [_leftButton setImage:[UIImage imageNamed:@"backarrow-white"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(cardGoBack) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.frame = CGRectMake(13, 25 + kStatusExtensionHeight, 22, 40);
    }
    return _leftButton;
}

@end
