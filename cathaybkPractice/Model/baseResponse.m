//
//  BaseResponse.m
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import "BaseResponse.h"

@implementation BaseResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{ @"limit" : @"limit",
              @"offset" : @"offset",
              @"count"    : @"count",
              @"data"    : @"results",
              };
}

@end
