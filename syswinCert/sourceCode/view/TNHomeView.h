//
//  TNHomeView.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/27.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TNIssuerObject;

@protocol TNHomeViewDelegate <NSObject>

- (void)homeViewImportIcoundOnClick;

- (void)homeViewCellDidSelectWithModel:(TNIssuerObject *)issuerObject;

@end

@interface TNHomeView : UIView

@property (nonatomic, weak) id<TNHomeViewDelegate> delegate;

- (void)updateTableViewWithDataSource:(NSArray *)dataSource;

- (void)updateHomeConstraints;

@end


