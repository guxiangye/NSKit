//
//  YEAFNRequestManager.m
//  YEAFNManager
//
//  Created by 相晔谷 on 16/4/7.
//  Copyright © 2016年 相晔谷. All rights reserved.
//

#import "YEAFNRequestManager.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

@implementation NSString (md5)

+ (NSString *)YENetworking_md5:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];
    
    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    
    return [ms copy];
}

@end

@implementation YEAFNRequestManager


+ (YEAFNRequestManager *)sharedManager {
    
    static YEAFNRequestManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

/**
 *  dict -> string
 *
 *  @param dic json 字典
 *
 *  @return 字符串
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic {
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/**
 *  jsonString -> dict
 *
 *  @param jsonString json 字符串
 *
 *  @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        return nil;
    }else {
        return dic;
    }
}

#pragma mark - JSON格式的网络请求基于 AFN 的第二次封装
/**
 *  (一)json 格式的请求
 */

/**
 *  1.GET
 *
 *  @param url     地址
 *  @param parmas  参数
 *  @param success 成功回掉
 *  @param failure 失败回掉
 *
 *  @return 返回: task
 */
+ (YEAFNURLSessionTask *)GETHttpURL:(NSString *)url
                             header:(NSDictionary *)header
                             parmas:(NSDictionary *)parmas
                           progress:(YEDownloadProgress)progress
                            success:(void(^)(id responseObject))success
                            failure:(void(^)(NSError *error))failure {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadRevalidatingCacheData];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    for (NSString *key in header) {
        [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
    }
    YEAFNURLSessionTask *task = [manager GET:url parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {
            progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSString *result =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (success) {
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(failure){
            failure(error);
        }
    }];
    
    return task;
}

/**
 *  2.POST
 *
 *  @param url     地址
 *  @param parmas  参数
 *  @param success 成功回掉
 *  @param failure 失败回掉
 *
 *  @return 返回: task
 */
+ (YEAFNURLSessionTask *)POSTHttpURL:(NSString *)url
                              header:(NSDictionary *)header
                              parmas:(NSDictionary *)parmas
                            progress:(YEDownloadProgress)progress
                             success:(void(^)(id responseObject))success
                             failure:(void(^)(NSError *error))failure {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", @"text/javascript", nil];
    
    for (NSString *key in header) {
        [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
    }
    
    YEAFNURLSessionTask *task = [manager POST:url parameters:parmas progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (progress) {
            progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSString *result =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (success) {
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(failure){
            failure(error);
        }
    }];
    
    return task;
}

/**
 *  3.PUT
 *
 *  @param url     地址
 *  @param parmas  参数
 *  @param success 成功回掉
 *  @param failure 失败回掉
 *
 *  @return 返回: task
 */
+ (YEAFNURLSessionTask *)PUTHttpURL:(NSString *)url
                             header:(NSDictionary *)header
                             parmas:(NSDictionary *)parmas
                           progress:(YEDownloadProgress)progress
                            success:(void(^)(id responseObject))success
                            failure:(void(^)(NSError *error))failure {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    for (NSString *key in header) {
        [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
    }
    YEAFNURLSessionTask *task = [manager PUT:url parameters:parmas success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSString *result =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (success) {
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(failure){
            failure(error);
        }
    }];
    
    return task;
}

/**
 *  4.DELETE
 *
 *  @param url     地址
 *  @param parmas  参数
 *  @param success 成功回掉
 *  @param failure 失败回掉
 *
 *  @return 返回: task
 */
+ (YEAFNURLSessionTask *)DELETEHttpURL:(NSString *)url
                                header:(NSDictionary *)header
                                parmas:(NSDictionary *)parmas
                              progress:(YEDownloadProgress)progress
                               success:(void(^)(id responseObject))success
                               failure:(void(^)(NSError *error))failure {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    for (NSString *key in header) {
        [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
    }
    YEAFNURLSessionTask *task = [manager DELETE:url parameters:parmas success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSString *result =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (success) {
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(failure){
            failure(error);
        }
    }];
    
    return task;
}

/**
 *  5.监听网络连接情况
 */
+ (void)MonitoringNetworking:(void(^)(NSString *monitoringEvent))monitoringEvent {
    
    __block NSString *networking;
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager startMonitoring];  //开始监听
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            networking = @"无网络,请检查网络链接";
        }else if (status == AFNetworkReachabilityStatusUnknown){
            networking = @"未知网络环境";
        }else if (status == AFNetworkReachabilityStatusReachableViaWWAN){
            networking = @"您正通过蜂窝移动上网";
        }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
            networking = @"您正在WiFi环境";
        }
        
        if (monitoringEvent) {
            monitoringEvent(networking);
        }
    }];
}

/**
 *  内部自用 勿管
 */
+ (void)monitoringNetworking:(void(^)(AFNetworkReachabilityStatus networkingEvent))monitoringEvent {
    
    AFNetworkReachabilityManager *netManager = [AFNetworkReachabilityManager sharedManager];
    [netManager startMonitoring];  //开始监听
    [netManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status){
        if (monitoringEvent) {
            monitoringEvent(status);
        }
    }];
}

