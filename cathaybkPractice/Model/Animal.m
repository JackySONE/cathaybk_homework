//
//  Animal.m
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import "Animal.h"

@implementation Animal

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"nameCh"          : @"A_Name_Ch",
             @"location"        : @"A_Location",
             @"behavior"        : @"A_Behavior",
             @"interpretation"  : @"A_Interpretation",
             @"pic01_URL"       : @"A_Pic01_URL",
             };
}

@end
