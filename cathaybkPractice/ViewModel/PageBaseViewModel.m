//
//  PageBaseViewModel.m
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import "PageBaseViewModel.h"

@implementation PageBaseViewModel

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"currentOffset" context:nil];
}

- (void)defaltInit
{
    _items = [NSMutableArray new];

    _currentOffset      = 1;
    _limitPerPage       = 30;

    _hasMoreItems      = YES;
    _fetchItemsFailed  = NO;
    _isFetchingItems   = NO;

    [self addObserver:self forKeyPath:@"currentOffset" options:NSKeyValueObservingOptionOld context:nil];
}

#pragma mark - Custom Accessories
- (void)setIsFetchingItems:(BOOL)isFetchingItems
{
    _isFetchingItems = isFetchingItems;

    if (self.updateLoadingStatus) {
        self.updateLoadingStatus();
    }
}

#pragma mark - KVO delegate
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    self.hasMoreItems = NO;

    // 重設成第一頁的時候不要 fetchItems
    if ([keyPath isEqualToString:@"currentOffset"] && [[self valueForKey:keyPath] integerValue] == 1) {
        [self.items removeAllObjects];

        return;
    }
}

- (void)fetchItems
{

}

- (void)loadMore
{
    if (!self.isFetchingItems && !self.fetchItemsFailed && self.hasMoreItems) {
        self.currentOffset += _limitPerPage;
    }
}

- (void)resetCurrentPage
{
    self.currentOffset = 1;
}

- (void)clearItems
{
    [_items removeAllObjects];
}

@end
