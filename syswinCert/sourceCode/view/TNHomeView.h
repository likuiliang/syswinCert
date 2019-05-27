//
//  TNHomeView.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/27.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TNHomeViewDelegate <NSObject>

- (void)homeViewImportIcoundOnClick;

@end

@interface TNHomeView : UIView

@property (nonatomic, weak) id<TNHomeViewDelegate> delegate;

@end


