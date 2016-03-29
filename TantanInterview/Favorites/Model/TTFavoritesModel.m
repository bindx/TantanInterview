//
//  TTFavoritesModel.m
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import "TTFavoritesModel.h"
#import "TTModel.h"
#import "TTHomeModel.h"

@implementation TTFavoritesModel

-(instancetype)init{
    self = [super init];
    if (self) {
        _myFavorites = [[NSMutableSet alloc] initWithCapacity:0];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.myFavorites forKey:@"Favorites"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        _myFavorites = [aDecoder decodeObjectForKey:@"Favorites"];
    }
    return self;
}

-(void)insertOneCourse:(TTHomeModel *)course{
    if (course && ![self.myFavorites containsObject:course]) {
        [self.myFavorites addObject:course];
        [self save];
    }
}

-(void)removeOneCourse:(TTHomeModel *)course{
    if (course && [self.myFavorites count]) {
        for(id obj in self.myFavorites){
            TTHomeModel* info = obj;
            if ([info.Id isEqualToString:course.Id]) {
                [self.myFavorites removeObject:obj];
                break;
            }
        }
        [self save];
    }
}

-(BOOL)isCourseFavorite:(TTHomeModel *)course{
    BOOL pRet = NO;
    if (course && [self.myFavorites count]) {
        for(id obj in self.myFavorites){
            TTHomeModel* info = obj;
            if ([info.Id isEqualToString:course.Id]) {
                pRet = YES;
                break;
            }
        }
    }
    return pRet;
}

-(void)save{
    NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    NSString* docName = [docPath stringByAppendingString:@"Favorites.data"];
    [NSKeyedArchiver archiveRootObject:self toFile:docName];
}

+(TTFavoritesModel*)loadData{
    NSString* docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject];
    NSString* docName = [docPath stringByAppendingString:@"Favorites.data"];
    TTFavoritesModel* cf = (TTFavoritesModel*)[NSKeyedUnarchiver unarchiveObjectWithFile:docName];
    return cf;
}

+(instancetype)sharedInstance{
    static TTFavoritesModel* pRet = nil;
    
    if (pRet) {
        return pRet;
    }
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        pRet = [TTFavoritesModel loadData];
        if (!pRet) {
            pRet = [[TTFavoritesModel alloc] init];
        }
    });
    
    
    return pRet;
}
@end
