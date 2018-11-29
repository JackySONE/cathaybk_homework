//
//  PlantDataAPI.m
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import "PlantDataAPI.h"

#import "HTTPSessionManager.h"
#import "BaseResponse.h"
#import "Plant.h"

static NSString *const kAnimalScope = @"resourceAquire";
static NSString *const kRid = @"f18de02f-b6c9-47c0-8cda-50efad621c14";

@implementation PlantDataAPI

+ (void)getPlantListWithLimit:(NSNumber *)limit offset:(NSNumber *)offset completion:(void (^)(NSArray<Plant *> * _Nullable, NSError * _Nullable))completionBlock
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
            animalList = [MTLJSONAdapter modelsOfClass:[Plant class] fromJSONArray:baseResponse.data error:&error];
        }

        if (completionBlock) {
            completionBlock(animalList, error);
        }

    }];
}
@end
