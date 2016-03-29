//
//  TTHomeModel.h
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTHomeModel : NSObject<NSCoding>

@property(nonatomic,strong) NSString* Id;
@property(nonatomic,strong) NSString* Name;
@property(nonatomic,strong) NSString* Slug;
@property(nonatomic,strong) NSString* CourseType;
@property(nonatomic,strong) NSURL* PhotoUrl;
@property(nonatomic,strong) NSString* WorkLoad;
@property(nonatomic,strong) NSString* Description;
@property(nonatomic,strong) NSString* PreviewLink;
@property(nonatomic,strong) NSArray* PrimaryLanguages;
@property(nonatomic,strong) NSArray* Categories;

-(instancetype)initWithDictionary:(NSDictionary*)dict;

@end
