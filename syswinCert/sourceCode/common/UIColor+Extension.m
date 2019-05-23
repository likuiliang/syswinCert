//
//  UIColor+Extension.m
//  MZSelectableLabelDemo
//
//  Created by Michał Zaborowski on 05.08.2014.
//  Copyright (c) 2014 Michal Zaborowski. All rights reserved.
//
// http://stackoverflow.com/questions/970475/how-to-compare-uicolors

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "UIColor+Extension.h"

static const char *colorNameDB;
static const char *crayolaNameDB;

// Complete dictionary of color name -> color mappings, generated
// by a call to +namedColors or +colorWithName:
static NSDictionary *colorNameCache = nil;
static NSDictionary *crayolaNameCache = nil;
static NSLock *colorNameCacheLock;
static NSLock *crayolaNameCacheLock;

#if SUPPORTS_UNDOCUMENTED_API
// UIColor_Undocumented
// Undocumented methods of UIColor
@interface UIColor (UIColor_Undocumented)
- (NSString *)styleString;
@end
#endif // SUPPORTS_UNDOCUMENTED_API

@interface UIColor (UIColor_Expanded_Support)
+ (void)populateColorNameCache;
+ (void)populateCrayolaNameCache;
@end

#if SUPPORTS_UNDOCUMENTED_API
@implementation UIColor (UIColor_Undocumented_Expanded)
- (NSString *)fetchStyleString {
    return [self styleString];
}

// Convert a color into RGB Color space, courtesy of Poltras
// via http://ofcodeandmen.poltras.com/2009/01/22/convert-a-cgcolorref-to-another-cgcolorspaceref/
//
- (UIColor *)rgbColor {
    // Call to undocumented method "styleString".
    NSString *style = [self styleString];
    NSScanner *scanner = [NSScanner scannerWithString:style];
    CGFloat red, green, blue;
    if (![scanner scanString:@"rgb(" intoString:NULL]) return nil;
    if (![scanner scanFloat:&red]) return nil;
    if (![scanner scanString:@"," intoString:NULL]) return nil;
    if (![scanner scanFloat:&green]) return nil;
    if (![scanner scanString:@"," intoString:NULL]) return nil;
    if (![scanner scanFloat:&blue]) return nil;
    if (![scanner scanString:@")" intoString:NULL]) return nil;
    if (![scanner isAtEnd]) return nil;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:self.alpha];
}
@end
#endif
@implementation UIColor (Extension)

- (CGColorSpaceModel)colorSpaceModel {
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (NSString *)colorSpaceString {
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelUnknown:
            return @"kCGColorSpaceModelUnknown";
        case kCGColorSpaceModelMonochrome:
            return @"kCGColorSpaceModelMonochrome";
        case kCGColorSpaceModelRGB:
            return @"kCGColorSpaceModelRGB";
        case kCGColorSpaceModelCMYK:
            return @"kCGColorSpaceModelCMYK";
        case kCGColorSpaceModelLab:
            return @"kCGColorSpaceModelLab";
        case kCGColorSpaceModelDeviceN:
            return @"kCGColorSpaceModelDeviceN";
        case kCGColorSpaceModelIndexed:
            return @"kCGColorSpaceModelIndexed";
        case kCGColorSpaceModelPattern:
            return @"kCGColorSpaceModelPattern";
        default:
            return @"Not a valid color space";
    }
}

- (BOOL)canProvideRGBComponents {
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
        case kCGColorSpaceModelMonochrome:
            return YES;
        default:
            return NO;
    }
}

- (NSArray *)arrayFromRGBAComponents {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -arrayFromRGBAComponents");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return @[@(r),
             @(g),
             @(b),
             @(a)];
}

- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha {
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r,g,b,a;
    
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelMonochrome:
            r = g = b = components[0];
            a = components[1];
            break;
        case kCGColorSpaceModelRGB:
            r = components[0];
            g = components[1];
            b = components[2];
            a = components[3];
            break;
        default:	// We don't know how to handle this model
            return NO;
    }
    
    if (red) *red = r;
    if (green) *green = g;
    if (blue) *blue = b;
    if (alpha) *alpha = a;
    
    return YES;
}

- (BOOL)hue:(CGFloat *)hue saturation:(CGFloat *)saturation brightness:(CGFloat *)brightness alpha:(CGFloat *)alpha {
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return NO;
    
    [UIColor red:r green:g blue:b toHue:hue saturation:saturation brightness:brightness];
    
    if (alpha) *alpha = a;
    
    return YES;
}

- (CGFloat)red {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -red");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)green {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -green");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[1];
}

- (CGFloat)blue {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -blue");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if (self.colorSpaceModel == kCGColorSpaceModelMonochrome) return c[0];
    return c[2];
}

- (CGFloat)white {
    NSAssert(self.colorSpaceModel == kCGColorSpaceModelMonochrome, @"Must be a Monochrome color to use -white");
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return c[0];
}

- (CGFloat)hue {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -hue");
    CGFloat h = 0.0f;
    [self hue:&h saturation:nil brightness:nil alpha:nil];
    return h;
}

- (CGFloat)saturation {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -saturation");
    CGFloat s = 0.0f;
    [self hue:nil saturation:&s brightness:nil alpha:nil];
    return s;
}

- (CGFloat)brightness {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -brightness");
    CGFloat v = 0.0f;
    [self hue:nil saturation:nil brightness:&v alpha:nil];
    return v;
}

- (CGFloat)alpha {
    return CGColorGetAlpha(self.CGColor);
}

- (CGFloat)luminance {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use luminance");
    
    CGFloat r,g,b;
    if (![self red:&r green:&g blue:&b alpha:nil]) return 0.0f;
    
    // http://en.wikipedia.org/wiki/Luma_(video)
    // Y = 0.2126 R + 0.7152 G + 0.0722 B
    
    return r*0.2126f + g*0.7152f + b*0.0722f;
}

- (UInt32)rgbHex {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use rgbHex");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return 0;
    
    r = MIN(MAX(r, 0.0f), 1.0f);
    g = MIN(MAX(g, 0.0f), 1.0f);
    b = MIN(MAX(b, 0.0f), 1.0f);
    
    return (((int)roundf(r * 255)) << 16)
    | (((int)roundf(g * 255)) << 8)
    | (((int)roundf(b * 255)));
}

#pragma mark Arithmetic operations

- (UIColor *)colorByLuminanceMapping {
    return [UIColor colorWithWhite:self.luminance alpha:1.0f];
}

- (UIColor *)colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [UIColor colorWithRed:MAX(0.0, MIN(1.0, r * red))
                           green:MAX(0.0, MIN(1.0, g * green))
                            blue:MAX(0.0, MIN(1.0, b * blue))
                           alpha:MAX(0.0, MIN(1.0, a * alpha))];
}

- (UIColor *)colorByAddingRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [UIColor colorWithRed:MAX(0.0, MIN(1.0, r + red))
                           green:MAX(0.0, MIN(1.0, g + green))
                            blue:MAX(0.0, MIN(1.0, b + blue))
                           alpha:MAX(0.0, MIN(1.0, a + alpha))];
}

- (UIColor *)colorByLighteningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [UIColor colorWithRed:MAX(r, red)
                           green:MAX(g, green)
                            blue:MAX(b, blue)
                           alpha:MAX(a, alpha)];
}

- (UIColor *)colorByDarkeningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [UIColor colorWithRed:MIN(r, red)
                           green:MIN(g, green)
                            blue:MIN(b, blue)
                           alpha:MIN(a, alpha)];
}

- (UIColor *)colorByMultiplyingBy:(CGFloat)f {
    return [self colorByMultiplyingByRed:f green:f blue:f alpha:1.0f];
}

