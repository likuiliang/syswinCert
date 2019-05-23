//
//  MBProgressHUD+Extend.m
//  Toon
//
//  Created by 杜志坚 on 16/4/15.
//  Copyright © 2016年 思源. All rights reserved.
//

#import "MBProgressHUD+Extend.h"
#define TNCKFontSize 13.0
#define TNCKDelayTime 1.3
#define TNCKHudAlpha 0.7
#define TNCKMargin 10.0
#define TNCKDefaultCustomViewRect CGRectMake(0, 0, 50, 36)
#define TNCKMinSize CGSizeMake(120, 120);
//识别iPhone5的宏
#define TNCIS_IPHONE_5 (fabs((double)[[UIScreen mainScreen] bounds].size.height - (double )568) < DBL_EPSILON )

@implementation MBProgressHUD (Extend)

//只显示message(动画时间1.3s)
+ (void)showMessage:(NSString *)message inView:(UIView *)view
{
    [self showMessage:message inView:view duration:TNCKDelayTime];

}

//显示message和图片
+ (void)showMessage:(NSString *)message withImageName:(NSString *)imageName inView:(UIView *)view
{
    [self showMessage:message withImageName:imageName inView:view duration:TNCKDelayTime];
    
}

////显示message和根据图片枚举类型显示图片
//+ (void)showMessage:(NSString *)message withImageType:(ImageType )imageType inView:(UIView *)view
//{
//    switch (imageType) {
//            //对号样式
//        case SucceedImage:
//            [self showMessage:message withImageName:@"正确提示.png" inView:view];
//            break;
//            //叉号样式
//        case ErrorImage:
//            [self showMessage:message withImageName:@"错误提示.png" inView:view];
//            break;
//            //感叹号样式
//        case ExclamationMarkImage:
//            [self showMessage:message withImageName:@"警示感叹号.png" inView:view];
//            break;
//        default:
//            break;
//    }
//    
//}

//显示图片加Message并可设置动画时间
+ (void)showMessage:(NSString *)message withImageName:(NSString *)imageName inView:(UIView *)view duration:(NSTimeInterval)duration;
{
    CGRect defaultsRect = TNCKDefaultCustomViewRect;
    [self showMessage:message withImageName:imageName andImageRect:defaultsRect inView:view duration:duration];
}
+ (MBProgressHUD *)commonHUDForView:(UIView *)view{
    [MBProgressHUD hideHUDForView:view animated:NO];

    if (view == nil) {
        view =  ([UIApplication sharedApplication].delegate).window;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];

    hud.bezelView.style= MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.color =[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5/1.0];
    hud.contentColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:TNCKFontSize];
    hud.label.font = [UIFont systemFontOfSize:TNCKFontSize];
    hud.backgroundView.backgroundColor = [UIColor colorWithRed:0
                                                          green:0
                                                           blue:0
                                                          alpha:0];;
//    hud.backgroundView.alpha = .3;
    hud.minSize = TNCKMinSize;
//    hud.userInteractionEnabled = NO; //如果设置为NO，则会导致HUD下面的View可被点击
    hud.margin = TNCKMargin;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}
//只显示message
+ (void)showMessage:(NSString *)message inView:(UIView *)view duration:(NSTimeInterval)duration;
{
    if (!message) {
        return;
    }
    // Fire off an asynchronous task, giving UIKit the opportunity to redraw wit the HUD added to the
    // view hierarchy.
    dispatch_async(dispatch_get_main_queue(), ^{
        //  显示提示信息
        MBProgressHUD *hud = [MBProgressHUD commonHUDForView:view];
        hud.mode = MBProgressHUDModeText;
        hud.minSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 100, 30);;
        hud.detailsLabel.text = message;
        [hud hideAnimated:YES afterDelay:duration];
        if (TNCIS_IPHONE_5) {
            hud.offset = CGPointMake(0, -25);
        }
        else{
             hud.offset = CGPointMake(0, -20);
        }
        
    });
}