/**
 *  6.取消网络请求
 *
 *  @param task 参数: task
 */
+ (void)cancelTask:(YEAFNURLSessionTask *)task {
    
    [task cancel];
}

/**
 *  7.上传文件
 *
 *  @param url      地址
 *  @param header   请求头
 *  @param parmas   参数
 *  @param fileData data 文件
 *  @param progress 进度
 *  @param success  成功回调
 *  @param failure  失败回调
 *
 *  @return task 可用于中断上传
 */
+ (YEAFNURLSessionTask *)UPDataHttpURL:(NSString *)url
                                header:(NSDictionary *)header
                                parmas:(NSDictionary *)parmas
                              fileData:(NSData *)fileData
                              progress:(YEDownloadProgress)progress
                               success:(void(^)(id responseObject))success
                               failure:(void(^)(NSError *error))failure {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json", @"text/plain", @"text/html", nil];
    
    for (NSString *key in header) {
        [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
    }
    YEAFNURLSessionTask *task = [manager POST:url parameters:parmas constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        //使用日期生成图片名称
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        
        NSString *fileName = [NSString stringWithFormat:@"%@.png",[formatter stringFromDate:[NSDate date]]];
        
        [formData appendPartWithFileData:fileData name:@"file" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (progress) {
            progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        NSString *result =  [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (success) {
            success(result);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(failure){
            failure(error);
        }
    }];
    
    return task;
}


/**
 *  8.download 下载
 *  @param url          地址
 *  @param header       请求头
 *  @param parmas       参数
 *  @param cachesPath   缓存路径
 *  @param progress     进度
 *  @param success      成功回调
 *  @param failure      失败回调

 @return 可用于中断下载
 */
+ (NSURLSessionDownloadTask *)DownloadHttpURL:(NSString *)url
                                  header:(NSDictionary *)header
                                  parmas:(NSDictionary *)parmas
                              cachesPath:(NSString *)cachesPath
                                progress:(YEDownloadProgress)progress
                                 success:(void(^)(id responseObject))success
                                 failure:(void(^)(NSError *error))failure {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //AFN3.0+基于封住URLSession的句柄
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSData *parmasData;
    if (parmas) {
        parmasData = [NSJSONSerialization dataWithJSONObject:parmas options:NSJSONWritingPrettyPrinted error:nil];
    }
    NSURL *URL = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setHTTPBody:parmasData];

    for (NSString *key in header) {
        [request setValue:header[key] forHTTPHeaderField:key];
    }
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //- block的返回值, 要求返回一个URL, 返回的这个URL就是文件的位置的路径
        NSFileManager *fileManager = [NSFileManager defaultManager];
        YEAFNAppLog(@"%@", cachesPath);
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        
        if (path) { // 如果存在, 先删掉
            [fileManager removeItemAtPath:path error:nil];
        }
        
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 设置下载完成操作
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (!error) {
            // filePath: 下载文件的位置，解压、或直接使用
            NSString *downloadFilePath = [filePath path];// 将NSURL转成NSString
            if (success) {
                success(downloadFilePath);
            }
        }else {
            if (failure) {
                failure(error);
            }
        }
    }];

    return task;
}


/**
 * 开始下载

 @param task task description
 */
+ (void)startDownload:(NSURLSessionDownloadTask *)task {
    
    [task resume];
}

/**
 * 暂停下载
 
 @param task task description
 */
+ (void)stopDownload:(NSURLSessionDownloadTask *)task {
    
    [task suspend];
}

static char groupErrorKey;
static char queueGroupKey;
+ (YEAFNURLSessionTask *)GETInGroupHttpURL:(NSString *)url
                                    header:(NSDictionary *)header
                                    parmas:(NSDictionary *)parmas
                                  progress:(YEDownloadProgress)progress
                                   success:(void(^)(id responseObject))success
                                   failure:(void(^)(NSError *error))failure {
    
    dispatch_group_t group = objc_getAssociatedObject([NSOperationQueue currentQueue], &queueGroupKey);
    // 如果是非组请求
    if (group == nil) {
        // 执行original method
        return [YEAFNRequestManager GETHttpURL:url
                                        header:header
                                        parmas:parmas
                                      progress:progress
                                       success:success
                                       failure:failure];
    }
    dispatch_group_enter(group);
    
    YEAFNURLSessionTask *task = [YEAFNRequestManager GETHttpURL:url header:header parmas:parmas progress:progress success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        NSMutableArray *arrayM = objc_getAssociatedObject(group, &groupErrorKey);
        [arrayM addObject:error];
        if(failure){
            failure(error);
        }
        dispatch_group_leave(group);
    }];
    
    return task;
}

