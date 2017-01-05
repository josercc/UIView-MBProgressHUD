//
//  UIView+MBProgressHUD.m
//  CustomHUD
//
//  Created by 张行 on 16/6/11.
//  Copyright © 2016年 张行. All rights reserved.
//

#import "UIView+MBProgressHUD.h"
#import <objc/runtime.h>
@implementation UIView (MBProgressHUD)

- (void)showHUDDefaultLoadingText {
    [self showHUDText:@"Loading..."];
}

- (void)showHUDText:(NSString *)text {
    [self showHUDText:text mode:MBProgressHUDModeIndeterminate];
}

- (void)showHUDText:(NSString *)text afterDealy:(NSTimeInterval)afterDealy{
    [self showHUDText:text mode:MBProgressHUDModeText afterDealy:afterDealy];
}

- (void)showHUDTextAfterDealy:(NSString *)text {
    [self showHUDText:text mode:MBProgressHUDModeText afterDealy:2.0f];
}

- (void)showHUDText:(NSString *)text mode:(MBProgressHUDMode)mode {
    [self showHUDText:text mode:mode afterDealy:0];
}

- (void)showHUDText:(NSString *)text mode:(MBProgressHUDMode)mode afterDealy:(NSTimeInterval)afterDealy {
    if (self.isLoadingHUD) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
    hud.mode = mode;
    hud.color = [UIColor colorWithWhite:0 alpha:0.8];
    if (afterDealy > 0) {
        hud.detailsLabelText = text;
    } else {
        hud.labelText = text;
    }
    
    objc_setAssociatedObject(self, "MBProgressHUD", hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (afterDealy > 0 && mode == MBProgressHUDModeText) {
        [hud hide:YES afterDelay:afterDealy];
    }
}

- (void)hideHUD {
    [self hideHUDTextAfterDealy:nil];
}

- (void)hideHUDTextAfterDealy:(NSString *)text {
    [self hideHUDText:text afterDealy:2.0];
}

- (void)hideHUDText:(NSString *)text afterDealy:(NSTimeInterval )afterDealy {
    if (!self.isLoadingHUD) {
        return;
    }
    MBProgressHUD *hud = objc_getAssociatedObject(self, "MBProgressHUD");
    if (!text) {
        [hud hide:YES];
    }else {
        hud.labelText = nil;
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = text;
        hud.labelFont = [UIFont systemFontOfSize:13];
        [hud hide:YES afterDelay:afterDealy];
    }
}

#pragma mark - get

- (BOOL)isLoadingHUD {
    MBProgressHUD *hud = objc_getAssociatedObject(self, "MBProgressHUD");
    return hud.superview?YES:NO;;
}


@end
