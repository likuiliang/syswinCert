//
//  TNCardHiddenNavigationController.m
//  FBSnapshotTestCase
//
//  Created by likuiliang-Answer on 2018/3/26.
//

#import "TNCardHiddenNavigationController.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, TNViewLifeCycle) {
    ViewLifeCycle_DidLoad,
    ViewLifeCycle_WillAppear,
    ViewLifeCycle_DidAppear,
    ViewLifeCycle_WillDisappear,
    ViewLifeCycle_DidDisappear,
};

@interface TNCardHiddenNavigationController ()
@property(nonatomic, weak) UIViewController *lastTopController;
@property(nonatomic, weak) UIViewController *lastBottomController;

@property(nonatomic, assign) TNViewLifeCycle viewCycle;

/** 原来页面导航栏透明状态 */
@property (nonatomic, assign) BOOL isTranslucent;
@end

@implementation TNCardHiddenNavigationController

#pragma mark - Override Init
- (id)init {
    if (self = [super init]) {
        self.hiddenNavigationBar = YES;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.hiddenNavigationBar = YES;
    }
    
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.hiddenNavigationBar = YES;
    }
    return self;
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.viewCycle = ViewLifeCycle_DidLoad;
    
    if (self.navigationController.viewControllers.count > 1 && self.hiddenNavigationBar) {
        self.lastBottomController = self.navigationController.viewControllers[self.navigationController.viewControllers.count - 2];
        self.isTranslucent = self.navigationController.navigationBar.isTranslucent;
        [[UIDevice currentDevice].systemVersion doubleValue] >= 11.0 ? [self.navigationController.navigationBar setTranslucent:YES] : nil;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.hiddenNavigationBar) {
        if (self.lastTopController.hiddenNavigationBar || self.viewCycle == ViewLifeCycle_DidLoad) {
            [self resetNavigationBarBackground:0.];
            [self.navigationController setNavigationBarHidden:YES animated:NO];
        } else {
            [self.navigationController setNavigationBarHidden:YES animated:animated];
        }
    } else {
        [self resetNavigationBarBackground:1.];
    }
    self.viewCycle = ViewLifeCycle_WillAppear;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.viewCycle = ViewLifeCycle_DidAppear;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.viewCycle = ViewLifeCycle_WillDisappear;
    if (self.hiddenNavigationBar) {
        if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound) {
            self.lastTopController = nil;
            if ([self.lastBottomController isKindOfClass:[TNCardHiddenNavigationController class]]) {
                [self.lastBottomController.navigationController setNavigationBarHidden:YES animated:NO];
            } else {
                [self resetNavigationBarBackground:1.];
            }
        } else {
            self.lastTopController = self.navigationController.viewControllers.lastObject;
            if (!self.navigationController.viewControllers.lastObject.hiddenNavigationBar) {
                [self.navigationController setNavigationBarHidden:NO animated:animated];
            } else {
                [self.navigationController setNavigationBarHidden:YES animated:NO];
            }
            [self resetNavigationBarBackground:1.];
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.viewCycle = ViewLifeCycle_DidDisappear;
}

- (void)resetNavigationBarBackground:(CGFloat)alpha {
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 11.0) {
        self.navigationController.navigationBar.alpha = alpha;
        [self resetSubViewAlpha:self.navigationController.navigationBar withAlpha:alpha];
    } else {
        for (UIView *subview in self.navigationController.navigationBar.subviews) {
            if ([subview isKindOfClass:NSClassFromString(@"_UIBarBackground")]) {
                subview.alpha = alpha;
                break;
            }
        }
    }
}

- (void)resetSubViewAlpha:(UIView *)view withAlpha:(CGFloat)alpha {
    for (UIView *tmp in view.subviews) {
        if ([tmp isKindOfClass:NSClassFromString(@"_UIButtonBarStackView")] || [tmp isKindOfClass:NSClassFromString(@"_UITAMICAdaptorView")] || [NSStringFromClass(tmp.class).lowercaseString hasPrefix:@"tn"])
        {            continue;
        } else {
            tmp.alpha = alpha;
        }
        tmp.subviews.count > 0 ? [self resetSubViewAlpha:tmp withAlpha:alpha] : nil;
    }}
@end

static const char kTNViewControllerHiddenNavigationBarKey;

@implementation UIViewController(HiddenNavigationBar)
@dynamic hiddenNavigationBar;

- (void)setHiddenNavigationBar:(BOOL)hiddenNavigationBar {
    objc_setAssociatedObject(self, &kTNViewControllerHiddenNavigationBarKey, @(hiddenNavigationBar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hiddenNavigationBar {
    return [objc_getAssociatedObject(self, &kTNViewControllerHiddenNavigationBarKey) boolValue];
}
@end

