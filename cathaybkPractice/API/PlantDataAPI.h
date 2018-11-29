//
//  PlantDataAPI.h
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Animal;

NS_ASSUME_NONNULL_BEGIN

@interface PlantDataAPI : NSObject

+ (void)getPlantListWithLimit:(NSNumber *)limit offset:(NSNumber *)offset completion:(void (^_Nullable)(NSArray<Animal *> * _Nullable itemListEntries, NSError * _Nullable error))completionBlock;

@end

NS_ASSUME_NONNULL_END
