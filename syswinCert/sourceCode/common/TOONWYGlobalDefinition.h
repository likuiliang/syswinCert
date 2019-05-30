//
//  TOONWYGlobalDefinition.h
//  Pods
//
//  Created by 王妍 on 2018/3/29.
//

#ifndef TOONWYGlobalDefinition_h
#define TOONWYGlobalDefinition_h

//-------------------------------------开发环境---------------------------------------------------
#define TN_ENV_Domain [[NSBundle mainBundle] objectForInfoDictionaryKey:@"toon_domain"]
#define IS_ENV_Develop [TN_ENV_Domain isEqualToString:@"t100."]
#define IS_ENV_Online [TN_ENV_Domain length]==0
#define IS_ENV_Testing [TN_ENV_Domain isEqualToString:@"t200."]
#define IS_ENV_PreOnline [TN_ENV_Domain isEqualToString:@"p100."]

#define KDocumentDirectory  ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject])

#define KLocalSourceFilePath ([KDocumentDirectory stringByAppendingPathComponent:@"syswinCert"])

#import "UIColor+Extension.h"
#import "Masonry.h"
#import <TJson/NSStringTNJson.h>
#import <TJson/NSDictionaryTNJson.h>
#import <TJson/TNJsonSerializableObject.h>
#import "TNSqlManager.h"
#import "TNCertManager.h"

//-------------------------------------公用方法定义---------------------------------------------------
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

#define CGPointMake1(x,y)           CGPointMake(W(x),H(y))
#define CGSizeMake1(w,h)            CGSizeMake(W(w),H(h))
#define CGRectMake1(x,y,w,h)        CGRectMake(W(x),H(y),W(w),H(h))

#define TNA_UPHEIGHT                (64)

//其他
#define UserDefaults                [NSUserDefaults standardUserDefaults]
#define TNA_Share_Content_Name      @"TNA_Share_Content_Name"

#define INCH35 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define INCH4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define INCH47 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define INCH55 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define INCH55B ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)



#define INCH35_Xib_Appending_String  @"_inch35"
#define INCH4_Xib_Appending_String   @"_inch4"
#define INCH47_Xib_Appending_String  @"_inch47"
#define INCH55_Xib_Appending_String  @"_inch55"
#define INCH55B_Xib_Appending_String @"_inch55b"


//--------------------------------------常量定义---------------------------------------------------
#define QiNiuRssURL @"http://css.toon.mobi/"
#define kTNTingyunAppKey @"cf80ab6838fa4cf9ba3045fe1146a8c4"
#define QINIU_VEDIO_THUMBNAIL @"?vframe/jpg/offset/0/w/300/h/300"


// 默认头像
#define HumanPlaceHolderImage @"default_self_card_icon"

#define GroupPlaceHolderImage @"default_group_card_icon"

// 群组名片的默认背景图片
#define CardGroupBackgroundPlaceHolderImage @"card_group_backgroup_icon"

#define GroupParentBackgroundPlaceHolderImage @"frame_parentBackground_p"

#define GroupNeighborBackgroundPlaceHolderImage @"frame_neighborBackground_p"

#define GroupOwner_committeeBackgroundPlaceHolderImage @"frame_owner_committeeBackground_p"



// 员工的默认头像
#define StaffPlaceHolderImageName @"default_staff_card_icon"

// 公司默认头像
#define OrgPlaceHolderImageName @"default_org_card_icon"

// 门户默认头像
#define PortalPlaceHolderImageName @"portal_default_icon"

#define ActivityPlaceHolderImageName @"frame_activity_p"

#define CriclePlaceHolderImageName @"frame_cricle_p@3x"

#define Scenic_regionPlaceHolderImageName @"scenic_region_default_icon"

#define SchoolPlaceHolderImageName @"school_default_icon"

//toon跳转模块默认是动画跳转,若在参数字典中传入此key，且值value为@(1) 就是不动态跳转
#define kToonGlobalNavigationNotAnimatedKey @"toonGlobalNavigationAnimatedTitle"

#define kTNCImageThumbnailMaxSize 230   //聊天缩略图最大尺寸
#define kTNCImageLargeMaxSize 960       //聊天原图最大尺寸

#define kTNCImageScaleThumbnail 0.4     //聊天缩略图压缩质量
#define kTNCImageScaleOrigin 0.5     //聊天原图压缩质量

//--------------------------------------常用尺寸---------------------------------------------------
#define kStatusBarHeight  20
#define kNaviBarHeight 44
#define kTabBarHeight 49
#define kNewTabBarHeight 54
#define SCREEN_HEIGHT               [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH                ([UIScreen mainScreen].bounds.size.width)
#define ScreenWidthOfIphone6        375
#define ScreenBoundWith [UIScreen mainScreen].bounds.size.width
#define ScreenBoundHeight [UIScreen mainScreen].bounds.size.height
#define ScreenFrameWidth [UIScreen mainScreen].applicationFrame.size.width  //与statusbar相关
#define ScreenFrameHeight [UIScreen mainScreen].applicationFrame.size.height


//字体
#define TNA_SystemFont(f)           [UIFont systemFontOfSize:f]
#define TNA_SystemFont14            TNA_SystemFont(14)
#define TNA_SystemFont16            TNA_SystemFont(16)

