//
//  TTCourses.m
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import "TTCourses.h"

@implementation TTCourses

-(instancetype)initWithDictionary:(NSDictionary *)dict BasicInfo:(TTHomeModel*)basic{
    self = [super init];
    if (self && dict) {
        self.BasicInfo = basic;
        self.Instructors = [dict valueForKey:@"instructors"];
        self.Partners = [dict valueForKey:@"partners"];
    }
    return self;
}

-(instancetype)initWithBasicInfo:(TTHomeModel *)basic{
    self = [super init];
    if (self && basic) {
        self.BasicInfo = basic;
        self.Instructors = nil;
        self.Partners = nil;
        
    }
    return self;
}

@end
