//
//  TNCardHiddenNavigationController.h
//  FBSnapshotTestCase
//
//  Created by likuiliang-Answer on 2018/3/26.
//

#import <UIKit/UIKit.h>

@interface TNCardHiddenNavigationController : UIViewController

@end

@interface UIViewController(HiddenNavigationBar)

@property(nonatomic, assign) BOOL hiddenNavigationBar; //default value is YES

@end
