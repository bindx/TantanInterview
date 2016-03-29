//
//  MBProgressHUD+Show.h
//  RedBag
//
//  Created by 公司 on 2/3/15.
//  Copyright (c) 2015 Bindx. All rights reserved.
//

#import "MBProgressHUD.h"
#import <unistd.h>


@interface  MBProgressHUD (Show) <MBProgressHUDDelegate>


+ (void)showWithCustomViewAddedTo:(UINavigationController *)navi text:(NSString *)text image:(NSString *)imageNamed delegate:(id)delegate duration:(NSTimeInterval)duration dimBackground:(BOOL)dim;

+ (void)showWithTextOnlyAddedTo:(UINavigationController *)navi text:(NSString *)text delegate:(id)delegate duration:(NSTimeInterval)duration dimBackground:(BOOL)dim;

+ (void)showWithLoadingViewAddedTo:(UINavigationController *)navi text:(NSString *)text  detailLabel:(NSString *)detailsLabelText delegate:(id)delegate duration:(NSTimeInterval)duration dimBackground:(BOOL)dim;


+ (void)showWithErrorViewAddedTo:(UINavigationController *)navi text:(NSString *)text  detailLabel:(NSString *)detailsLabelText delegate:(id)delegate duration:(NSTimeInterval)duration dimBackground:(BOOL)dim;

+ (void)dismiss:(UINavigationController *)navi;

@end
