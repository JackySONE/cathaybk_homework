//
//  HTTPSessionManager.h
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/27.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

extern NSString *const kAPIPath;

@interface HTTPSessionManager : AFHTTPSessionManager

/**
 sharedManger is a AFHTTPSessionManager with identifier: master
 
 @return PPHTTPSessionManager
 */
+ (instancetype _Nonnull)sharedManager;

/**
 sharedManagerWithIdentifier can create AFHTTPSessionManager with different identifier
 
 @param identifier identifier name
 @return PPHTTPSessionManager
 */
+ (instancetype _Nullable)sharedManagerWithIdentifier:(NSString * _Nullable)identifier;


/**
 cancelAllTasks() will cancel all task in the same PPHTTPSessionManager
 */
- (void)cancelAllTasks;

// GET

/**
 HTTP GET method
 
 @param URLString RESTful full path
 @param parameters A Dictionary to save parameters
 @param downloadProgress Download progress block
 @param completion A comple block, if this task is canceled by other requst task, canceled parameter will be YES
 @return NSURLSessionDataTask
 */
- (nullable NSURLSessionDataTask *)GET:(NSString * _Nonnull)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress * _Nullable downloadProgress))downloadProgress
                            completion:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, BOOL canceled, NSError * _Nullable error))completion;

// POST
- (nullable NSURLSessionDataTask *)POST:(NSString * _Nonnull)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress * _Nullable uploadProgress))uploadProgress
                             completion:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, BOOL canceled, NSError * _Nullable error))completion;

// PUT
- (nullable NSURLSessionDataTask *)PUT:(NSString * _Nonnull)URLString
                            parameters:(nullable id)parameters
                            completion:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, BOOL canceled, NSError * _Nullable error))completion;

// DELETE
- (nullable NSURLSessionDataTask *)DELETE:(NSString * _Nonnull)URLString
                               parameters:(nullable id)parameters
                               completion:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject, BOOL canceled, NSError * _Nullable error))completion;



@end
