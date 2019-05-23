//
//  TNDBBaseManager+version.h
//  TNNewFriend
//
//  Created by guorenqing on 2017/5/18.
//  Copyright © 2017年 138724. All rights reserved.
//  使用该分类存储版本号需要创建TNDBVersion模型对应的数据库表

#import "TNDBBaseManager.h"

@interface TNDBBaseManager (version)
// 插入一个版本
- (void)insertOrReplaceVersionWithName:(NSString *)name
                            andVersion:(NSString *)version;

// 查询版本
- (NSString *)queryVersionWithName:(NSString *)name;
@end
