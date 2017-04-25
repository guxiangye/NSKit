//
//  YEAFNRequestManager.h
//  YEAFNManager
//
//  Created by 相晔谷 on 16/4/7.
//  Copyright © 2016年 相晔谷. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#ifdef DEBUG
#define YEAFNAppLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define YEAFNAppLog(s, ... )
#endif

//#ifdef DEBUG
//#define NSLog(s, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:s, ## __VA_ARGS__] UTF8String]);
//#else
//#define NSLog(s, ...)
//#endif

#import <CommonCrypto/CommonDigest.h>

@interface NSString (md5)

+ (NSString *)YENetworking_md5:(NSString *)string;

@end

/**
 *  @author YE
 *
 *  下载进度
 *
 *  @param bytesRead                 已下载的大小
 *  @param totalBytesRead            文件总大小
 */
typedef void (^YEDownloadProgress)(int64_t bytesRead,
                                   int64_t totalBytesRead);

/**
 *  返回值, 全为: task
 */
typedef NSURLSessionTask YEURLSessionTask;

typedef NSURLSessionTask YEAFNURLSessionTask;

typedef void(^BlockInGroup)();

@interface YEAFNRequestManager : NSObject

+ (YEAFNRequestManager *)sharedManager;


/**
 *  dict -> string
 *
 *  @param dic 2
 *
 *  @return 2
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/**
 *  jsonString -> dict
 *
 *  @param jsonString 2
 *
 *  @return 2
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


#pragma mark - JSON格式的网络请求基于 AFN 的第二次封装

/**
 *  一.json 格式的请求
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
                            failure:(void(^)(NSError *error))failure;

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
                             failure:(void(^)(NSError *error))failure;

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
                            failure:(void(^)(NSError *error))failure;

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
                               failure:(void(^)(NSError *error))failure;

/**
 *  5.监听网络连接情况
 */
+ (void)MonitoringNetworking:(void(^)(NSString *monitoringEvent))monitoringEvent;

/**
 *  6.取消网络请求
 *
 *  @param task 参数: task
 */
+ (void)cancelTask:(YEAFNURLSessionTask *)task;

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
                               failure:(void(^)(NSError *error))failure;

/**
 *  8.download 下载
 *  @param url      地址
 *  @param header   请求头
 *  @param parmas   参数
 *  @param cachesPath data 文件
 *  @param progress 进度
 *  @param success  成功回调
 *  @param failure  失败回调
 
 @return 可用于中断下载
 */
+ (NSURLSessionDownloadTask *)DownloadHttpURL:(NSString *)url
                                  header:(NSDictionary *)header
                                  parmas:(NSDictionary *)parmas
                              cachesPath:(NSString *)cachesPath
                                progress:(YEDownloadProgress)progress
                                 success:(void(^)(id responseObject))success
                                 failure:(void(^)(NSError *error))failure;

/**
 * 开始下载
 
 @param task task description
 */
+ (void)startDownload:(NSURLSessionDownloadTask *)task;

/**
 * 暂停下载
 
 @param task task description
 */
+ (void)stopDownload:(NSURLSessionDownloadTask *)task;


#pragma mark - 组请求

/**
 * GETGroupRequest 与 GETInGroupHttpURL 需配套使用
 */
+ (YEAFNURLSessionTask *)GETInGroupHttpURL:(NSString *)url
                                    header:(NSDictionary *)header
                                    parmas:(NSDictionary *)parmas
                                  progress:(YEDownloadProgress)progress
                                   success:(void(^)(id responseObject))success
                                   failure:(void(^)(NSError *error))failure;
/**
 * GETGroupRequest 与 GETInGroupHttpURL 需配套使用
 */
+ (void)GETGroupRequest:(BlockInGroup)requests
                success:(void(^)())success
                failure:(void(^)(NSArray *errorArray))failure;

/**
 * POSTInGroupHttpURL 与 POSTGroupRequest 需配套使用
 */
+ (YEAFNURLSessionTask *)POSTInGroupHttpURL:(NSString *)url
                                     header:(NSDictionary *)header
                                     parmas:(NSDictionary *)parmas
                                   progress:(YEDownloadProgress)progress
                                    success:(void(^)(id responseObject))success
                                    failure:(void(^)(NSError *error))failure;
/**
 * POSTGroupRequest 与 POSTInGroupHttpURL 需配套使用
 */
+ (void)POSTGroupRequest:(BlockInGroup)requests
                 success:(void(^)())success
                 failure:(void(^)(NSArray *errorArray))failure;

@end
