//
//  TNVerifyInfoModel.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/30.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TNVerifyType) {
    TNVerifyBeingType = 1 , // 验证中
    TNVerifySuccessType = 2 ,  // 验证成功
    TNVerifyFailType = 3 ,  // 验证失败
};

@interface TNVerifyInfoModel : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *failImageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *nomailTitleColor;
@property (nonatomic, copy) NSString *failTitleColor;
@property (nonatomic, assign) TNVerifyType verifyType;
@property (nonatomic, assign) BOOL isHeaderTItleView;

+ (NSArray *)initDataSourceModel;


@end