- (UIColor *)colorByAdding:(CGFloat)f {
    return [self colorByMultiplyingByRed:f green:f blue:f alpha:0.0f];
}

- (UIColor *)colorByLighteningTo:(CGFloat)f {
    return [self colorByLighteningToRed:f green:f blue:f alpha:0.0f];
}

- (UIColor *)colorByDarkeningTo:(CGFloat)f {
    return [self colorByDarkeningToRed:f green:f blue:f alpha:1.0f];
}

- (UIColor *)colorByMultiplyingByColor:(UIColor *)color {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self colorByMultiplyingByRed:r green:g blue:b alpha:1.0f];
}

- (UIColor *)colorByAddingColor:(UIColor *)color {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self colorByAddingRed:r green:g blue:b alpha:0.0f];
}

- (UIColor *)colorByLighteningToColor:(UIColor *)color {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self colorByLighteningToRed:r green:g blue:b alpha:0.0f];
}

- (UIColor *)colorByDarkeningToColor:(UIColor *)color {
    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use arithmetic operations");
    
    CGFloat r,g,b,a;
    if (![self red:&r green:&g blue:&b alpha:&a]) return nil;
    
    return [self colorByDarkeningToRed:r green:g blue:b alpha:1.0f];
}

#pragma mark Complementary Colors, etc

// Pick a color that is likely to contrast well with this color
- (UIColor *)contrastingColor {
    return (self.luminance > 0.5f) ? [UIColor blackColor] : [UIColor whiteColor];
}

// Pick the color that is 180 degrees away in hue
- (UIColor *)complementaryColor {
    
    // Convert to HSB
    CGFloat h,s,v,a;
    if (![self hue:&h saturation:&s brightness:&v alpha:&a]) return nil;
    
    // Pick color 180 degrees away
    h += 180.0f;
    if (h > 360.f) h -= 360.0f;
    
    // Create a color in RGB
    return [UIColor colorWithHue:h saturation:s brightness:v alpha:a];
}

// Pick two colors more colors such that all three are equidistant on the color wheel
// (120 degrees and 240 degress difference in hue from self)
- (NSArray*)triadicColors {
    return [self analogousColorsWithStepAngle:120.0f pairCount:1];
}

// Pick n pairs of colors, stepping in increasing steps away from this color around the wheel
- (NSArray*)analogousColorsWithStepAngle:(CGFloat)stepAngle pairCount:(int)pairs {
    // Convert to HSB
    CGFloat h,s,v,a;
    if (![self hue:&h saturation:&s brightness:&v alpha:&a]) return nil;
    
    NSMutableArray* colors = [NSMutableArray arrayWithCapacity:pairs * 2];
    
    if (stepAngle < 0.0f)
        stepAngle *= -1.0f;
    
    for (int i = 1; i <= pairs; ++i) {
        CGFloat a = fmodf(stepAngle * i, 360.0f);
        
        CGFloat h1 = fmodf(h + a, 360.0f);
        CGFloat h2 = fmodf(h + 360.0f - a, 360.0f);
        
        [colors addObject:[UIColor colorWithHue:h1 saturation:s brightness:v alpha:a]];
        [colors addObject:[UIColor colorWithHue:h2 saturation:s brightness:v alpha:a]];
    }
    
    return [colors copy];
}

#pragma mark String utilities

- (NSString *)stringFromColor {
    NSAssert(self.canProvideRGBComponents, @"Must be an RGB color to use -stringFromColor");
    NSString *result;
    switch (self.colorSpaceModel) {
        case kCGColorSpaceModelRGB:
            result = [NSString stringWithFormat:@"{%0.3f, %0.3f, %0.3f, %0.3f}", self.red, self.green, self.blue, self.alpha];
            break;
        case kCGColorSpaceModelMonochrome:
            result = [NSString stringWithFormat:@"{%0.3f, %0.3f}", self.white, self.alpha];
            break;
        default:
            result = nil;
    }
    return result;
}

