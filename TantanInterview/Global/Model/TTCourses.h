//
//  TTCourses.h
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTHomeModel.h"

@interface TTCourses : NSObject

@property(nonatomic,strong) TTHomeModel* BasicInfo;
@property(nonatomic,strong) NSArray* Instructors;
@property(nonatomic,strong) NSArray* Partners;


-(instancetype)initWithDictionary:(NSDictionary*)dict BasicInfo:(TTHomeModel *)basic;
-(instancetype)initWithBasicInfo:(TTHomeModel*)basic;

@end
