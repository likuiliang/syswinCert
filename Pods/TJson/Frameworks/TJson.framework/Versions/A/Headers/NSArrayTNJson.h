//
// Created by Lijing on 2018/4/5.
//

#import <Foundation/Foundation.h>


@interface NSArray(TNJson)


/*
 * 模型数组转字典数组
 * */
- (NSArray *)tn_arrayFromObjects;

/*
 * 字典数组转模型数组
 * */
- (NSArray *)tn_objectsFromArrayWithClz:(Class)clz;


@end