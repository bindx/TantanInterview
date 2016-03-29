//
//  InfoViewController.m
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import "TTInfoViewController.h"
#import "TTCourses.h"
#import "TTModel.h"
#import "TTFavoritesModel.h"
#import "UIKit+AFNetworking.h"
#import "MBProgressHUD+Show.h"

@interface TTInfoViewController ()

@end

@implementation TTInfoViewController

- (void)setCourse:(TTCourses *)course{
    _course = course;
    self.sourceArr = [[NSArray alloc] initWithObjects:@"Description",@"Like it", nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Course";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    CGSize winsize = [UIScreen mainScreen].bounds.size;
    self.cellViewFrame = CGRectMake(10, 10, winsize.width - 20, 100);
    
    [TTModel getCoursesById:self.course.BasicInfo.Id Block:^(NSDictionary *dict, NSError *error) {
        if (!error) {
            self.course.Instructors = [dict valueForKey:@"instructors.v1"];
            self.course.Partners = [dict valueForKey:@"partners.v1"];
            NSMutableArray* mutableArr = [NSMutableArray arrayWithArray:self.sourceArr];
            [mutableArr addObject:@"Instructors"];
            [mutableArr addObject:@"Partners"];
            self.sourceArr = [NSArray arrayWithArray:mutableArr];
            [self.tableView reloadData];
        }else{
           [MBProgressHUD showWithErrorViewAddedTo:self.navigationController text:@"连接错误!" detailLabel:[NSString stringWithFormat:@"错误码%ld",(long)[error code]] delegate:nil duration:0.8 dimBackground:NO];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sourceArr count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.sourceArr objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* reuseId = @"reuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    
    [cell.contentView addSubview:[self makeCellByIndexPath:indexPath]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20+self.cellViewFrame.size.height;
}


- (UIView *)makeCellByIndexPath:(NSIndexPath *)indexPatch{
    UIView* view;
    if (indexPatch.section == 0 && indexPatch.row == 0) { //description view
        UITextView* textVeiw = [[UITextView alloc] initWithFrame:self.cellViewFrame];
        textVeiw.text = self.course.BasicInfo.Description;
        textVeiw.editable = false;
        textVeiw.delegate = self;
        view = textVeiw;
    } else if (indexPatch.section == 1 && indexPatch.row == 0){ //switch view
        view = [[UIView alloc] initWithFrame:self.cellViewFrame];
        UISwitch* switchBtn = [[UISwitch alloc] init];
        CGRect btnFrame = switchBtn.frame;
        switchBtn.frame = CGRectMake(self.cellViewFrame.size.width/2 - 20, self.cellViewFrame.size.height/2 - 10,btnFrame.size.width,btnFrame.size.height);
        switchBtn.on = [[TTFavoritesModel sharedInstance] isCourseFavorite:self.course.BasicInfo];
        [switchBtn addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [view addSubview:switchBtn];
        view.backgroundColor = [UIColor whiteColor];
    } else if (indexPatch.section == 2 && indexPatch.row == 0){ //Instructor view
        NSArray* insArr = self.course.Instructors;
        NSUInteger insCount = [insArr count];
        if (!insArr || insCount == 0) {
            return nil;
        }
        
        //scrollview
        CGSize cellViewSize = self.cellViewFrame.size;
        UIScrollView* scrollview = [[UIScrollView alloc] initWithFrame:self.cellViewFrame];
        CGFloat contentWidth = cellViewSize.width;
        if (insCount > 2) {
            contentWidth = insCount*(cellViewSize.width/2);
        }
        scrollview.contentSize = CGSizeMake(contentWidth, cellViewSize.height);
        
        //Instructor view
        CGFloat insViewWidth = cellViewSize.width/2;
        CGFloat insAvatarWidth = 55;
        CGFloat nameLabelWidth = 100;
        
        for (int i = 0; i < insCount; i++) {
            NSDictionary* dict = [insArr objectAtIndex:i];
            UIView* insView = [[UIView alloc] initWithFrame:CGRectMake(insViewWidth*i, 0, insViewWidth, cellViewSize.height)];
            
            UIImageView* avatar = [[UIImageView alloc] initWithFrame:CGRectMake((insViewWidth - insAvatarWidth)/2, 10, insAvatarWidth, insAvatarWidth)];
            [insView addSubview:avatar];
            [avatar setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"photo"]]];
            avatar.layer.cornerRadius = insAvatarWidth/2;
            avatar.layer.masksToBounds = YES;
            avatar.backgroundColor = [UIColor blueColor];
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((insViewWidth - nameLabelWidth)/2, 65, nameLabelWidth, 20)];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            [scrollview addSubview:nameLabel];
            nameLabel.font = [UIFont fontWithName:@"Arial" size:10.0f];
            nameLabel.text = [dict objectForKey:@"fullName"];
            nameLabel.numberOfLines = 2;
            
            [insView addSubview:nameLabel];
            [scrollview addSubview:insView];
        }
        view = scrollview;
    } else if(indexPatch.section == 3 && indexPatch.row == 0){
        view = [[UIView alloc] initWithFrame:self.cellViewFrame];
        
        
        NSMutableString* university = [NSMutableString stringWithString:@"University:"];
        NSString* workLoad = [@"WorkLoad:" stringByAppendingString:self.course.BasicInfo.WorkLoad];
        NSString* language = [@"Language:" stringByAppendingString:[self.course.BasicInfo.PrimaryLanguages componentsJoinedByString:@","]];
        
        NSArray* partnersArr = self.course.Partners;
        for (int i = 0; i < [partnersArr count]; i++) {
            NSDictionary* dict = [partnersArr objectAtIndex:i];
            [university appendString:[dict objectForKey:@"shortName"]];
        }
        
        
        NSArray* arr = [NSArray arrayWithObjects:workLoad,language,university, nil];
        CGFloat labelWidth = self.cellViewFrame.size.width*0.8;
        CGFloat labelHeight = 20;
        for (int i = 0; i < [arr count]; i++) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10+28*i, labelWidth, labelHeight)];
            [view addSubview:label];
            label.adjustsFontSizeToFitWidth = YES;
            label.text = [arr objectAtIndex:i];
        }
    }
    return view;
}

- (void)switchAction:(id)sender{
    UISwitch* switchBtn = (UISwitch*)sender;
    if (!switchBtn.on) {
        [[TTFavoritesModel sharedInstance] removeOneCourse:self.course.BasicInfo];
    }else{
        [[TTFavoritesModel sharedInstance] insertOneCourse:self.course.BasicInfo];
    }
}

@end
