//
//  TNNetWorkManager.m
//  syswinCert
//
//  Created by likuiliang-Answer on 2019/5/24.
//  Copyright © 2019年 Answer. All rights reserved.
//

#import "TNNetWorkManager.h"

static AFHTTPSessionManager * manager;

#define BaseUrlStr @""

@implementation TNNetWorkManager

+ (void)getAFCNetManager{
    if(manager==nil){
        manager=[AFHTTPSessionManager manager];
        manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.securityPolicy.allowInvalidCertificates = NO;
        manager.requestSerializer.timeoutInterval = 20;
        manager.securityPolicy.validatesDomainName = YES;
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    }
}


/** GET请求*/

+(void)GET:(NSString *)urlStr Param:(NSDictionary *)param Success:(AFCSuccessBlock)success Falied:(AFCFaliedBlock)falied{
    
//        [self getAFCNetManager];
//
//        NSString * url = [BaseUrlStr stringByAppendingString:urlStr];
//
//        [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
//
//            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//                    NSError *error;
//
//                    NSDictionary * OCJSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers  error:&error];
//
//                    if (error != nil){
//
//                            AFCNetFaliedModel * faliedModel = [AFCNetFaliedModel new];
//
//                            faliedModel.code = 0;
//
//                            faliedModel.message = @"数据解析出错";
//
//                            falied(faliedModel);
//
//                        }else{
//
//                                [self handleRequestSuccessData:OCJSON Success:success Falied:falied];
//
//                            }
//
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//                        [self handleRequestFaliedError:error Falied:falied];
//
//                    }];
    
        
    
}

/** POST请求*/

+(void)POST:(NSString *)urlStr Param:(NSDictionary *)param Success:(AFCSuccessBlock)success Falied:(AFCFaliedBlock)falied{
    
//        [self getAFCNetManager];
//
//        NSString * url = [BaseUrlStr stringByAppendingString:urlStr];
//
//        [manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
//
//            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//                    NSError *error;
//
//                    NSDictionary * OCJSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers  error:&error];
//
//                    if (error != nil){
//
//                            AFCNetFaliedModel * faliedModel = [AFCNetFaliedModel new];
//
//                            faliedModel.code = 0;
//
//                            faliedModel.message = @"数据解析出错";
//
//                            falied(faliedModel);
//
//                        }else{
//
//                                [self handleRequestSuccessData:OCJSON Success:success Falied:falied];
//
//                            }
//
//                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//                         [self handleRequestFaliedError:error Falied:falied];
//
//                    }];
    
}

/** POST上传单张图片*/

+(void)POST:(NSString *) urlStr Param:(NSDictionary *)param image:(UIImage *) image Success:(AFCSuccessBlock)

success Falied:(AFCFaliedBlock) falied{
//
//        [self getAFCNetManager];
//
//         NSString * url = [BaseUrlStr stringByAppendingString:urlStr];
//
//        [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//                // 1、对图片压缩
//
//                NSData * imageData = UIImageJPEGRepresentation(image, 0.5);
//
//                // 2、上传的参数名 以当前时间为参数名  保证所有参数名不一样
//
//                NSDate *currentDate = [NSDate date];//获取当前时间，日期
//
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//
//                [dateFormatter setDateFormat:@"YYYY-MM-dd-HH:mm:ss:SS"];
//
//                NSString * Name = [dateFormatter stringFromDate:currentDate];
//
//                // 3、上传filename
//
//                NSString * fileName = [NSString stringWithFormat:@"%@.png", Name];
//
//                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
//
//            } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//                    //NSLog(@"图片上传进度 == %f ",uploadProgress.fractionCompleted);
//
//                 } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//                         NSError *error;
//
//                         NSDictionary * OCJSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers  error:&error];
//
//                         if (error != nil){
//
//                                 AFCNetFaliedModel * faliedModel = [AFCNetFaliedModel new];
//
//                                 faliedModel.code = 0;
//
//                                 faliedModel.message = @"数据解析出错";
//
//                                 falied(faliedModel);
//
//                             }else{
//
//                                     [self handleRequestSuccessData:OCJSON Success:success Falied:falied];
//
//                                 }
//
//                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//                            [self handleRequestFaliedError:error Falied:falied];
//
//                        }];
    
}

