//
//  AnimalListCell.m
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import "AnimalListCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import "Plant.h"

@interface AnimalListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *picture01ImageView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *location;
@property (weak, nonatomic) IBOutlet UILabel *behavior;

@end

@implementation AnimalListCell

- (void)cofigureWithModel:(Plant *)plant
{
    self.name.text = plant.nameCh;
    self.location.text = plant.location;

    NSString *behaviorOrInterpretation = [plant.pFeature isEqualToString:@""] ? plant.pBrief : plant.pFeature;
    if ([behaviorOrInterpretation isEqualToString:@""]) {
        behaviorOrInterpretation = @"無描述資料";
    }
    self.behavior.text = behaviorOrInterpretation;

    [self.picture01ImageView sd_setImageWithURL:[NSURL URLWithString:plant.pic01_URL]];
}

@end
