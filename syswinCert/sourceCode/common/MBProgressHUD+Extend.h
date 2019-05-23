//
//  MBProgressHUD+Extend.h
//  Toon
//
//  Created by 杜志坚 on 16/4/15.
//  Copyright © 2016年 思源. All rights reserved.
//

#import "MBProgressHUD.h"


//typedef enum : NSUInteger {
//    //对号样式
//    SucceedImage,
//    //叉号样式
//    ErrorImage,
//    //感叹号样式
//     ExclamationMarkImage,
//} ImageType;


@interface MBProgressHUD (Extend)

/**
 *   显示提示语,默认3秒后消失，没传message 则不显示，如果没传view，默认显示在window上
 *
 *  @param message 提示信息
 *  @param view    在哪个view上显示
 */
+ (void)showMessage:(NSString *)message inView:(UIView *)view;

/**
 *  显示提示语，没传message 则不显示，如果没传view，默认显示在window上
 *
 *  @param message 提示信息
 *  @param view    在哪个view上显示
 *  @param duration 多长时间后消失
 */
+ (void)showMessage:(NSString *)message inView:(UIView *)view duration:(NSTimeInterval)duration;


/**
 *   显示带图片的提示，默认3秒后消失，message和image 都为空 则不显示，如果没传view，默认显示在window上
 *
 *  @param message 提示信息
 *  @param imageName 显示图片的信息
 *  @param view      在哪个view上显示
 */
+ (void)showMessage:(NSString *)message withImageName:(NSString *)imageName inView:(UIView *)view ;

////通过枚举来封装各种样式的图标
//+ (void)showMessage:(NSString *)message withImageType:(ImageType )imageType inView:(UIView *)view ;


/**
 *  显示带图片的提示，message和image 都为空 则不显示，如果没传view，默认显示在window上
 *
 *  @param message   提示信息
 *  @param imageName 显示图片的名字
 *  @param view      在哪显示
 *  @param duration  显示时长
 */
+ (void)showMessage:(NSString *)message withImageName:(NSString *)imageName inView:(UIView *)view duration:(NSTimeInterval)duration;

+ (MBProgressHUD *)commonHUDForView:(UIView *)view;

+ (void)showMessage:(NSString *)message withImageName:(NSString *)imageName andImageRect:(CGRect)rect inView:(UIView *)view duration:(NSTimeInterval)duration ;

/**
 *  显示网络请求的转动菊花 和 + (void)hideActivityIndicatorViewHUD:(MBProgressHUD *)hud 成对使用
 *
 *  @param view          view
 *  @param message       信息
 *  @param dimBackground 是否显示蒙版，yes显示，no不显示
 *
 *  @return MBProgressHUD
 */
+ (MBProgressHUD *)showActivityIndicatorViewInView:(UIView *)view withMessage:(NSString *)message dimBackground:(BOOL)dimBackground;

/**
 *  隐藏转动菊花
 *
 *  @param hud 要隐藏的MBProgressHUD
 */
+ (void)hideActivityIndicatorViewHUD:(MBProgressHUD *)hud;

+ (void)hideHudInView:(UIView *)view animated:(BOOL)animated;

/**
 *  进度指示框,返回当前的hud
 *
 *  @param view            view
 *  @param message         显示的信息
 *  @param determinateType 进度条的类型：
        MBProgressHUDModeDeterminate：圆形，按扇形分割进度；
        MBProgressHUDModeDeterminateHorizontalBar：横条进度；
        MBProgressHUDModeAnnularDeterminate：圆圈，按外圈圆环进度进行
 
    说明：调用进度指示框需要自己传入进度，待进度执行完成后，自己隐藏HUD
        可以参考如下的代码 进行进度更新和hud隐藏
        获取当前HUD 可以调用[MBProgressHUD HUDForView:view]方法，或者下面的类方法会返回HUD实例
 
         dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
         // Do something useful in the background and update the HUD periodically.
            float progress = 0.0f;
            while (progress < 1.0f) {
                progress += 0.01f;
                dispatch_async(dispatch_get_main_queue(), ^{
                    // Instead we could have also passed a reference to the HUD
                    // to the HUD to myProgressTask as a method parameter.
                    [MBProgressHUD HUDForView:view].progress = progress;
                });
                //usleep功能把进程挂起一段时间， 单位是微秒（千分之一毫秒）
                usleep(50000);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [[MBProgressHUD HUDForView:view] hide:YES];
            });
         });
 */
+ (MBProgressHUD *)showProgressDeterminateHUDInView:(UIView *)view withMessage:(NSString *)message determinateType:(MBProgressHUDMode)determinateType;


@end
