//
//  JsonSerializationKit.h
//  JsonSerializationKit
//
//  Created by fengshuai on 14-8-7.
//  Copyright (c) 2014年 fengshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef TNGeneric

#define TNGeneric(objType) @protocol objType @end \
   @interface NSObject(objType)<objType> @end

TNGeneric(Ignore)
TNGeneric(Optional)


#endif

#import <TJson/NSArrayTNJson.h>
#import <TJson/NSDictionaryTNJson.h>
#import <TJson/NSStringTNJson.h>
#import <TJson/TNJsonSerializableObject.h>





