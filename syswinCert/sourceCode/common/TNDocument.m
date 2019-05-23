//
//  TNDocument.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/23.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNDocument.h"

@implementation TNDocument

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    
    self.data = contents;
    
    return YES;
}

//写文件,保存时会调用
- (nullable id)contentsForType:(NSString *)typeName error:(NSError **)outError{
    NSLog(@"typeName == %@", typeName);
    
    if (self.text.length <= 0) {
        
        self.text = @"";
    }
    NSData *data = [self.text dataUsingEncoding:NSUTF8StringEncoding];
    
    return data;
}

@end
