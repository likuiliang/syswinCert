//
//  TNCBaseItem.h
//  AFNetworking
//
//  Created by likuiliang-Answer on 2018/7/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ItemOnClick)(id);

@interface TNCBaseItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, assign) BOOL hidLine;
@property (nonatomic, assign) BOOL clickCell;
@property (nonatomic, strong) id objParam;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, copy) ItemOnClick itemClick;
/**
 *  默认为 0
 */
@property (nonatomic, assign) CGFloat cellHeight;
- (Class)classOfSelf;
/**
 *  获取与这个模型配对的cell的高
 // 说明: 当 获取的高为0 时 这个模型配对的cell的高启用 属性cellHeight 来获取
 */
- (CGFloat)getCellHeightOfSelf;
- (void)cellSelectedWithParams:(NSDictionary *)params;

@end
