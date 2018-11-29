//
//  AnimalDataAPI.m
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import "AnimalDataAPI.h"

#import "HTTPSessionManager.h"
#import "BaseResponse.h"
#import "Animal.h"

static NSString *const kAnimalScope = @"resourceAquire";
static NSString *const kRid = @"a3e2b221-75e0-45c1-8f97-75acbd43d613";

@implementation AnimalDataAPI

+ (void)getAnimalListWithLimit:(NSNumber *)limit offset:(NSNumber *)offset completion:(void (^)(NSArray<Animal *> * _Nullable, NSError * _Nullable))completionBlock
{
    NSString *path = [NSString stringWithFormat:@"%@", kAPIPath];

    // unique identifier
    HTTPSessionManager *manger = [HTTPSessionManager sharedManager];

    NSMutableDictionary *parameters = [NSMutableDictionary new];

    parameters[@"limit"]    = limit;
    parameters[@"scope"]    = kAnimalScope;
    parameters[@"rid"]      = kRid;
    parameters[@"offset"]   = offset;

    [manger GET:path parameters:parameters progress:nil completion:^(NSURLSessionDataTask *task, id responseObject, BOOL canceled, NSError *error) {

        BaseResponse *baseResponse = [MTLJSONAdapter modelOfClass:[BaseResponse class] fromJSONDictionary:responseObject[@"result"] error:&error];

        NSArray *animalList = nil;
        if (baseResponse.data) {
            animalList = [MTLJSONAdapter modelsOfClass:[Animal class] fromJSONArray:baseResponse.data error:&error];
        }

        if (completionBlock) {
            completionBlock(animalList, error);
        }

    }];
}
@end