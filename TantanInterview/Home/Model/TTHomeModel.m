//
//  TTHomeModel.m
//  TantanInterview
//
//  Created by Bindx on 3/29/16.
//  Copyright © 2016 Bindx. All rights reserved.
//

#import "TTHomeModel.h"

@implementation TTHomeModel

static NSString* idKey = @"id";
static NSString* nameKey = @"name";
static NSString* slugKey = @"slug";
static NSString* courseTypeKey = @"courseType";
static NSString* photoUrlKey = @"photoUrl";
static NSString* workloadKey = @"workload";
static NSString* descriptionKey = @"description";
static NSString* previewLinkKey = @"previewLink";
static NSString* primaryLanguagesKey = @"primaryLanguages";
static NSString* categoriesKey = @"categories";

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    self = [super init];
    if (self && dict) {
        self.Id = [dict valueForKey:idKey];
        self.Name = [dict valueForKey:nameKey];
        self.Slug = [dict valueForKey:slugKey];
        self.CourseType = [dict valueForKey:courseTypeKey];
        self.PhotoUrl =[NSURL URLWithString:[dict valueForKey:photoUrlKey]];
        self.WorkLoad = [dict valueForKey:workloadKey];
        self.Description = [dict valueForKey:descriptionKey];
        self.PreviewLink = [dict valueForKey:previewLinkKey];
        self.PrimaryLanguages = [dict valueForKey:primaryLanguagesKey];
        self.Categories = [dict valueForKey:categoriesKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.Id forKey:idKey];
    [aCoder encodeObject:self.Name forKey:nameKey];
    [aCoder encodeObject:self.Slug forKey:slugKey];
    [aCoder encodeObject:self.CourseType forKey:courseTypeKey];
    [aCoder encodeObject:self.PhotoUrl forKey:photoUrlKey];
    [aCoder encodeObject:self.WorkLoad forKey:workloadKey];
    [aCoder encodeObject:self.Description forKey:descriptionKey];
    [aCoder encodeObject:self.PreviewLink forKey:previewLinkKey];
    [aCoder encodeObject:self.PrimaryLanguages forKey:primaryLanguagesKey];
    [aCoder encodeObject:self.Categories forKey:categoriesKey];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.Id = [aDecoder decodeObjectForKey:idKey];
        self.Name = [aDecoder decodeObjectForKey:nameKey];
        self.Slug = [aDecoder decodeObjectForKey:slugKey];
        self.CourseType = [aDecoder decodeObjectForKey:courseTypeKey];
        self.PhotoUrl = [aDecoder decodeObjectForKey:photoUrlKey];
        self.WorkLoad = [aDecoder decodeObjectForKey:workloadKey];
        self.Description = [aDecoder decodeObjectForKey:descriptionKey];
        self.PreviewLink = [aDecoder decodeObjectForKey:previewLinkKey];
        self.PrimaryLanguages = [aDecoder decodeObjectForKey:primaryLanguagesKey];
        self.Categories = [aDecoder decodeObjectForKey:categoriesKey];
    }
    return self;
}


@end
