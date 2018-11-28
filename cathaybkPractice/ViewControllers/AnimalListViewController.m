//
//  AnimalListViewController.m
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import "AnimalListViewController.h"

#import "AnimalListViewModel.h"
#import "Animal.h"
#import "AnimalListCell.h"

#import "CommonImport.h"

#define MaxHeaderHeight 200
#define MinHeaderHeight 44

@interface AnimalListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView             *headerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView        *tableView;

@property (nonatomic, strong) AnimalListViewModel       *viewModel;

@property (nonatomic, assign) CGFloat                   previousScrollOffset;

@end

@implementation AnimalListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self getListData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Header
    self.headerHeightConstraint.constant = MaxHeaderHeight;
}

#pragma mark - Custom Accessories
- (AnimalListViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[AnimalListViewModel alloc] init];

        weakify(self);
        _viewModel.errorHandler = ^(NSError *error, NSString *title) {
            // show error Alert
        };

        _viewModel.observeItemsBlock = ^(NSArray *list) {
            strongify(self);
            [self.tableView reloadData];
        };
    }

    return _viewModel;
}

#pragma mark - Private
- (void)getListData
{
    [self.viewModel fetchItems];
}

- (BOOL)canAnimateHeader:(UIScrollView *)scrollView
{
    // Calculate the size of the scrollView when header is collapsed
    CGFloat scrollViewMaxHeight = scrollView.frame.size.height + self.headerHeightConstraint.constant - MinHeaderHeight;

    // Make sure that when header is collapsed, there is still room to scroll
    return scrollView.contentSize.height > scrollViewMaxHeight;
}

- (void)setScrollPosition:(CGFloat)position
{
    self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, position);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset;

    CGFloat absoluteTop     = 0;
    CGFloat absoluteBottom  = scrollView.contentSize.height - scrollView.frame.size.height;

    BOOL isScrollingDwon    = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop;
    BOOL isScrollingUp      = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom;

    if ([self canAnimateHeader:scrollView]) {

        // Calculate new header height
        CGFloat newHeight = self.headerHeightConstraint.constant;
        if (isScrollingDwon) {
            newHeight = MAX(MinHeaderHeight, self.headerHeightConstraint.constant - fabs(scrollDiff));
        } else if (isScrollingUp){
            newHeight = MIN(MaxHeaderHeight, self.headerHeightConstraint.constant + fabs(scrollDiff));
        }

        // Header needs to animate
        if (newHeight != self.headerHeightConstraint.constant) {
            self.headerHeightConstraint.constant = newHeight;
            [self setScrollPosition:self.previousScrollOffset];
        }

        self.previousScrollOffset = scrollView.contentOffset.y;
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     AnimalListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([AnimalListCell class]) forIndexPath:indexPath];

    if (self.viewModel.items.count > indexPath.row) {
        Animal *animal = (Animal *)self.viewModel.items[indexPath.row];
        [cell cofigureWithModel:animal];
    }

    if (indexPath.row == self.viewModel.items.count - 1) {
        [self.viewModel loadMore];
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

@end