- (NSString *)hexStringFromColor {
    return [NSString stringWithFormat:@"%0.6u", (unsigned int)self.rgbHex];
}

//- (NSString *)closestColorNameFor: (const char *) aColorDatabase {
//    NSAssert(self.canProvideRGBComponents, @"Must be a RGB color to use closestColorName");
//    
//    int targetHex = self.rgbHex;
//    int rInt = (targetHex >> 16) & 0x0ff;
//    int gInt = (targetHex >> 8) & 0x0ff;
//    int bInt = (targetHex >> 0) & 0x0ff;
//    
//    float bestScore = MAXFLOAT;
//    const char* bestPos = nil;
//    
//    // Walk the name db string looking for the name with closest match
//    for (const char* p = aColorDatabase; (p = strchr(p, '#')); ++p) {
//        int r,g,b;
//        if (sscanf(p+1, "%2x%2x%2x", &r, &g, &b) == 3) {
//            // Calculate difference between this color and the target color
//            int rDiff = abs(rInt - r);
//            int gDiff = abs(gInt - g);
//            int bDiff = abs(bInt - b);
//            float score = logf(rDiff+1) + logf(gDiff+1) + logf(bDiff+1);
//            
//            // Track the best score/name seen
//            if (score < bestScore) {
//                bestScore = score;
//                bestPos = p;
//            }
//        }
//    }
//    
//    // bestPos now points to the # following the best name seen
//    // Backup to the start of the name and return it
//    const char* name;
//    for (name = bestPos-1; *name != ','; --name)
//        ;
//    ++name;
//    NSString *result = [[NSString alloc] initWithBytes:name length:bestPos - name encoding:NSUTF8StringEncoding];
//    
//    return result;
//}


//- (NSString *)closestColorName {
//    return [self closestColorNameFor:colorNameDB];
//}
//
//- (NSString *)closestCrayonName {
//    return [self closestColorNameFor:crayolaNameDB];
//}

+ (UIColor *)colorWithString:(NSString *)stringToConvert {
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    if (![scanner scanString:@"{" intoString:NULL]) return nil;
    const NSUInteger kMaxComponents = 4;
    float c[kMaxComponents];
    NSUInteger i = 0;
    if (![scanner scanFloat:&c[i++]]) return nil;
    while (1) {
        if ([scanner scanString:@"}" intoString:NULL]) break;
        if (i >= kMaxComponents) return nil;
        if ([scanner scanString:@"," intoString:NULL]) {
            if (![scanner scanFloat:&c[i++]]) return nil;
        } else {
            // either we're at the end of there's an unexpected character here
            // both cases are error conditions
            return nil;
        }
    }
    if (![scanner isAtEnd]) return nil;
    UIColor *color;
    switch (i) {
        case 2: // monochrome
            color = [UIColor colorWithWhite:c[0] alpha:c[1]];
            break;
        case 4: // RGB
            color = [UIColor colorWithRed:c[0] green:c[1] blue:c[2] alpha:c[3]];
            break;
        default:
            color = nil;
    }
    return color;
}

#pragma mark Class methods

//+ (UIColor *)randomColor {
//    return [UIColor colorWithRed:random() / (CGFloat)RAND_MAX
//                           green:random() / (CGFloat)RAND_MAX
//                            blue:random() / (CGFloat)RAND_MAX
//                           alpha:1.0f];
//}

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    return [UIColor colorWithRGBHex:hex alpha:1.0];
}
+ (UIColor *)colorWithRGBHex:(UInt32)hex  alpha:(float)alpha{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;

    float al = (alpha >=0 && alpha <= 1.0f) ? alpha : 1.0f;

    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:al];
}
// Returns a UIColor by scanning the string for a hex number and passing that to +[UIColor colorWithRGBHex:]
// Skips any leading whitespace and ignores any trailing characters
+ (UIColor *)colorWithHEXString:(NSString *)stringToConvert{
    return [UIColor colorWithHEXString:stringToConvert alpha:1.0];
}

