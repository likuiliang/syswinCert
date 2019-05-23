//
//  UIColor+Extension.h
//  MZSelectableLabelDemo
//
//  Created by Michał Zaborowski on 05.08.2014.
//  Copyright (c) 2014 Michal Zaborowski. All rights reserved.
//
// http://stackoverflow.com/questions/970475/how-to-compare-uicolors

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>

#define SUPPORTS_UNDOCUMENTED_API	0

@interface UIColor (Extension)

@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
@property (nonatomic, readonly) BOOL canProvideRGBComponents;

// With the exception of -alpha, these properties will function
// correctly only if this color is an RGB or white color.
// In these cases, canProvideRGBComponents returns YES.
@property (nonatomic, readonly) CGFloat red;
@property (nonatomic, readonly) CGFloat green;
@property (nonatomic, readonly) CGFloat blue;
@property (nonatomic, readonly) CGFloat white;
@property (nonatomic, readonly) CGFloat hue;
@property (nonatomic, readonly) CGFloat saturation;
@property (nonatomic, readonly) CGFloat brightness;
@property (nonatomic, readonly) CGFloat alpha;
@property (nonatomic, readonly) CGFloat luminance;
@property (nonatomic, readonly) UInt32 rgbHex;

- (NSString *)colorSpaceString;
- (NSArray *)arrayFromRGBAComponents;

// Bulk access to RGB and HSB components of the color
// HSB components are converted from the RGB components
- (BOOL)red:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b alpha:(CGFloat *)a;
- (BOOL)hue:(CGFloat *)h saturation:(CGFloat *)s brightness:(CGFloat *)b alpha:(CGFloat *)a;

// Return a grey-scale representation of the color
- (UIColor *)colorByLuminanceMapping;

// Arithmetic operations on the color
- (UIColor *)colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *)       colorByAddingRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *) colorByLighteningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
- (UIColor *)  colorByDarkeningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

- (UIColor *)colorByMultiplyingBy:(CGFloat)f;
- (UIColor *)       colorByAdding:(CGFloat)f;
- (UIColor *) colorByLighteningTo:(CGFloat)f;
- (UIColor *)  colorByDarkeningTo:(CGFloat)f;

- (UIColor *)colorByMultiplyingByColor:(UIColor *)color;
- (UIColor *)       colorByAddingColor:(UIColor *)color;
- (UIColor *) colorByLighteningToColor:(UIColor *)color;
- (UIColor *)  colorByDarkeningToColor:(UIColor *)color;

// Related colors
- (UIColor *)contrastingColor;			// A good contrasting color: will be either black or white
- (UIColor *)complementaryColor;		// A complementary color that should look good with this color
- (NSArray*)triadicColors;				// Two colors that should look good with this color
- (NSArray*)analogousColorsWithStepAngle:(CGFloat)stepAngle pairCount:(int)pairs;	// Multiple pairs of colors

// String representations of the color
- (NSString *)stringFromColor;
- (NSString *)hexStringFromColor;

// The named color that matches this one most closely
//- (NSString *)closestColorName;
//- (NSString *)closestCrayonName;

// Color builders
//+ (UIColor *)randomColor;
+ (UIColor *)colorWithString:(NSString *)stringToConvert;
+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithRGBHex:(UInt32)hex alpha:(float)alpha;
+ (UIColor *)colorWithHEXString:(NSString *)stringToConvert;
+ (UIColor *)colorWithHEXString:(NSString *)stringToConvert alpha:(float)alpha;
+ (UIColor *)colorWithName:(NSString *)cssColorName;
+ (UIColor *)crayonWithName:(NSString *)crayonColorName;

// Return a dictionary mapping color names to colors.
// The named are from the css3 color specification.
+ (NSDictionary *)namedColors;

// Return a dictionary mapping color names to colors
// The named are standard Crayola style colors
+ (NSDictionary *)namedCrayons;

// Build a color with the given HSB values
//+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha;

// Low level conversions between RGB and HSL spaces
+ (void)hue:(CGFloat)h saturation:(CGFloat)s brightness:(CGFloat)v toRed:(CGFloat *)r green:(CGFloat *)g blue:(CGFloat *)b;
+ (void)red:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b toHue:(CGFloat *)h saturation:(CGFloat *)s brightness:(CGFloat *)v;

