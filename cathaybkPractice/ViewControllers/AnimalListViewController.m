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

@interface AnimalListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) AnimalListViewModel *viewModel;

@end

@implementation AnimalListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self getListData];
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
