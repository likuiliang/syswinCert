//
//  TNCSectionModel.m
//  AFNetworking
//
//  Created by likuiliang-Answer on 2018/7/11.
//

#import "TNCSectionModel.h"

@implementation TNCSectionModel

- (Class<TNCHeaderFooterRefreshProtocol>)headerClass {
    if (!_headerClass) {
        _headerClass = [UITableViewHeaderFooterView class];
    }
    return _headerClass;
}

- (Class<TNCHeaderFooterRefreshProtocol>)footerClass {
    if (!_footerClass) {
        _footerClass = [UITableViewHeaderFooterView class];
    }
    return _footerClass;
}
@end
