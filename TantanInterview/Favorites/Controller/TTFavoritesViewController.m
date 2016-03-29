//
//  FavoritesViewController.m
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import "TTFavoritesViewController.h"
#import "TTInfoViewController.h"
#import "TTFavoritesModel.h"
#import "TTCourses.h"
#import "TTTableViewCell.h"

@interface TTFavoritesViewController ()

@end

@implementation TTFavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Favorites";
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[TTFavoritesModel sharedInstance].myFavorites count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    
    //reuse cell
    TTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        //load cell from ccb
        NSArray* array = [[NSBundle mainBundle] loadNibNamed:@"TTTableViewCell" owner:self options:nil];
        cell = [array objectAtIndex:0];
    }
    
    cell.info = [[[TTFavoritesModel sharedInstance].myFavorites allObjects] objectAtIndex:(NSUInteger)indexPath.row];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(__unused UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TTInfoViewController * ivc = [[TTInfoViewController alloc] init];
    TTCourses* courses = [[TTCourses alloc] initWithBasicInfo:[[[TTFavoritesModel sharedInstance].myFavorites allObjects] objectAtIndex:(NSUInteger)indexPath.row]];
    [ivc setCourse:courses];
    [self.navigationController pushViewController:ivc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