#pragma mark ----屏幕适配宏----
#define FIT(x)   (SCREEN_WIDTH/375 *x)/2

//#define MaxWidth  (IS_IPHONE_5_4 ? 208 : (IS_IPHONE_6 ? 254 : 280))
#define W375(f)            SCREEN_WIDTH/375*(f)
#define H(f)            (ScreenBoundHeight == 480?568:ScreenBoundHeight)/568*(f)
#define W(f)            ScreenBoundWith/320*(f)
#define WI(f)   ScreenFrameWidth <= 375 ? (f) :  SCREEN_WIDTH/375 *(f)
#define HE(f)   ScreenFrameHeight <= 667 ? (f) :SCREEN_HEIGHT/667 *(f)
#define CWI(f)   ScreenFrameWidth <= 375 ? (f) :  SCREEN_WIDTH/375 *(f)
#define CHE(f)   ScreenFrameHeight <= 667 ? (f) :SCREEN_HEIGHT/667 *(f)

#define WH(f) (SCREEN_HEIGHT/667*(f))
#define HI(f) (SCREEN_WIDTH/375*(f))

#define CGRectMake1(x,y,w,h)        CGRectMake(W(x),H(y),W(w),H(h))

//--------------------------------------手机型号---------------------------------------------------
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define IS_IPHONE_5_4 (SCREEN_HEIGHT == 568.0) || (SCREEN_HEIGHT == 480)
#define IS_IPHONE_5_OR_5S   SCREEN_HEIGHT == 568 ? YES:NO
#define IS_IPHONE_6P     SCREEN_WIDTH == 414 ? YES:NO
#define IS_IPHONE_6      SCREEN_WIDTH == 375 ? YES:NO
#define IS_IPHONE_4 (SCREEN_HEIGHT == 480)
#define IS_IPHONE_6_OR_LATER        [[UIScreen mainScreen] bounds].size.width >= 375 ? YES:NO
#define IS_IPHONE_X (SCREEN_WIDTH >= 375) && (SCREEN_HEIGHT >= 812)

//--------------------------------------ios版本---------------------------------------------------
#define IOSVersion  [[UIDevice currentDevice].systemVersion floatValue]
#define IOS8_OR_LATER ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0)

/*
 *ios版本判断
 */
#define IOS_Ver(version) ([[UIDevice currentDevice].systemVersion doubleValue] >= version)

//--------------------------------------颜色---------------------------------------------------
#define kToonColor0 [UIColor colorWithHEXString:@"2894FF"]        //项目主色调
#define kToonColor1 [UIColor colorWithHEXString:@"F2F2F4"]         //页面背景色
#define kToonColor2 [UIColor colorWithRed:221/255.0 green:222/255.0 blue:227/255.0 alpha:1.0] //分割线颜色
#define kToonColor3 [UIColor colorWithHEXString:@"FFB90F"]         //高亮文字,橘黄色
#define kToonColor4 [UIColor colorWithHEXString:@"008B00"]

//基本颜色
#define TNA_BACK_GROUND_COLOR        RGBCOLOR(242, 242, 244)  //框架背景颜色(白灰色)
#define TNA_LINE_BACK_COLOR          RGBCOLOR(221, 222, 227)  //线背景颜色(白灰色)

//文字颜色
#define TNA_TEXT_DARK_BLACK_COLOR    RGBCOLOR(0  , 0  , 0  )  //框架文字(title)颜色(黑色)
#define TNA_TEXT_LIGHT_BLACK_COLOR   RGBCOLOR(119, 126, 140)  //框架文字(正文，提示)颜色(浅灰色)
#define TNA_TEXT_ASSIST_BLACK_COLOR  RGBCOLOR(172, 179, 191)  //框架文字(辅助，时间)颜色(白浅灰色)

#define TNA_TEXT_RED_COLOR           RGBCOLOR(222, 72  , 76 )  //框架文字颜色(暗红色)
#define TNA_TEXT_BLUE_COLOR          RGBCOLOR(0  , 122 , 255)  //右上角按钮色(深蓝色)
#define TNA_TEXT_ORANGE_COLOR        RGBCOLOR(249, 143 , 58 )  //框架文字颜色(橘黄色)
#define TNA_TEXT_GREEN_COLOR         RGBCOLOR(0  , 174 , 118)  //交易成功颜色(暗绿色)

//背景颜色
#define TNA_BUTTON_BLUE_COLOR        RGBCOLOR(31 , 175 , 252)  //赠予按钮背景色(天蓝色)
#define TNA_BUTTON_GRAY_COLOR        RGBCOLOR(221, 222, 227)  //按钮背景色(灰色)



#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//十六进制颜色赋值
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define KRegisterAppicationSuccess     @"registerAppicationSuccess"     //注册应用成功

// - 适配 iphone X navigationHeight
#define kStatusExtensionHeight ((fabs(CGRectGetHeight([UIScreen mainScreen].bounds) - 812.) >= 1.0) ? (0.) : (24.))
#define kTabBarExtensionHeight ((fabs(CGRectGetHeight([UIScreen mainScreen].bounds) - 812.) >= 1.0) ? (0.) : (34.))
#define kNewNavigationHeight (64 + kStatusExtensionHeight)
#define kNewStatusBarHeight (20. + kStatusExtensionHeight)

#endif /* TOONWYGlobalDefinition_h */
