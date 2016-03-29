//
//  HomeViewController.m
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import "TTHomeViewController.h"
#import <UIRefreshControl+AFNetworking.h>
#import "MBProgressHUD+Show.h"
#import "TTModel.h"
#import "TTTableViewCell.h"
#import "TTInfoViewController.h"
#import "TTCourses.h"

@interface TTHomeViewController ()

@end

@implementation TTHomeViewController


- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)reload:(id)sender {
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    [MBProgressHUD showWithLoadingViewAddedTo:self.navigationController text:@"正在加载" detailLabel:@"请稍候.." delegate:nil duration:0 dimBackground:NO];
    
    NSURLSessionTask *task = [TTModel getListByParameter:^(NSArray *dataArr, NSError *error) {
        if (!error) {
            self.model.BasicInfoArray = dataArr;
            [MBProgressHUD dismiss:self.navigationController];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        }else{
            [MBProgressHUD showWithErrorViewAddedTo:self.navigationController text:@"连接错误!" detailLabel:[NSString stringWithFormat:@"错误码%ld",(long)[error code]] delegate:nil duration:0.8 dimBackground:NO];
        }
    }];
    
    [self.refreshControl setRefreshingWithStateOfTask:task];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Home" image:nil tag:0];
    self.title = @"Home";
    self.model = [[TTModel alloc] init];
    
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.tableView.frame.size.width, 100.0f)];
    [self.refreshControl addTarget:self action:@selector(reload:) forControlEvents:UIControlEventValueChanged];
    [self.tableView.tableHeaderView addSubview:self.refreshControl];
    [self reload:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.model.BasicInfoArray count];
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
    
    cell.info = self.model.BasicInfoArray[(NSUInteger)indexPath.row];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(__unused UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TTInfoViewController* vc = [[TTInfoViewController alloc] init];
    TTCourses* courses = [[TTCourses alloc] initWithBasicInfo:self.model.BasicInfoArray[(NSUInteger)indexPath.row]];
    [vc setCourse:courses];
    [self.navigationController pushViewController:vc animated:YES];
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
