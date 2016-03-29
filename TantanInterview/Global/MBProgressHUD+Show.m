//
//  MBProgressHUD+Show.m
//  RedBag
//
//  Created by 公司 on 2/3/15.
//  Copyright (c) 2015 Bindx. All rights reserved.
//

#import "MBProgressHUD+Show.h"


@implementation MBProgressHUD (Show)

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)showWithCustomViewAddedTo:(UINavigationController *)navi text:(NSString *)text image:(NSString *)imageNamed delegate:(id)delegate duration:(NSTimeInterval)duration dimBackground:(BOOL)dim{
    MBProgressHUD * hud = [[MBProgressHUD alloc]init];
    [hud initWithView:navi text:text  detailLabel:nil imageNamed:imageNamed hudMode:MBProgressHUDModeCustomView showWhileExecuting:NO duration:duration delegate:delegate dimBackground:dim];
}

+ (void)showWithLoadingViewAddedTo:(UINavigationController *)navi text:(NSString *)text  detailLabel:(NSString *)detailsLabelText delegate:(id)delegate duration:(NSTimeInterval)duration dimBackground:(BOOL)dim{
    MBProgressHUD * hud = [[MBProgressHUD alloc]init];
    [hud initWithView:navi text:text  detailLabel:detailsLabelText imageNamed:nil hudMode:MBProgressHUDModeIndeterminate showWhileExecuting:NO duration:duration delegate:delegate dimBackground:dim];
}

+ (void)showWithErrorViewAddedTo:(UINavigationController *)navi text:(NSString *)text  detailLabel:(NSString *)detailsLabelText delegate:(id)delegate duration:(NSTimeInterval)duration dimBackground:(BOOL)dim{
    MBProgressHUD * hud = [[MBProgressHUD alloc]init];
    [hud initWithView:navi text:text  detailLabel:detailsLabelText imageNamed:@"37x-Failed" hudMode:MBProgressHUDModeCustomView showWhileExecuting:NO duration:duration delegate:delegate dimBackground:dim];
}

+ (void)showWithTextOnlyAddedTo:(UINavigationController *)navi text:(NSString *)text delegate:(id)delegate duration:(NSTimeInterval)duration dimBackground:(BOOL)dim{
    MBProgressHUD * hud = [[MBProgressHUD alloc]init];
    [hud initWithView:navi text:text  detailLabel:nil imageNamed:nil hudMode:MBProgressHUDModeText showWhileExecuting:NO duration:duration delegate:delegate dimBackground:dim];
}

- (void)initWithView:(UINavigationController *)navi text:(NSString *)text detailLabel:(NSString *)detailsLabelText imageNamed:(NSString *)imageNamed hudMode:(MBProgressHUDMode)mode showWhileExecuting:(BOOL)bl duration:(NSTimeInterval)duration delegate:(id)delegate dimBackground:(BOOL)dim{
        MBProgressHUD* HUD = [[MBProgressHUD alloc] initWithView:navi.view];
        [navi.view addSubview:HUD];
        if (imageNamed) {
            HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
        }
        HUD.mode = mode;
        HUD.dimBackground = dim;
        if (mode == MBProgressHUDModeText) {
            HUD.margin = 10.f;
            HUD.removeFromSuperViewOnHide = YES;
        }
    
        HUD.delegate = delegate;
        HUD.labelText = text;
    
        if (detailsLabelText) {
            HUD.detailsLabelText = detailsLabelText;
        }
    
    
        if (duration != 0) {
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:navi.view animated:YES];
            });

        }
    
        if (bl) {
            [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
        }
    [HUD show:YES];
}

+ (void)dismiss:(UINavigationController *)navi{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MBProgressHUD hideHUDForView:navi.view animated:YES];
    });

}

- (void)myProgressTask{
    
}

@end
