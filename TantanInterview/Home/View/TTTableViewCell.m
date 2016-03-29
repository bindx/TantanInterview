//
//  TTTableViewCell.m
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import "TTTableViewCell.h"
#import "TTHomeModel.h"
#import <UIKit+AFNetworking.h>

@implementation TTTableViewCell

- (void)setInfo:(TTHomeModel *)info{
    self.nameLabel.text = info.Name;
    self.slugLabel.text = info.Slug;
    [self.iconImage setImageWithURL:info.PhotoUrl placeholderImage:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
