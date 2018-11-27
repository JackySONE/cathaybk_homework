//
//  HTTPSessionManager.m
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/27.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import "HTTPSessionManager.h"
#import "OrderedDictionary.h"

NSString *const kAPIPath = @"https://data.taipei/opendata/datalist/apiAccess";

@implementation HTTPSessionManager

#pragma mark - Overwrite
- (instancetype)initDefault
{
    self = [[[super class] alloc] initWithBaseURL:nil];
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    // TimeOut Setting
    [self.requestSerializer setTimeoutInterval:60.0];

    return self;
}

+ (instancetype)manager
{
    return [[[self class] alloc] initDefault];
}

#pragma mark - Shared Manger With Identifier
+ (instancetype)sharedManager {
    return [self sharedManagerWithIdentifier:@"master"];
}

+ (instancetype)sharedManagerWithIdentifier:(NSString *)identifier {
    HTTPSessionManager *sharedManger = [[self sharedMangers] objectForKey:identifier];
    
    if (sharedManger == nil) {
        sharedManger = [[[self class] alloc] initDefault];

        sharedManger.requestSerializer = [AFJSONRequestSerializer serializer];                               //  如果Metod 為 POST，但parameter為 nil時
        [sharedManger.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];    //  Content-Type會不見，造成api 的 request error
        
        [[self sharedMangers] setObject:sharedManger forKey:identifier];
    }
    
    return sharedManger;
}

+ (id)sharedMangers {
    static MutableOrderedDictionary *_sharedMangers = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedMangers = [[MutableOrderedDictionary alloc] init];
    });
    
    return _sharedMangers;
}

- (void)cancelAllTasks
{
    [self.tasks enumerateObjectsUsingBlock:^(NSURLSessionTask *aTask, NSUInteger idx, BOOL *stop) {
        [aTask cancel];
    }];
}

#pragma mark - GET, POST, PUT, DELETE
// GET
- (NSURLSessionDataTask *)GET:(NSString * _Nonnull)URLString
                   parameters:(nullable id)parameters
                     progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
                   completion:(nullable void (^)(NSURLSessionDataTask * _Nullable, id _Nullable, BOOL, NSError * _Nullable))completion
{
    
    NSLog(@"GET '%@' -- by manger(%p)", [self getRelatedPathWithFullPath:URLString], self);
    NSURLSessionDataTask *dataTask = [super GET:URLString
                                     parameters:parameters
                                       progress:downloadProgress
                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            if (completion) {
                                                completion(task, responseObject, NO, nil);
                                            }
                                        }
                                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            
                                            // 取消請求
                                            if (task.error.code == NSURLErrorCancelled) {
                                                if (completion) {
                                                    completion(nil, nil, YES, nil);
                                                    return;
                                                }
                                            }
                                            
                                            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                                            
                                            NSDictionary *serializedData;
                                            
                                            if (errorData) {
                                                serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
                                            }
                                            
                                            if (completion) {
                                                completion(task, serializedData, NO, error);
                                            }
                                        }];
    
    return dataTask;
}

// POST
- (NSURLSessionDataTask *)POST:(NSString * _Nonnull)URLString
                    parameters:(nullable id)parameters
                      progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                    completion:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, BOOL, NSError * _Nullable error))completion
{
    NSLog(@"POST '%@' -- by manger(%p)", [self getRelatedPathWithFullPath:URLString], self);
    NSURLSessionDataTask *dataTask = [super POST:URLString
                                      parameters:parameters
                                        progress:uploadProgress
                                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                             if (completion) {
                                                 completion(task, responseObject, NO, nil);
                                             }
                                         }
                                         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                             
                                             // 取消請求
                                             if (task.error.code == NSURLErrorCancelled) {
                                                 if (completion) {
                                                     completion(nil, nil, YES, nil);
                                                     return;
                                                 }
                                             }
                                             
                                             NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                                             NSDictionary *serializedData;
                                             
                                             if (errorData) {
                                                 serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
                                             }
                                             
                                             if (completion) {
                                                 completion(task, serializedData, NO, error);
                                             }
                                         }];
    
    return dataTask;
}

// PUT
- (NSURLSessionDataTask *)PUT:(NSString * _Nonnull)URLString
                   parameters:(nullable id)parameters
                   completion:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, BOOL, NSError * _Nullable error))completion
{
    NSLog(@"PUT '%@' -- by manger(%p)", [self getRelatedPathWithFullPath:URLString], self);
    NSURLSessionDataTask *dataTask = [super PUT:URLString
                                     parameters:parameters
                                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                            if (completion) {
                                                completion(task, responseObject, NO, nil);
                                            }
                                        }
                                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                            
                                            // 取消請求
                                            if (task.error.code == NSURLErrorCancelled) {
                                                if (completion) {
                                                    completion(nil, nil, YES, nil);
                                                    return;
                                                }
                                            }
                                            
                                            NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                                            NSDictionary *serializedData;
                                            
                                            if (errorData) {
                                                serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
                                            }
                                            
                                            if (completion) {
                                                completion(task, serializedData, NO, error);
                                            }
                                        }];
    
    return dataTask;
}

// DELETE
- (NSURLSessionDataTask *)DELETE:(NSString * _Nonnull)URLString
                      parameters:(nullable id)parameters
                      completion:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, BOOL, NSError * _Nullable error))completion
{
    NSLog(@"DELETE '%@' -- by manger(%p)", [self getRelatedPathWithFullPath:URLString], self);
    
    // ref: https://stackoverflow.com/questions/25140900/afnetworking-http-delete-use-body-instead-of-url
    self.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithObjects:@"GET", @"HEAD", nil];
    
    NSURLSessionDataTask *dataTask = [super DELETE:URLString
                                        parameters:parameters
                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                               if (completion) {
                                                   completion(task, responseObject, NO, nil);
                                               }
                                           }
                                           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                               
                                               // 取消請求
                                               if (task.error.code == NSURLErrorCancelled) {
                                                   if (completion) {
                                                       completion(nil, nil, YES, nil);
                                                       return;
                                                   }
                                               }
                                               
                                               NSData *errorData = error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                                               NSDictionary *serializedData;
                                               
                                               if (errorData) {
                                                   serializedData = [NSJSONSerialization JSONObjectWithData: errorData options:kNilOptions error:nil];
                                               }
                                               
                                               if (completion) {
                                                   completion(task, serializedData, NO, error);
                                               }
                                           }];
    
    return dataTask;
}

#pragma mark - Private
- (NSString *)getRelatedPathWithFullPath:(NSString *)path
{
    NSArray *tmp = [path componentsSeparatedByString:kAPIPath];
    
    if (tmp && tmp.count >= 2) {
        return tmp[1];
    } else {
        return @"???";
    }
}

@end