+ (void)GETGroupRequest:(BlockInGroup)requests
                success:(void(^)())success
                failure:(void(^)(NSArray *errorArray))failure {
    
    dispatch_group_t group = dispatch_group_create();
    objc_setAssociatedObject(group, &groupErrorKey, [NSMutableArray array], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    Method originalPost = class_getInstanceMethod(self.class, @selector(GETGroupRequest:success:failure:));
    Method groupPost = class_getInstanceMethod(self.class, @selector(GETInGroupHttpURL:header:parmas:progress:success:failure:));
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    objc_setAssociatedObject(queue, &queueGroupKey, group, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    queue.qualityOfService = NSQualityOfServiceUserInitiated;
    queue.maxConcurrentOperationCount = 3;
    
    [queue addOperationWithBlock:^{
        
        method_exchangeImplementations(originalPost, groupPost);
        requests();
        method_exchangeImplementations(originalPost, groupPost);
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSMutableArray *arrayM = objc_getAssociatedObject(group, &groupErrorKey);
            if (arrayM.count > 0) {
                if (failure) {
                    failure(arrayM.copy);
                }
            } else if(success) {
                success();
            }
        });
    }];
}

+ (YEAFNURLSessionTask *)POSTInGroupHttpURL:(NSString *)url
                                     header:(NSDictionary *)header
                                     parmas:(NSDictionary *)parmas
                                   progress:(YEDownloadProgress)progress
                                    success:(void(^)(id responseObject))success
                                    failure:(void(^)(NSError *error))failure {
    
    dispatch_group_t group = objc_getAssociatedObject([NSOperationQueue currentQueue], &queueGroupKey);
    // 如果是非组请求
    if (group == nil) {
        // 执行original method
        return [YEAFNRequestManager POSTHttpURL:url
                                         header:header
                                         parmas:parmas
                                       progress:progress
                                        success:success
                                        failure:failure];
    }
    dispatch_group_enter(group);
    
    YEAFNURLSessionTask *task = [YEAFNRequestManager POSTHttpURL:url header:header parmas:parmas progress:progress success:^(id responseObject) {
        if (success) {
            success(responseObject);
        }
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        NSMutableArray *arrayM = objc_getAssociatedObject(group, &groupErrorKey);
        [arrayM addObject:error];
        if(failure){
            failure(error);
        }
        dispatch_group_leave(group);
    }];
    
    return task;
}

+ (void)POSTGroupRequest:(BlockInGroup)requests
                 success:(void(^)())success
                 failure:(void(^)(NSArray *errorArray))failure {
    
    dispatch_group_t group = dispatch_group_create();
    objc_setAssociatedObject(group, &groupErrorKey, [NSMutableArray array], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    Method originalPost = class_getInstanceMethod(self.class, @selector(POSTGroupRequest:success:failure:));
    Method groupPost = class_getInstanceMethod(self.class, @selector(POSTInGroupHttpURL:header:parmas:progress:success:failure:));
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    objc_setAssociatedObject(queue, &queueGroupKey, group, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    queue.qualityOfService = NSQualityOfServiceUserInitiated;
    queue.maxConcurrentOperationCount = 3;
    
    [queue addOperationWithBlock:^{
        
        method_exchangeImplementations(originalPost, groupPost);
        // 现在发起请求会调用上面的组请求方法
        requests();
        // 发出请求后就可以替换回original method，不必等待回调，尽量减小替换的时间窗口
        method_exchangeImplementations(originalPost, groupPost);
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            NSMutableArray *arrayM = objc_getAssociatedObject(group, &groupErrorKey);
            // 只要组里的一个请求失败，就走组失败的回调
            if (arrayM.count > 0) {
                if (failure) {
                    failure(arrayM.copy);
                }
            } else if(success) {
                success();
            }
        });
    }];
}

@end