+ (UIColor *)colorWithHEXString:(NSString *)stringToConvert  alpha:(float)alpha{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // 字符串应该是6个或者8个字节
    if ([cString length] < 6) return nil;
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    
    stringToConvert = cString;
    NSScanner *scanner = [NSScanner scannerWithString:stringToConvert];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return [UIColor clearColor];
    
    if ([cString length] == 8){
        alpha = (float)(unsigned char)(hexNum >> 24) / 0xff;
    }
    float al = (alpha >=0 && alpha <= 1.0f) ? alpha : 1.0f;
    return [UIColor colorWithRGBHex:hexNum alpha:al];
}

// Lookup a color using css 3/svg color name
+ (UIColor *)colorWithName:(NSString *)cssColorName {
    return [UIColor namedColors][cssColorName];
}

// Lookup a color using a crayola name
+ (UIColor *)crayonWithName:(NSString *)crayolaColorName {
    return [UIColor namedCrayons][crayolaColorName];
}

// Return complete mapping of css3/svg color names --> colors
+ (NSDictionary *)namedColors {
    [colorNameCacheLock lock];
    if (colorNameCache == nil) [UIColor populateColorNameCache];
    [colorNameCacheLock unlock];
    return colorNameCache;
}

+ (NSDictionary *)namedCrayons {
    [crayolaNameCacheLock lock];
    if (crayolaNameCache == nil) [UIColor populateCrayolaNameCache];
    [crayolaNameCacheLock unlock];
    return crayolaNameCache;
}
//
//+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
//	// Convert hsb to rgb
//	CGFloat r,g,b;
//	[self hue:hue saturation:saturation brightness:brightness toRed:&r green:&g blue:&b];
//
//	// Create a color with rgb
//	return [self colorWithRed:r green:g blue:b alpha:alpha];
//}


#pragma mark Color Space Conversions

+ (void)hue:(CGFloat)h saturation:(CGFloat)s brightness:(CGFloat)v toRed:(CGFloat *)pR green:(CGFloat *)pG blue:(CGFloat *)pB {
    CGFloat r = 0, g = 0, b = 0;
    
    // From Foley and Van Dam
    
    if (s == 0.0f) {
        // Achromatic color: there is no hue
        r = g = b = v;
    }
    else {
        // Chromatic color: there is a hue
        if (h == 360.0f) h = 0.0f;
        h /= 60.0f;										// h is now in [0, 6)
        
        int i = floorf(h);								// largest integer <= h
        CGFloat f = h - i;								// fractional part of h
        CGFloat p = v * (1 - s);
        CGFloat q = v * (1 - (s * f));
        CGFloat t = v * (1 - (s * (1 - f)));
        
        switch (i) {
            case 0:	r = v; g = t; b = p;	break;
            case 1:	r = q; g = v; b = p;	break;
            case 2:	r = p; g = v; b = t;	break;
            case 3:	r = p; g = q; b = v;	break;
            case 4:	r = t; g = p; b = v;	break;
            case 5:	r = v; g = p; b = q;	break;
        }
    }	
    if (pR) *pR = r;
    if (pG) *pG = g;
    if (pB) *pB = b;
}


