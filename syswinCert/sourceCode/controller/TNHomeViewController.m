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
#import "TNHomeView.h"
#import "TOONWYGlobalDefinition.h"
#import "TNSqlManager.h"
#import "TNCertManager.h"

@interface TNHomeViewController () <UIDocumentPickerDelegate,TNHomeViewDelegate>

@property (nonatomic, strong) TNHomeView *homeView;

@end

@implementation TNHomeViewController

- (id)init {
    if (self = [super init]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [TSBManager loginWithPwd:@"111111" withError:nil];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发证机构";
    [self.view addSubview:self.homeView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"申请证书" style:UIBarButtonItemStylePlain target:self action:@selector(applyCerOnClick)];
    
//    TNIssuerObject *issuer = [TNIssuerObject new];
//    issuer.issuerPk = @"1111111";
//    issuer.name = @"test";
//    issuer.avatar = @"sdfll";
//    [[TNSqlManager instance] updateIssuerModel:issuer];
//
    NSArray *array = [[TNSqlManager instance] queryIssuerWithName:nil];
    [self.homeView updateTableViewWithDataSource:array];
    
}

- (void)applyCerOnClick
{
    TNApplyCertController *applyCertVC = [TNApplyCertController new];
    [self.navigationController pushViewController:applyCertVC animated:YES];
}

#pragma mark - TNHomeViewDelegate

- (void)homeViewImportIcoundOnClick
{
    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt",@"public.json",@"public.hpc"];
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
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        __block NSData *fileData;
        [fileCoordinator coordinateReadingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
            fileData = [NSData dataWithContentsOfURL:newURL];
            NSString *fileName = [newURL lastPathComponent];
            NSString *localFilePath = [KLocalSourceFilePath stringByAppendingPathComponent:fileName];
            //写到本地
            [self writeSourceFileData:fileData toFilePath:localFilePath];
        }];
        
        [url stopAccessingSecurityScopedResource];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        //Error handling
    }
}

- (void)writeSourceFileData:(NSData *)sourceData toFilePath:(NSString *)filePath{
    if (![[NSFileManager defaultManager] fileExistsAtPath:KLocalSourceFilePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:KLocalSourceFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [sourceData writeToFile:filePath atomically:YES];
    // 写入本地后，把相关内容存入数据库
    
    [[TNCertManager instance] saveCertificateWithFilePath:filePath];;
}


#pragma mark - 懒加载

- (TNHomeView *)homeView
{
    if (!_homeView) {
        _homeView = [[TNHomeView alloc] initWithFrame:self.view.bounds];
        _homeView.delegate = self;
    }
    return _homeView;
}

@end

