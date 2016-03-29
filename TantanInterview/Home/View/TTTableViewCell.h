//
//  TTTableViewCell.h
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TTHomeModel;

@interface TTTableViewCell : UITableViewCell

//图片地址
@property(nonatomic,weak) IBOutlet UIImageView* iconImage;
//标题
@property(nonatomic,weak) IBOutlet UILabel* nameLabel;
//分类
@property(nonatomic,weak) IBOutlet UILabel* slugLabel;

@property(nonatomic,strong) TTHomeModel* info;

@end