+ (void)red:(CGFloat)r green:(CGFloat)g blue:(CGFloat)b toHue:(CGFloat *)pH saturation:(CGFloat *)pS brightness:(CGFloat *)pV {
    CGFloat h,s,v;
    
    // From Foley and Van Dam
    
    CGFloat max = MAX(r, MAX(g, b));
    CGFloat min = MIN(r, MIN(g, b));
    
    // Brightness
    v = max;
    
    // Saturation
    s = (max != 0.0f) ? ((max - min) / max) : 0.0f;
    
    if (s == 0.0f) {
        // No saturation, so undefined hue
        h = 0.0f;
    } else {
        // Determine hue
        CGFloat rc = (max - r) / (max - min);		// Distance of color from red
        CGFloat gc = (max - g) / (max - min);		// Distance of color from green
        CGFloat bc = (max - b) / (max - min);		// Distance of color from blue
        
        if (r == max) h = bc - gc;					// resulting color between yellow and magenta
        else if (g == max) h = 2 + rc - bc;			// resulting color between cyan and yellow
        else /* if (b == max) */ h = 4 + gc - rc;	// resulting color between magenta and cyan
        
        h *= 60.0f;									// Convert to degrees
        if (h < 0.0f) h += 360.0f;					// Make non-negative
    }
    
    if (pH) *pH = h;
    if (pS) *pS = s;
    if (pV) *pV = v;
}


#pragma mark UIColor_Expanded initialization

+ (void)load {
    colorNameCacheLock = [[NSLock alloc] init];
    crayolaNameCacheLock = [[NSLock alloc] init];
}

- (BOOL)isEqualToColor:(UIColor *)otherColor {
    CGColorSpaceRef colorSpaceRGB = CGColorSpaceCreateDeviceRGB();
    
    UIColor *(^convertColorToRGBSpace)(UIColor*) = ^(UIColor *color) {
        if(CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) == kCGColorSpaceModelMonochrome) {
            const CGFloat *oldComponents = CGColorGetComponents(color.CGColor);
            CGFloat components[4] = {oldComponents[0], oldComponents[0], oldComponents[0], oldComponents[1]};
            CGColorRef colorRef = CGColorCreate( colorSpaceRGB, components );
            
            UIColor *color = [UIColor colorWithCGColor:colorRef];
            CGColorRelease(colorRef);
            return color;
        } else
            return color;
    };
    
    UIColor *selfColor = convertColorToRGBSpace(self);
    otherColor = convertColorToRGBSpace(otherColor);
    CGColorSpaceRelease(colorSpaceRGB);
    
    return [selfColor isEqual:otherColor];
}


+ (UIColor *)backgroundColor
{
    return [UIColor color5];
}

+ (UIColor *)grayTextColor
{
    return [UIColor color9];
}

+ (UIColor *)borderColor
{
    return [UIColor color6];
}

+ (UIColor *)nickNameColor
{
    return [UIColor color12];
}

+ (UIColor *)textColor
{
    return [UIColor color11];
}

+ (UIColor *)listTitleColor
{
    return [UIColor color9];
}

+ (UIColor *)barTitleColor
{
    return [UIColor color10];
}

+ (UIColor *)searchTextColor
{
    return [UIColor color8];
}

+ (UIColor *)searchBackgroudColor
{
    return [UIColor color5];
}

+ (UIColor *)alerTextColor
{
    return [UIColor color7];
}

+ (UIColor *)highlightColor
{
    return [UIColor color1];
}

+ (UIColor *)toonRedColor
{
    return [UIColor color13];
}

+ (UIColor *)toonWhileColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)callPhoneGreenColor
{
    return [UIColor color17];
}

+ (UIColor *)toonYellow
{
    return [UIColor color16];
}

+ (UIColor *)separatorColor
{
    return [UIColor colorWithRGBHex:0xE1E1E1];
}

+ (UIColor *)subtitleColor
{
    return [UIColor color9];
}

+ (UIColor *)color1
{
    return [UIColor colorWithRGBHex:0x007AFF];//0,122,255
}
//color1和color2合并
+ (UIColor *)color2
{
    return [UIColor colorWithRGBHex:0x007AFF];//0,122,255
}

+ (UIColor *)color3
{
    return [UIColor colorWithRGBHex:0x3395FF];
}

+ (UIColor *)color4
{
    return [UIColor colorWithRGBHex:0xF9F9F9];//249,249,249
}

+ (UIColor *)color5 {
    return [UIColor colorWithRGBHex:0xF2F2F4];//242,242,242
}