//显示图片、message、图片大小及动画时间
+ (void)showMessage:(NSString *)message withImageName:(NSString *)imageName andImageRect:(CGRect)rect  inView:(UIView *)view duration:(NSTimeInterval)duration {

    if ((!message) && (!imageName)) {
        return;
    }
    
    // Fire off an asynchronous task, giving UIKit the opportunity to redraw wit the HUD added to the
    // view hierarchy.
    dispatch_async(dispatch_get_main_queue(), ^{
        // 快速显示一个提示信息
        MBProgressHUD *hud = [MBProgressHUD commonHUDForView:view];
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        if (message) {
            //message与image之间的留白距离大小以label字体的大小控制
            //控制message与image之间的距离

            hud.label.font = [UIFont  systemFontOfSize:5];
            hud.label.text = @" ";
            hud.detailsLabel.text = message;
        }

        if (imageName) {
            // 设置图片
            UIImageView *customView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
            customView.frame = rect;
            customView.center = hud.center;
            customView.contentMode = UIViewContentModeScaleAspectFit;
            hud.customView = customView;
            // 再设置模式
            hud.mode = MBProgressHUDModeCustomView;
        }
        [hud hideAnimated:YES afterDelay:duration];
    });
}

+ (MBProgressHUD *)showActivityIndicatorViewInView:(UIView *)view withMessage:(NSString *)message dimBackground:(BOOL)dimBackground
{

        __block MBProgressHUD *hud= [MBProgressHUD commonHUDForView:view];
    //offset控制偏移距离
//    hud.offset = CGPointMake(0,-50);
    //margin控制提示框距离view的边距
//    hud.margin = 80;
    //minSize控制提示框最小的尺寸
//    hud.minSize = CGSizeMake(20, 10);


    //获取定制化字典中的字段
    NSDictionary *showActivityDic = nil;

    //图片字段数组为零时，默认选择toon项目中的提示框样式及调用
    if ([showActivityDic[@"animationImages"] count] == 0) {
        // Fire off an asynchronous task, giving UIKit the opportunity to redraw wit the HUD added to the
        // view hierarchy.
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!dimBackground) {
                hud.backgroundView.backgroundColor = [UIColor clearColor];
            }
            hud.label.font = [UIFont  systemFontOfSize:7];
            hud.label.text = @" ";
            if (message == nil) {
                hud.detailsLabel.text = @"加载中";
            }
            else{
                 hud.detailsLabel.text = message;
            }
           
        });
    }

    //图片字段数组不为零时，为定制方的样式
    else{
            hud.mode=MBProgressHUDModeCustomView;
            hud.bezelView.color = [UIColor clearColor];
            hud.backgroundView.backgroundColor= [UIColor clearColor];
            NSMutableArray *array=[NSMutableArray arrayWithCapacity:0];
            //获取图片字段的Value
            NSArray *humImages = showActivityDic[@"animationImages"];
            if (![humImages isKindOfClass:[NSArray class]]) return nil ;
            [humImages enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSString *imageName = [NSString stringWithFormat:@"%@",obj];
                UIImage *image = [UIImage imageNamed:imageName];
                [array addObject:image];
            }];
            UIImageView *ameg=[[UIImageView alloc]initWithImage:array.firstObject];
            ameg.animationImages=array;
            //获取动画时间字段的Value
            NSTimeInterval time = [showActivityDic[@"animationTime"] doubleValue];
            ameg.animationDuration = time;
            [ameg startAnimating];
            hud.customView=ameg;
    }
    return hud;
}

+ (void)hideActivityIndicatorViewHUD:(MBProgressHUD *)hud
{
    if (!hud) {
        return;
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES];
}

+ (void)hideHudInView:(UIView *)view animated:(BOOL)animated
{
    if (view == nil) {
        view = ([UIApplication sharedApplication].delegate).window;
    }

    [MBProgressHUD hideHUDForView:view animated:animated];
}

+ (MBProgressHUD *)showProgressDeterminateHUDInView:(UIView *)view withMessage:(NSString *)message determinateType:(MBProgressHUDMode)determinateType;
{
    __block MBProgressHUD *hud= [MBProgressHUD commonHUDForView:view];;
    // Fire off an asynchronous task, giving UIKit the opportunity to redraw wit the HUD added to the
    // view hierarchy.
    dispatch_async(dispatch_get_main_queue(), ^{
        // Set the determinate mode to show task progress.
        if (determinateType) {
            hud.mode = determinateType;
        } else {
            hud.mode = MBProgressHUDModeAnnularDeterminate;
        }
        hud.detailsLabel.text = message;
    });
    return hud ;
}


@end
