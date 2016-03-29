//
//  TTFavoritesModel.h
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTHomeModel;

@interface TTFavoritesModel : NSObject

@property(nonatomic,readonly,strong) NSMutableSet* myFavorites;

+(instancetype)sharedInstance;

-(void)insertOneCourse:(TTHomeModel*)course;
-(void)removeOneCourse:(TTHomeModel*)course;
-(BOOL)isCourseFavorite:(TTHomeModel*)course;
-(void)save;
+(TTFavoritesModel*)loadData;

@end