+ (UIColor *)color6 {
    return [UIColor colorWithRGBHex:0xDDDEE3];//221,222,227
}

+ (UIColor *)color7 {
    return [UIColor colorWithRGBHex:0xACB3BF];//172,179,191
}

+ (UIColor *)color8 {
    return [UIColor colorWithRGBHex:0x8E8E93];//142,142,147
}

+ (UIColor *)color9 {
    return [UIColor colorWithRGBHex:0x777E8C];//119,126,140
}

+ (UIColor *)color10 {
    return [UIColor colorWithRGBHex:0x5C5C5C];//92,92,92
}

+ (UIColor *)color11 {
    return [UIColor colorWithRGBHex:0x333333];//51,51,51
}

+ (UIColor *)color12 {
    return [UIColor colorWithRGBHex:0x383838];//
}

+ (UIColor *)color13 {
    return [UIColor colorWithRGBHex:0xFF5A5F];//255,90,95
}

+ (UIColor *)color14 {
    return [UIColor colorWithRGBHex:0xFF3B2F];//255,59,47
}

+ (UIColor *)color15 {
    return [UIColor colorWithRGBHex:0xFEA715];//254,167,21
}

+ (UIColor *)color16 {
    return [UIColor colorWithRGBHex:0xFF804A];//18,71,100
}

+ (UIColor *)color17 {
    return [UIColor colorWithRGBHex:0x4ECCC1];//78,204,193
}

+ (UIColor *)color18 {
    return [UIColor colorWithRGBHex:0x4D5D7D];//77,93,125
}

+ (UIColor *)color19 {
    return [UIColor colorWithRGBHex:0xB2B2B2];//178,178,178
}

+ (UIColor *)color20 {
    return [UIColor colorWithRGBHex:0xFFFFFF];//255,255,255
}
+ (UIColor *)color21 {
    return [UIColor colorWithRGBHex:0x63498C];//99,73,140
}
+ (UIColor *)color22 {
    return [UIColor colorWithRGBHex:0x008CC8];//0,140,200
}
+ (UIColor *)color23 {
    return [UIColor colorWithRGBHex:0x328DDE]; //208,77,87
}
+ (UIColor *)color24 {
    return [UIColor colorWithRGBHex:0x29B3A7]; //175,77,70
}
+ (UIColor *)color25 {
    return [UIColor colorWithRGBHex:0x009688]; //0,150,136
}
+ (UIColor *)color26 {
    return [UIColor colorWithRGBHex:0x202020]; //32,32,32
}

+ (UIColor *)color27 {
    return [UIColor colorWithRGBHex:0x95989F]; //222,6,62
}

+ (UIColor *)color28 {
    return [UIColor colorWithRGBHex:0x4A4A4A]; // 74,74,74
}
+ (UIColor *)color29 {
    
    return [UIColor colorWithRGBHex:0xE05449]; // 224,84,73
}
+ (UIColor *)color30 {
    
    return [UIColor colorWithRGBHex:0x424F66]; // 66,79,102
}
+ (UIColor *)color31 {
    return [UIColor colorWithRGBHex:0x328DDE]; // 208,77,87
}
+ (UIColor *)color32 {
    return [UIColor colorWithRGBHex:0xFF88B2]; // 255,136,178
}
+ (UIColor *)color33 {
    return [UIColor colorWithRGBHex:0x66AFFF]; // 211，60，100
}
+ (UIColor *)color34 {
    return [UIColor colorWithRGBHex:0x3D9DEB];
}
+ (UIColor *)color35 {
    return [UIColor colorWithRGBHex:0x358EE9];
}
+ (UIColor *)color36 {
    return [UIColor colorWithRGBHex:0xE1E1E1];
}
+ (UIColor *)color37 {
    return [UIColor colorWithRGBHex:0x9C9C9C];
}
+ (UIColor *)color38 {
    return [UIColor colorWithRGBHex:0x7d7d7d];
}
+(UIColor *)color39
{
    return [UIColor colorWithRGBHex:0x222222];
}

