//
//  TNCBaseItem.m
//  AFNetworking
//
//  Created by likuiliang-Answer on 2018/7/11.
//

#import "TNCBaseItem.h"
#import "TNCBaseItemCell.h"

@implementation TNCBaseItem

- (instancetype)init
{
    if (self = [super init])
    {}
    return self;
}

- (Class)classOfSelf {
    return [TNCBaseItemCell class];
}

- (CGFloat)getCellHeightOfSelf {
    return 0.1;
}

- (void)cellSelectedWithParams:(NSDictionary *)params{}

@end
