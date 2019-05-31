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
@property (nonatomic, strong) UIView *defaultView;

@end

@implementation TNHomeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.homeTableView];
        [self.homeTableView addSubview:self.defaultView];
        [self addSubview:self.icoundBtn];
        [self updateHomeConstraints];
    }
    return self;
}

- (void)updateTableViewWithDataSource:(NSArray *)dataSource
{
    self.dataSource = dataSource;
    self.defaultView.hidden = self.dataSource.count;
    [self.homeTableView reloadData];
}

- (void)updateHomeConstraints
{
    [self.homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self).with.offset(-100);
        make.top.mas_equalTo(self);
    }];
    
    [self.icoundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.bottom.mas_equalTo(self).with.offset(-30);
    }];
    
    [self.defaultView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 300));
        make.center.mas_equalTo(self);
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
    TNIssuerObject *issuerObject = self.dataSource[indexPath.row];
    [self.delegate homeViewCellDidSelectWithModel:issuerObject];
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
        if (@available(iOS 11.0, *)) {
            _homeTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
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
        _icoundBtn.layer.masksToBounds = YES;
        _icoundBtn.layer.cornerRadius = 10;
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

- (UIView *)defaultView
{
    if (!_defaultView) {
        _defaultView = [[UIView alloc] init];
        _defaultView.hidden = YES;
        UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"not_cert_image"]];
        iconImageView.contentMode =  UIViewContentModeScaleAspectFill;
        UILabel *titleLabel = [UILabel new];
        titleLabel.text = @"暂无证书\n您可以点击下方“导入证书”完成添加";
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = [UIColor colorWithHEXString:@"#8E8E93"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_defaultView addSubview:iconImageView];
        [_defaultView addSubview:titleLabel];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(136, 146));
            make.centerX.mas_equalTo(self->_defaultView);
            make.top.mas_equalTo(self->_defaultView);
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(iconImageView.mas_bottom).with.offset(20);
            make.left.mas_equalTo(self->_defaultView);
            make.right.mas_equalTo(self->_defaultView);
            make.height.mas_equalTo(50);
        }];
    }
    return _defaultView;
}

@end