- (BOOL)isEqualToColor:(UIColor *)otherColor;
/**
 * @bref 背景色
 */
+ (UIColor *)backgroundColor;

/**
 * @bref 正文颜色（列表正文）、电话
 */
+ (UIColor *)grayTextColor;
/*
 * @bref 边框线颜色，八宫格border
 */
+ (UIColor *)borderColor;
/*
 * @bref 昵称颜色、电话
 */
+ (UIColor *)nickNameColor;
/*
 * @bref 正文颜色
 */
+ (UIColor *)textColor;

/*
 * @bref 正文颜色（列表正文）、电话
 */
+ (UIColor *)listTitleColor;
/*
 * @bref tabbar字体颜色,icon的颜色
 */
+ (UIColor *)barTitleColor;
/*
 * @bref 搜索内文字颜色
 */
+ (UIColor *)searchTextColor;
/*
 * @bref 搜索背景色
 */
+ (UIColor *)searchBackgroudColor;
/*
 * @bref 提示字
 */
+ (UIColor *)alerTextColor;
/*
 * @bref 交互高光蓝
 */
+ (UIColor *)highlightColor;
/*
 * @bref 删除红；警示文字；左滑删除
 */
+ (UIColor *)toonRedColor;
/*
 * @bref toon的白色等
 */
+ (UIColor *)toonWhileColor;
/*
 * @bref vCard中打电话按钮的背景绿
 */
+ (UIColor *)callPhoneGreenColor;
/*
 * @bref toon 黄
 */
+ (UIColor *)toonYellow;
/*
 * @bref toon separate color
 */
+ (UIColor *)separatorColor;
/**
 *  @brief 子标题颜色
 */
+ (UIColor *)subtitleColor;
#pragma mark - color1 ~ color31 为 约定色板颜色 如自定义 请从 color100 开始自定义添加
/**
 *  @brief 交互高光蓝
 */
+ (UIColor *)color1;
/**
 *  @brief tabBar-light颜色
 */
+ (UIColor *)color2;
/**
 *  @brief button蓝色
 */
+ (UIColor *)color3;
/**
 *  @brief navigationBar（顶部导航栏）底色；默认title的底色
 */
+ (UIColor *)color4;
/**
 *  @brief 背景色
 */
+ (UIColor *)color5;
/**
 *  @brief 边框颜色press颜色，八宫格border颜色
 */
+ (UIColor *)color6;
/**
 *  @brief 辅助字
 */
+ (UIColor *)color7;
/**
 *  @brief 搜索内问题和icon颜色
 */
+ (UIColor *)color8;
/**
 *  @brief 正文颜色（列表颜色）；提示文字
 */
+ (UIColor *)color9;
/**
 *  @brief tabBar默认字体颜色
 */
+ (UIColor *)color10;
/**
 *  @brief 正文颜色；搜索输入后文字
 */
+ (UIColor *)color11;
/**
 *  @brief 昵称的颜色
 */
+ (UIColor *)color12;
/**
 *  @brief button 红色
 */
+ (UIColor *)color13;
/**
 *  @brief 删除红；警示文字；左滑删除
 */
+ (UIColor *)color14;
/**
 *  @brief 左滑操作黄色
 */
+ (UIColor *)color15;
/**
 *  @brief 服务信用，pc登录警示标语
 */
+ (UIColor *)color16;
/**
 *  @brief vCard上展板缕
 */
+ (UIColor *)color17;
/**
 *  @brief 视图中tab栏切换文字和icon 颜色
 */
+ (UIColor *)color18;
/**
 *  @brief titleBar 底部线的颜色，pc登录背景半圆
 */
+ (UIColor *)color19;
/**
 *  @brief list 白 同whiteColor
 */
+ (UIColor *)color20;

/**
 *  @brief list 会议通文字1 紫色
 */
+ (UIColor *)color21;
/**
 *  @brief list 会议通文字2 蓝色
 */
