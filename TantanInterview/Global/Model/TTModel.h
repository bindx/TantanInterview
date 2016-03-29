//
//  TTModel.h
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTModel : NSObject


@property(nonatomic,copy,readwrite) NSArray* BasicInfoArray;

//通过参数获取首页列表
+ (NSURLSessionDataTask *)getListByParameter:(void (^)(NSArray *dataArr, NSError *error))block;
//通过编号查询
+ (NSURLSessionDataTask *)getCoursesById:(NSString*)courseId Block:(void (^)(NSDictionary* dict, NSError* error))block;

@end