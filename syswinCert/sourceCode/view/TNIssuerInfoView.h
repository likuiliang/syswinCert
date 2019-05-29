//
//  TNIssuerInfoView.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/29.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TNIssuerObject.h"
#import "TNReceiverObject.h"

@protocol TNIssuerInfoViewDelegate <NSObject>

- (void)issuerInfoCellOnClick:(TNReceiverObject *)receiverObject;

@end

@interface TNIssuerInfoView : UIView

@property (nonatomic, weak) id<TNIssuerInfoViewDelegate> delegate;
@property (nonatomic, strong) TNIssuerObject *issuerObject;

- (void)updateTableViewWithDataSource:(NSArray *)dataSource;

@end

