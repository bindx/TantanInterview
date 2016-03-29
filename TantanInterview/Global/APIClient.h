//
//  AFAppDotNetAPIClient.h
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

static NSString* const HomeUrlString = @"https://api.coursera.org/api/courses.v1";

@interface APIClient : AFHTTPSessionManager

+ (instancetype)sharedClient;

@end
