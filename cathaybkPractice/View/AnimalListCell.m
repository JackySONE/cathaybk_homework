//
//  AnimalListCell.m
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import "AnimalListCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "Animal.h"

@interface AnimalListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picture01ImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *behavior;

@end

@implementation AnimalListCell

- (void)cofigureWithModel:(Animal *)animal
{
    self.name.text = animal.nameCh;
    self.location.text = animal.location;

    NSString *behaviorOrInterpretation = [animal.behavior isEqualToString:@""] ? animal.interpretation : animal.behavior;
    if ([behaviorOrInterpretation isEqualToString:@""]) {
        behaviorOrInterpretation = @"無描述資料";
    }
    self.behavior.text = behaviorOrInterpretation;

    [self.picture01ImageView sd_setImageWithURL:[NSURL URLWithString:animal.pic01_URL]];
}

@end
