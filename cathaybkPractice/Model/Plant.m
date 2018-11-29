//
//  Plant.m
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import "Plant.h"

@implementation Plant

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"nameCh"          : @"F_Name_Ch",
             @"location"        : @"F_Location",
             @"pFeature"        : @"F_Feature",
             @"pBrief"           : @"F_Brief",
             @"pic01_URL"       : @"F_Pic01_URL",
             };
}

@end
