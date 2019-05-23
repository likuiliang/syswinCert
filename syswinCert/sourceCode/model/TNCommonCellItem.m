//
//  TNCommonCellItem.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/23.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNCommonCellItem.h"
#import "TNCommonCell.h"

@implementation TNCommonCellItem

- (Class)classOfSelf {
    return [TNCommonCell class];
}

- (CGFloat)cellHeight {
    return 50.0;
}

- (CGFloat)getCellHeightOfSelf {
    
    return self.cellHeight;
}

@end

@implementation TNTextFieldCellItem 

@end
