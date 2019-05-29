//
//  TNCertManager.h
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/27.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TOONWYGlobalDefinition.h"

@interface TNCertManager : NSObject <UIDocumentPickerDelegate>

+ (id)instance;

- (void)saveCertificateWithFilePath:(NSString *)filePath;

- (void)verifyCertSignFilePath:(NSString *)filePath;

@end

