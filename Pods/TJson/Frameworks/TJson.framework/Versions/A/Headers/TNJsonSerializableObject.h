//
// Created by fengshuai on 14-8-21.
// Copyright (c) 2014 fengshuai. All rights reserved.


#import <Foundation/Foundation.h>


@interface NSObject (TNJsonSerializableObject)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (NSString *)serializeToString;

+ (instancetype)deserializeFromString:(NSString *)string;

- (void)updateWithDict:(NSDictionary *)dict;

- (NSDictionary *)serializeToDictionary;

+ (instancetype)deserializeFromDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)keyMappingTable;

- (void)afterDeserialization;

+ (void)copyPropertiesFrom:(id)src to:(id)target;

@end