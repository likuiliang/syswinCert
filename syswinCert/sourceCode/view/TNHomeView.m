//
//  TNHomeView.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/27.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNHomeView.h"
#import "TOONWYGlobalDefinition.h"
#import "TNIssuerCell.h"

@interface TNHomeView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *homeTableView;
@property (nonatomic, strong) UIButton *icoundBtn;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation TNHomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.homeTableView];
        [self addSubview:self.icoundBtn];
        [self updateHomeConstraints];
    }
    return self;
}

- (void)updateTableViewWithDataSource:(NSArray *)dataSource
{
    self.dataSource = dataSource;
    [self.homeTableView reloadData];
}

- (void)updateHomeConstraints
{
    [self.homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).with.offset(-170);
        make.top.mas_equalTo(self);
    }];
    
    [self.icoundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.bottom.mas_equalTo(self).with.offset(-100);
    }];
}

#pragma mark - delegate

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

- (void)icoundBtnOnClick
{
    [self.delegate homeViewImportIcoundOnClick];
}

#pragma mark - 懒加载

- (UITableView *)homeTableView
{
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        _homeTableView.tableFooterView = [UIView new];
//        if (@available(iOS 11.0, *)) {
//            _homeTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }
    }
    return _homeTableView;
}

- (UIButton *)icoundBtn
{
    if (!_icoundBtn) {
        _icoundBtn = [[UIButton alloc] init];
        [_icoundBtn setTitle:@"导入证书" forState:UIControlStateNormal];
        [_icoundBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _icoundBtn.backgroundColor = [UIColor colorWithHEXString:@"#355ACF"];
        [_icoundBtn addTarget:self action:@selector(icoundBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _icoundBtn;
}

- (NSArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSArray new];
    }
    return _dataSource;
}

@end
