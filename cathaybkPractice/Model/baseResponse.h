//
//  BaseResponse.h
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/27.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import <Mantle/Mantle.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseResponse : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSNumber *limit;
@property (nonatomic, strong) NSNumber *offset;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, readonly) id data;

@end

NS_ASSUME_NONNULL_END
