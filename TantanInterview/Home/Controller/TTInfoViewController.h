//
//  InfoViewController.h
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTCourses;

@interface TTInfoViewController : UITableViewController<UITextViewDelegate>

@property(nonatomic,strong) TTCourses* course;
@property(nonatomic,strong) NSArray* sourceArr;
@property(nonatomic,assign) CGRect cellViewFrame;

- (UIView*)makeCellByIndexPath:(NSIndexPath*)indexPatch;
- (void)switchAction:(id)sender;


@end
