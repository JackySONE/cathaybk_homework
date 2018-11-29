//
//  PlantListViewController.m
//  cathaybkPractice
//
//  Created by JackySONE on 2018/11/28.
//  Copyright © 2018 JackySONE. All rights reserved.
//

#import "PlantListViewController.h"

#import "PlantListViewModel.h"
#import "Plant.h"
#import "PlantListCell.h"

#import "CommonImport.h"

const CGFloat kMaxHeaderHeight = 200.f;
const CGFloat kMinHeaderHeight = 44.f;

@interface PlantListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView             *fakeNavigationBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *fakeNavigationBarHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel            *fakeNavigationTitle;
@property (weak, nonatomic) IBOutlet UILabel            *organizationName;

@property (weak, nonatomic) IBOutlet UITableView        *tableView;

@property (nonatomic, strong) PlantListViewModel        *viewModel;

@property (nonatomic, assign) CGFloat                   previousScrollOffset;

@end

@implementation PlantListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self getListData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Header
    self.fakeNavigationBarHeightConstraint.constant = kMaxHeaderHeight;
}

#pragma mark - Custom Accessories
- (PlantListViewModel *)viewModel
{
    if (!_viewModel) {
        _viewModel = [[PlantListViewModel alloc] init];

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
    CGFloat scrollViewMaxHeight = scrollView.frame.size.height + self.fakeNavigationBarHeightConstraint.constant - kMinHeaderHeight;

    // Make sure that when header is collapsed, there is still room to scroll
    BOOL isStillRoomToScroll = scrollView.contentSize.height > scrollViewMaxHeight;

    CGFloat range = kMaxHeaderHeight - kMinHeaderHeight;
    BOOL isOffsetInRange = scrollView.contentOffset.y <= range;

    return isStillRoomToScroll && isOffsetInRange;
}

- (void)setScrollPosition:(CGFloat)position
{
    self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, position);
}

- (void)scrollViewDidStopScrolling
{
    CGFloat range = kMaxHeaderHeight - kMinHeaderHeight;
    CGFloat midPoint = kMinHeaderHeight + (range / 2);

    if (self.fakeNavigationBarHeightConstraint.constant > midPoint) {
        // expand header
        [self expandHeader];
    } else {
        // collapse header
        [self collapseHeader];
    }
}

- (void)collapseHeader
{
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.2f animations:^{
        self.fakeNavigationBarHeightConstraint.constant = kMinHeaderHeight;
        [self animateFakeNavigationContentWithHeight:kMinHeaderHeight];
        [self.view layoutIfNeeded];
    }];
}

- (void)expandHeader
{
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:0.2f animations:^{
        self.fakeNavigationBarHeightConstraint.constant = kMaxHeaderHeight;
        [self animateFakeNavigationContentWithHeight:kMaxHeaderHeight];
        [self.view layoutIfNeeded];
    }];
}

- (void)animateFakeNavigationContentWithHeight:(CGFloat)contentHeight
{
    CGFloat totalScroll = kMaxHeaderHeight - kMinHeaderHeight;
    CGFloat offset = kMaxHeaderHeight - contentHeight;
    CGFloat percentage = offset / totalScroll;

    /* When percentage = 0, the alpha should be 1 so we should flip the percentage. */
    self.organizationName.alpha = (1.f - percentage);
    self.fakeNavigationTitle.alpha = percentage;
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
        CGFloat newHeight = self.fakeNavigationBarHeightConstraint.constant;
        if (isScrollingDwon) {
            newHeight = MAX(kMinHeaderHeight, self.fakeNavigationBarHeightConstraint.constant - fabs(scrollDiff));
        } else if (isScrollingUp){
            newHeight = MIN(kMaxHeaderHeight, self.fakeNavigationBarHeightConstraint.constant + fabs(scrollDiff));
        }

        // Header needs to animate
        if (newHeight != self.fakeNavigationBarHeightConstraint.constant) {
            self.fakeNavigationBarHeightConstraint.constant = newHeight;
            [self setScrollPosition:self.previousScrollOffset];
        }

        self.previousScrollOffset = scrollView.contentOffset.y;

        [self animateFakeNavigationContentWithHeight:newHeight];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidStopScrolling];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollViewDidStopScrolling];
    }
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.items.count == 0 ? 20 : self.viewModel.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     PlantListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PlantListCell class]) forIndexPath:indexPath];

    if (self.viewModel.items.count != 0) {
        if (self.viewModel.items.count > indexPath.row) {
            Plant *animal = (Plant *)self.viewModel.items[indexPath.row];
            [cell cofigureWithModel:animal];
        }

        if (indexPath.row == self.viewModel.items.count - 1) {
            [self.viewModel loadMore];
        }
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

@end
