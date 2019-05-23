//
//  TNDBBaseObject.h
//  Pods
//
//  Created by l-h-d on 4/5/17.
//

#import <Foundation/Foundation.h>

@interface TNDBBaseObject : NSObject

/*
 *Multiple keys can be combined to act as primary keys, and keys are separated by commas
 *
 *Use like this: @"key" or @"key1,key2,key3,..."
 *
 */
+ (NSString *)primaryKey;

/*
 *Must ensure the value type is correct if setting, especically the mutable property.
 *
 */
+ (NSDictionary *)defaultPropertyValues;

/*
 * optional
 */
+ (NSArray *)tableFields;

/*
 *Multiple Index can be combined to act as table index, and keys are separated by commas
 *
 *Use like this: @"key" or @"key1,key2,key3,..." and the index will description as tableName_key or tableName_key1, tableName_key2, tableName_key3...(add the tableName is used to prevent index conflicts)
 *
 */
+ (NSString *)tableIndex;

/*
 *Multiple Index can be combined to act as table index, and keys are separated by commas
 *
 *Use like this: @"key" or @"key1,key2,key3,..." and the index will description as key1_key2_key3_
 *
 */
+ (NSString *)tableJointIndex;

/*
 * only used for fts
 */
+ (NSString *)virtualIndexed;

@end
