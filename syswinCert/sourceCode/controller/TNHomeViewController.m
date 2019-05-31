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
#import "TNIssuerInfoController.h"

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
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"申请证书" style:UIBarButtonItemStylePlain target:self action:@selector(applyCerOnClick)];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateHomeView];
}

- (void)updateHomeView
{
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
    NSArray *documentTypes = @[@"public.content", @"public.text", @"public.source-code ", @"public.image", @"public.audiovisual-content", @"com.adobe.pdf", @"com.apple.keynote.key", @"com.microsoft.word.doc", @"com.microsoft.excel.xls", @"com.microsoft.powerpoint.ppt",@"public.json",@"com.microsoft.excel.hpc"];
    //    UIDocumentBrowserViewController
    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:documentTypes inMode:UIDocumentPickerModeOpen];
    documentPickerViewController.delegate = self;
    documentPickerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:documentPickerViewController animated:YES completion:nil];
}

- (void)homeViewCellDidSelectWithModel:(TNIssuerObject *)issuerObject
{
    TNIssuerInfoController *issuerInfo = [TNIssuerInfoController new];
    issuerInfo.issuerObject = issuerObject;
    
    [self.navigationController pushViewController:issuerInfo animated:YES];
}

#pragma mark - UIDocumentPickerDelegate

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    
    BOOL fileUrlAuthozied = [url startAccessingSecurityScopedResource];
    if(fileUrlAuthozied){
        NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
        NSError *error;
        __block NSData *fileData;
        [fileCoordinator coordinateReadingItemAtURL:url options:0 error:&error byAccessor:^(NSURL *newURL) {
            fileData = [NSData dataWithContentsOfURL:newURL];
            NSString *fileName = [newURL lastPathComponent];
            //写到本地
            [self writeSourceFileData:fileData toFilePath:fileName];
        }];
        
        [url stopAccessingSecurityScopedResource];
        [self dismissViewControllerAnimated:YES completion:nil];
        [self updateHomeView];
        
    }else{
        //Error handling
    }
}

- (void)writeSourceFileData:(NSData *)sourceData toFilePath:(NSString *)filePath{
    if (![[NSFileManager defaultManager] fileExistsAtPath:KLocalSourceFilePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:KLocalSourceFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *allFilePath = [KLocalSourceFilePath stringByAppendingPathComponent:filePath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:allFilePath]) {
        [sourceData writeToFile:allFilePath atomically:YES];
        // 写入本地后，把相关内容存入数据库
        [[TNCertManager instance] saveCertificateWithFilePath:filePath];
    } else {
        [MBProgressHUD showMessage:@"该证书文件已存在" inView:nil];
    }
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

