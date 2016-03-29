//
//  TTModel.m
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import "TTModel.h"
#import "TTHomeModel.h"
#import "APIClient.h"


@implementation TTModel

+ (NSURLSessionDataTask *)getListByParameter:(void (^)(NSArray *dataArr, NSError *error))block {
    return [[APIClient sharedClient] GET:@"?fields=photoUrl,workload,description,previewLink,primaryLanguages,categories" parameters:nil progress:nil success:^(NSURLSessionDataTask * __unused task, id JSON) {
        NSArray *postsFromResponse = [JSON valueForKeyPath:@"elements"];
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithCapacity:[postsFromResponse count]];
        for (NSDictionary *attributes in postsFromResponse) {
            TTHomeModel* info = [[TTHomeModel alloc] initWithDictionary:attributes];
            [mutablePosts addObject:info];
        }
        if (block) {
            block([NSArray arrayWithArray:mutablePosts], nil);
        }
    } failure:^(NSURLSessionDataTask *__unused task, NSError *error) {
        if (block) {
            block([NSArray array], error);
        }
    }];
}

+ (NSURLSessionDataTask*)getCoursesById:(NSString *)courseId Block:(void (^)(NSDictionary *dict, NSError *error))block{
    NSString* url = [NSString stringWithFormat:@"%@?includes=partnerIds,instructorIds&fields=instructors.v1(fullName,photo)",courseId];
    return [[APIClient sharedClient] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask* __unused task,id JSON){
        NSDictionary* postsFromRespnose = [JSON valueForKeyPath:@"linked"];
        
        if (block) {
            block(postsFromRespnose,nil);
        }
        
    } failure:^(NSURLSessionDataTask* __unused task, NSError* error){
        if (block) {
            block([NSDictionary dictionary],error);
        }
    }
            ];
}

@end
