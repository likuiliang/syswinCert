//
//  TNHomeViewController.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/23.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNHomeViewController.h"
#import "TNDocument.h"
#import "TNApplyCertController.h"
#import "TSBManager.h"

@interface TNHomeViewController () <UIDocumentPickerDelegate>

@end

@implementation TNHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [TSBManager loginWithPwd:@"111111" withError:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Syswin Cert";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"申请证书" style:UIBarButtonItemStylePlain target:self action:@selector(applyCerOnClick)];
}




- (void)applyCerOnClick
{
    TNApplyCertController *applyCertVC = [TNApplyCertController new];
    [self.navigationController pushViewController:applyCertVC animated:YES];
}

- (void)presentDocumentCloud {
    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt",@"public.json"];
    //    UIDocumentBrowserViewController
    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeOpen];
    documentPickerViewController.delegate = self;
    documentPickerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:documentPickerViewController animated:YES completion:nil];
}



#pragma mark - UIDocumentPickerDelegate
//    当需要访问不在 App 自身的沙盒或者自身共享容器里的资源时，需要申请权限访问，使用到 NSURL 的两个方法:
//    开始安全访问：- (BOOL)startAccessingSecurityScopedResource
//    停止安全访问：- (void)stopAccessingSecurityScopedResource
- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    BOOL fileUrlAuthozied = [url startAccessingSecurityScopedResource];
    if(fileUrlAuthozied){
        TNDocument *document = [[TNDocument alloc] initWithFileURL:url];
        [document openWithCompletionHandler:^(BOOL success) {
            NSData *ddd = document.data;
            NSLog(@"dddddd----%@",ddd);
        }];
//        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
//        NSError *error;
//        __block NSData *fileData;
        
//        [fileCoordinator coordinateReadingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
//
//            fileData = [NSData dataWithContentsOfURL:newURL];
//            NSString *fileName = [newURL lastPathComponent];
////            NSString *localFilePath = [KLocalSourceFilePath stringByAppendingPathComponent:fileName];
//            //写到本地
////            [[TSZFileOperateManager sharedInstance] writeSourceFileData:fileData toFilePath:localFilePath];
//            //处理后续流程
////            [TSZBusinessLogicManager pk_createDBEsrModelWithLocalSourceFilePath:localFilePath];
//        }];
//
//        [url stopAccessingSecurityScopedResource];
        
        [self dismissViewControllerAnimated:YES completion:nil];
//        [[NSNotificationCenter defaultCenter]postNotificationName:KSwitchToFileListNotificationKey object:nil];
    }else{
        //Error handling
    }
}

@end