+ (UIColor *)color22;
/** 群组等级文字颜色 */
+ (UIColor *)color23;
/** 社交等级文字颜色 */
+ (UIColor *)color24;
/** 安卓弹出button文字颜色 */
+ (UIColor *)color25;
/** 安卓弹出提示文字颜色 */
+ (UIColor *)color26;
/** 编辑和展示item中title 文字 */
+ (UIColor *)color27;
/** 为空页字色 */
+ (UIColor *)color28;
/** 红色主题*/
+ (UIColor *)color29;
/** 注册流程名字+推广语 */
+ (UIColor *)color30;
/** 注册流程引导语 */
+ (UIColor *)color31;
/** Feed中女性年龄 */
+ (UIColor *)color32;
/** Feed中男性年龄 */
+ (UIColor *)color33;
/** pc扫码登入按钮*/
+ (UIColor *)color34;
/** pc扫码登入按钮阴影*/
+ (UIColor *)color35;
/** 中间间隔线颜色*/
+ (UIColor *)color36;
/** 副标题颜色*/
+ (UIColor *)color37;
/** 名片中个性签名*/
+ (UIColor *)color38;

+(UIColor *)color39;
#pragma mark  --- 以上 为约定色板的颜色

#pragma mark - 自定义颜色 请从 color100 开始自定义添
/**新feed优化 title 颜色  #383838*/
+ (UIColor *)color100;
/**新feed优化 subtitle 颜色 #9C9C9C*/
+ (UIColor *)color101;

+ (UIColor *)colorBlack_alpha:(CGFloat)alpha;

+ (UIColor *)color3_alpha:(CGFloat)alpha;

/* 群组信息 title 灰色*/
+ (UIColor *)colorCellTitleColor;

/*员工 组织 个人 个人服务 房通服务 群组 基本信息和信息设置listtitlecolor 灰色95989f*/
+ (UIColor *)titleColor;

+ (UIColor *)color:(UIColor *)color alpha:(CGFloat)alpha;
/* 等待与你交换名片的新朋友  浅粉背景色 */
+ (UIColor *)pinkColor;
/*
 群组标签名字颜色
 */
+ (UIColor *)colorGroupTagName;
/*
 红包的红色
 */
+ (UIColor *)redPacketsColor;
/*
 热门推荐标签桔色
 */
+ (UIColor *)orangeTagColor;

+ (UIColor *)toonBtnUnableColor;

#pragma mark - colorTemail1 ~ colorTemail13 为 Temail约定色板颜色 如自定义 请从 colorTemail100 开始自定义添加
/**
 *  @brief #007AFF LOGO用色，应用场景包括：系统主要功能、反馈交互、重要信息高亮、重点标记、主要按钮及ICON等
 */
+ (UIColor *)colorTemail1;

/**
 *  @brief #222222 应用于主标题、表单、文字按钮、正文等主要文本
 */
+ (UIColor *)colorTemail2;

/**
 *  @brief #383838 应用于导航栏标题文字、右侧文字操作等
 */
+ (UIColor *)colorTemail3;

/**
 *  @brief #8E8E93 应用于副文本、说明文本、搜索框文本等
 */
+ (UIColor *)colorTemail4;

/**
 *  @brief #A6A6A6 用于表单、文字按钮置灰状态等
 */
+ (UIColor *)colorTemail5;

/**
 *  @brief #C5C5C5 应用于待输入状态占字符文本、线性按钮框等
 */
+ (UIColor *)colorTemail6;

/**
 *  @brief #E1E1E1 用于分割线色值
 */
+ (UIColor *)colorTemail7;

/**
 *  @brief #F6F6F6 应用于APP默认背景色、分隔栏色值
 */
+ (UIColor *)colorTemail8;

/**
 *  @brief #007AFF 透明度50% 提醒/状态/置灰
 */
+ (UIColor *)colorTemail9;

/**
 *  @brief #007AFF 透明度60% 用于链接文字
 */
+ (UIColor *)colorTemail10;

/**
 *  @brief #4CD964 成功/开关
 */
+ (UIColor *)colorTemail11;

/**
 *  @brief #FF3B2F 报错等
 */
+ (UIColor *)colorTemail12;

/**
 *  @brief #FEA715 警告
 */
+ (UIColor *)colorTemail13;


@end

#if SUPPORTS_UNDOCUMENTED_API
// UIColor_Undocumented_Expanded
// Methods which rely on undocumented methods of UIColor
@interface UIColor (UIColor_Undocumented_Expanded)
- (NSString *)fetchStyleString;
- (UIColor *)rgbColor; // Via Poltras
@end
#endif // SUPPORTS_UNDOCUMENTED_API

