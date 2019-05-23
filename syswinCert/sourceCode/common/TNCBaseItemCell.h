//
//  TNCBaseItemCell.h
//  AFNetworking
//
//  Created by likuiliang-Answer on 2018/7/11.
//

#import <UIKit/UIKit.h>
#import "TNCBaseItem.h"
#import "UIColor+Extension.h"

typedef void (^ CellbtnOnClick) (id);

@interface TNCBaseItemCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;

@property (nonatomic, strong) TNCBaseItem *model;

@property (nonatomic, strong) UIView *lineView;
/**
 *  子控件按钮点击事件回调
 */
@property (nonatomic, copy) CellbtnOnClick btnOnClick;

- (void)reloadCellWithModel:(TNCBaseItem *)model;

@end
