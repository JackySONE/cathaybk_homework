//
//  Plant.h
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface Plant : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) NSString *nameCh;
@property (nonatomic, readonly) NSString *location;
@property (nonatomic, readonly) NSString *pFeature;
@property (nonatomic, readonly) NSString *pBrief;
@property (nonatomic, readonly) NSString *pic01_URL;

@end

NS_ASSUME_NONNULL_END
