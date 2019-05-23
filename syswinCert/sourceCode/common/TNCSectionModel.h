//
//  TNCSectionModel.h
//  AFNetworking
//
//  Created by likuiliang-Answer on 2018/7/11.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol TNCHeaderFooterRefreshProtocol <NSObject>

- (void)reloadHeaderFooterWithModel:(id)model;

@end

@interface TNCSectionModel : NSObject

@property (nonatomic, assign) BOOL haveRelead;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *footerTitle;
@property (nonatomic, copy) NSString *sFeedId;
@property (nonatomic, copy) NSString *vFeedId;
@property (nonatomic, assign) CGFloat sectionHeight;
@property (nonatomic, assign) CGFloat titleFontSize;

/**
 *  组尾的高度
 */
@property (nonatomic, assign) CGFloat sectionFooterHeight;

@property (nonatomic, strong) NSMutableArray *rowDataArray;

@property (nonatomic, copy) NSString *accessoryString;
@property (nonatomic, copy) void(^rightAccessoryBlock)(void) ;
@property (nonatomic, strong) Class <TNCHeaderFooterRefreshProtocol>headerClass;
@property (nonatomic, strong) Class <TNCHeaderFooterRefreshProtocol>footerClass;

@end