/** POST上传单张图片*/

+(void)POST:(NSString *) urlStr Param:(NSDictionary *)param image:(UIImage *) image scale:(CGFloat)scale Success:(AFCSuccessBlock)

success Falied:(AFCFaliedBlock) falied{
    
//        [self getAFCNetManager];
//    
//        NSString * url = [BaseUrlStr stringByAppendingString:urlStr];
//    
//        [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//                // 1、对图片压缩
//        
//                NSData * imageData = UIImageJPEGRepresentation(image, scale);
//        
//                 NSLog(@"比例：%f,大小：%lu k",scale,(unsigned long)imageData.length/1024);
//        
//                // 2、上传的参数名 以当前时间为参数名  保证所有参数名不一样
//        
//                NSDate *currentDate = [NSDate date];//获取当前时间，日期
//        
//                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//        
//                [dateFormatter setDateFormat:@"YYYY-MM-dd-HH:mm:ss:SS"];
//        
//                NSString * Name = [dateFormatter stringFromDate:currentDate];
//        
//                // 3、上传filename
//        
//                NSString * fileName = [NSString stringWithFormat:@"%@.png", Name];
//        
//                [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
//        
//            } progress:^(NSProgress * _Nonnull uploadProgress) {
//            
//                    //NSLog(@"图片上传进度 == %f ",uploadProgress.fractionCompleted);
//            
//                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                
//                        NSError *error;
//                
//                        NSDictionary * OCJSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers  error:&error];
//                
//                        if (error != nil){
//                    
//                                AFCNetFaliedModel * faliedModel = [AFCNetFaliedModel new];
//                    
//                                faliedModel.code = 0;
//                    
//                                faliedModel.message = @"数据解析出错";
//                    
//                                falied(faliedModel);
//                    
//                            }else{
//                        
//                                    [self handleRequestSuccessData:OCJSON Success:success Falied:falied];
//                        
//                                }
//                
//                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//                    
//                            [self handleRequestFaliedError:error Falied:falied];
//                    
//                        }];
    
}

/** POST提交视频*/

+(void)POST:(NSString *) urlStr Param:(NSDictionary *)param videoData:(NSData *) data UploadProgress:(UploadProgress ) progress Success:(AFCSuccessBlock) success  Falied:(AFCFaliedBlock) falied{
    
//        [self getAFCNetManager];
//
//        NSString * url = [BaseUrlStr stringByAppendingString:urlStr];
//
//        [manager POST:url parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//
//                [formData appendPartWithFileData:data name:@"file" fileName:@"video1.mov" mimeType:@"video/quicktime"];
//
//            } progress:^(NSProgress * _Nonnull uploadProgress) {
//
//                    progress(uploadProgress.completedUnitCount / uploadProgress.totalUnitCount*1.00);
//
//                } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
//
//                        NSError *error;
//
//                        NSDictionary * OCJSON = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers  error:&error];
//
//                        if (error != nil){
//
//                                AFCNetFaliedModel * faliedModel = [AFCNetFaliedModel new];
//
//                                faliedModel.code = 0;
//
//                                faliedModel.message = @"数据解析出错";
//
//                                falied(faliedModel);
//
//                            }else{
//
//                                    [self handleRequestSuccessData:OCJSON Success:success Falied:falied];
//
//                                }
//
//                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//
//                             [self handleRequestFaliedError:error Falied:falied];
//
//                        }];
    
}



#pragma mark - 每个项目返回数据结构不一样，是协商而定

/** 处理请求成功数据*/

+(void)handleRequestSuccessData:(NSDictionary *)ocJson Success:(AFCSuccessBlock)success Falied:(AFCFaliedBlock)falied{
    
        success(ocJson);
    
}

/** 处理请求失败数据*/

+(void)handleRequestFaliedError:(NSError *)error Falied:(AFCFaliedBlock)falied{
    
        AFCNetFaliedModel * faliedModel = [AFCNetFaliedModel new];
    
        faliedModel.code = 0;
    
        faliedModel.message = @"";
    
        faliedModel.error = error;
    
        falied(faliedModel);
    
}


@end

@implementation AFCNetFaliedModel

@end
