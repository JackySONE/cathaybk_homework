//
//  AnimalListViewModel.m
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import "AnimalListViewModel.h"

#import "PlantDataAPI.h"

#import "CommonImport.h"

@implementation AnimalListViewModel

#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];

    if (self) {
        [self defaltInit];
    }

    return self;
}

#pragma marl - Overwrite
- (void)defaltInit
{
    [super defaltInit];
}

-(void)fetchItems
{
    if (self.isFetchingItems) {
        return;
    }

    self.isFetchingItems = YES;

    weakify(self);
    [PlantDataAPI getPlantListWithLimit:@(self.limitPerPage) offset:@(self.currentOffset) completion:^(NSArray<Plant *> * _Nullable itemListEntries, NSError * _Nullable error) {
        strongify(self);

        self.hasMoreItems     = (itemListEntries.count == self.limitPerPage);
        self.fetchItemsFailed = (error != nil);
        self.isFetchingItems  = NO;

        [self.items addObjectsFromArray:itemListEntries];

        if (self.observeItemsBlock != nil) {
            self.observeItemsBlock(itemListEntries);
        }

        if (error) {
            self.errorHandler(error, NSLocalizedString(@"ListViewModel.FetchItemsFailed", @"取得清單失敗"));
        }
    }];
}

#pragma mark - KVO delegate
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];

    [self fetchItems];
}
@end
