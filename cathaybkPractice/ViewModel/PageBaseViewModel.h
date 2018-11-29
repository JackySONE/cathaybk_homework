//
//  PageBaseViewModel.h
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PageBaseViewModel : NSObject

@property (nonatomic, readonly) NSMutableArray                      *items;
@property (nonatomic, assign) NSInteger                             currentOffset;
@property (nonatomic, assign) NSInteger                             limitPerPage;

@property (nonatomic, assign) BOOL                                  isFetchingItems;
@property (nonatomic, assign) BOOL                                  hasMoreItems;
@property (nonatomic, assign) BOOL                                  fetchItemsFailed;

@property (nonatomic ,copy) void (^updateLoadingStatus)(void);
@property (nonatomic, copy) void (^observeItemsBlock)(NSArray* );
@property (nonatomic, copy) void (^errorHandler)(NSError *error, NSString *title);

- (void)defaltInit;
- (void)fetchItems;
- (void)loadMore;
- (void)resetCurrentPage;
- (void)clearItems;

@end

NS_ASSUME_NONNULL_END
