//
//  AnimalListCell.h
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Animal;

NS_ASSUME_NONNULL_BEGIN

@interface AnimalListCell : UITableViewCell

- (void)cofigureWithModel:(Animal *)animal;

@end

NS_ASSUME_NONNULL_END