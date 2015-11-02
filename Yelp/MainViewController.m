//
//  MainViewController.m
//  Yelp
//
//  Created by Timothy Lee on 3/21/14.
//  Copyright (c) 2014 codepath. All rights reserved.
//

#import "MainViewController.h"
#import "MBProgressHUD.h"
#import "YelpBusiness.h"
#import "BusinessTableViewCell.h"
#import "SettingsViewController.h"

@interface MainViewController () <UITableViewDataSource, UITableViewDelegate, SettingsViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *YelpTableView;
@property NSArray * Yelpbusinesses;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSString *searchBarText;
@end

@implementation MainViewController
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 70, 30);
    [button setTitle:@"Filters" forState:UIControlStateNormal];
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    button.layer.borderWidth = 0.3f;
    button.layer.cornerRadius = 3;
    button.clipsToBounds = YES;
    [button addTarget:self action:@selector(goToFiltersController) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.title = @"Yelp";
    self.YelpTableView.delegate = self;
    self.YelpTableView.dataSource = self;
    [self.YelpTableView registerNib:[UINib nibWithNibName:@"BusinessTableViewCell" bundle:nil] forCellReuseIdentifier:@"BusinessTableViewCell"];
    self.YelpTableView.estimatedRowHeight = 86;
    self.YelpTableView.rowHeight = UITableViewAutomaticDimension;
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    [self.searchBar sizeToFit];
    self.searchBar.text = @"restaurants";
    _searchBarText = @"restaurants";
    self.navigationItem.titleView = self.searchBar;
    [self searchByFilters:NULL:@"NO" :0:@"restaurants"];

}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [self.searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    _searchBarText = searchBar.text;
    [searchBar resignFirstResponder];
    [self searchByFilters:NULL:@"NO" :0:searchBar.text];
}

- (void) searchByFilters:(NSArray *) category_filters: (NSString*) deal_filter : (double) radius_filter:(NSString*) term {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    BOOL dealBool;
    if ([deal_filter  isEqual: @"YES"])
        dealBool = YES;
    else
        dealBool =  NO;
    [YelpBusiness searchWithTerm:term
                        sortMode:YelpSortModeBestMatched
                      categories:category_filters
                           deals:NO
                            radius: 0
                      completion:^(NSArray *businesses, NSError *error) {
                          self.Yelpbusinesses = businesses;
                          [self.YelpTableView reloadData];
                          [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Yelpbusinesses.count;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessTableViewCell"];
    cell.business = _Yelpbusinesses[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

- (void)goToFiltersController{
    SettingsViewController *svc = [[SettingsViewController alloc] init];
    svc.delegate = self;
    UINavigationController *unc = [[UINavigationController alloc] initWithRootViewController:svc];
    [unc.navigationBar setBarTintColor:[UIColor colorWithRed:0.88 green:0.11 blue:0.11 alpha:1.0]];
    unc.navigationBar.tintColor = [UIColor whiteColor];
    unc.navigationBar.translucent = NO;
    [unc.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self presentViewController:unc animated:YES completion:nil];
}

-(void) settingsViewController:(SettingsViewController *) settingsViewController didChangeFilters:(NSDictionary*) filters{
    [self searchByFilters:filters[@"category_filter"]:filters[@"deal_filter"]:[filters[@"radius_filter"] doubleValue]: _searchBarText];
}
@end
