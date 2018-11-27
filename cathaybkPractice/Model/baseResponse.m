//
//  baseResponse.m
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/27.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import "baseResponse.h"

@implementation baseResponse

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"limit"  : @"limit",
             @"offset" : @"offset",
             @"count"  : @"count",
             @"data"   : @"results",
             };
}

@end