/**新feed优化 title 颜色  #383838*/
+ (UIColor *)color100;
{
    return [UIColor colorWithRGBHex:0x383838];
}
/**新feed优化 subtitle 颜色 #9C9C9C*/
+ (UIColor *)color101;
{
    return [UIColor colorWithRGBHex:0x9C9C9C];
}
+ (UIColor *)colorCellTitleColor{     //灰色
    return [UIColor colorWithRGBHex:0x95989f];
}

+ (UIColor *)titleColor{
    return [UIColor colorWithRGBHex:0x95989f];
}
+ (UIColor *)colorGroupTagName{
    return [UIColor colorWithRGBHex:0x4a4a4a];
}

+ (UIColor *)colorBlack_alpha:(CGFloat)alpha{
    return [UIColor color:[UIColor blackColor] alpha:alpha];
}
+ (UIColor *)color3_alpha:(CGFloat)alpha
{
    return [UIColor color:[UIColor color3] alpha:alpha];
}

+ (UIColor *)color:(UIColor *)color alpha:(CGFloat)alpha
{
    CGColorRef ref =CGColorCreateCopyWithAlpha(color.CGColor, alpha);
    
    UIColor*res =[UIColor colorWithCGColor: ref];
    CGColorRelease(ref);
    return res;
}
+ (UIColor *)pinkColor{
    return [UIColor colorWithRGBHex:0xfff7f0];
}
+ (UIColor *)redPacketsColor
{
    return [UIColor colorWithRGBHex:0xE05449];
}

+ (UIColor *)orangeTagColor
{
    return [UIColor colorWithRGBHex:0xFF6F48];
}

+ (UIColor *)toonBtnUnableColor {
    return [UIColor colorWithRed:223/255.f green:48.f/255.f blue:49.f/255.f alpha:0.6];
}


#pragma mark - colorTemail1 ~ colorTemail13 为 Temail约定色板颜色 如自定义 请从 colorTemail100 开始自定义添加
+ (UIColor *)colorTemail1{
    return [UIColor colorWithRGBHex:0x007AFF]; //0,122,255
}

+ (UIColor *)colorTemail2{
    return [UIColor colorWithRGBHex:0x222222]; //34,34,34
}

+ (UIColor *)colorTemail3{
    return [UIColor colorWithRGBHex:0x383838]; //56,56,56
}

+ (UIColor *)colorTemail4{
    return [UIColor colorWithRGBHex:0x8E8E93]; //142,142,147
}

+ (UIColor *)colorTemail5{
    return [UIColor colorWithRGBHex:0xA6A6A6]; //166,166,166
}

+ (UIColor *)colorTemail6{
    return [UIColor colorWithRGBHex:0xC5C5C5]; //197,197,197
}

+ (UIColor *)colorTemail7{
    return [UIColor colorWithRGBHex:0xE1E1E1]; //225,225,225
}

+ (UIColor *)colorTemail8{
    return [UIColor colorWithRGBHex:0xF6F6F6]; //246,246,246
}

+ (UIColor *)colorTemail9{
    return [UIColor colorWithRGBHex:0x007AFF alpha:0.5]; //0,122,255 透明度50%
}

+ (UIColor *)colorTemail10{
    return [UIColor colorWithRGBHex:0x007AFF alpha:0.6]; //0,122,255 透明度60%
}

+ (UIColor *)colorTemail11{
    return [UIColor colorWithRGBHex:0x4CD964]; //76,217,100
}

+ (UIColor *)colorTemail12{
    return [UIColor colorWithRGBHex:0xFF3B2F]; //255,59,47
}

+ (UIColor *)colorTemail13 {
    return [UIColor colorWithRGBHex:0xFEA715]; //254,167,21
}

@end
