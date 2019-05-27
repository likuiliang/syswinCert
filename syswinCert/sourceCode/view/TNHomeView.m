//
//  TNHomeView.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/27.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNHomeView.h"
#import "TOONWYGlobalDefinition.h"


@interface TNHomeView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *homeScrollView;
@property (nonatomic, strong) UIButton *icoundBtn;

@end

@implementation TNHomeView

- (instancetype)init
{
    if (self = [super init]) {
        [self addSubview:self.homeScrollView];
        [self addSubview:self.icoundBtn];
        [self updateHomeConstraints];
    }
    return self;
}

- (void)updateHomeConstraints
{
    [self.homeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 80, 0));
    }];
    
    [self.icoundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.mas_equalTo(40);
        make.right.mas_equalTo(-40);
        make.bottom.mas_equalTo(self).with.offset(-15);
    }];
}

- (void)icoundBtnOnClick
{
    [self.delegate homeViewImportIcoundOnClick];
}

#pragma mark - 懒加载

- (UIScrollView *)homeScrollView
{
    if (!_homeScrollView) {
        _homeScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 70)];
        _homeScrollView.bounces = YES;
        _homeScrollView.scrollEnabled = YES;
        _homeScrollView.delegate = self;
        _homeScrollView.contentOffset = CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT - 70);
        if (@available(iOS 11.0, *)) {
            _homeScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _homeScrollView.backgroundColor = [UIColor yellowColor];
    }
    return _homeScrollView;
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

@end
