//
//  UIView+YEExtension.m
//  NSKitDemo
//
//  Created by 相晔谷 on 2017/1/23.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import "UIView+YEExtension.h"
#import <objc/runtime.h>

@implementation UIView(YEExtension)

- (void)setYEOriginX:(CGFloat)YEOriginX {
    CGRect frame = self.frame;
    frame.origin.x = YEOriginX;
    self.frame = frame;
}

- (CGFloat)YEOriginX {
    return self.frame.origin.x;
}

- (void)setYEOriginY:(CGFloat)YEOriginY {
    CGRect frame = self.frame;
    frame.origin.y = YEOriginY;
    self.frame = frame;
}

- (CGFloat)YEOriginY {
    return self.frame.origin.y;
}

- (void)setYEWidth:(CGFloat)YEWidth {
    CGRect frame = self.frame;
    frame.size.width = YEWidth;
    self.frame = frame;
}

- (CGFloat)YEWidth {
    return self.frame.size.width;
}

- (void)setYEHeight:(CGFloat)YEHeight {
    CGRect frame = self.frame;
    frame.size.height = YEHeight;
    self.frame = frame;
}

- (CGFloat)YEHeight {
    return self.frame.size.height;
}

- (void)setYESize:(CGSize)YESize {
    CGRect frame = self.frame;
    frame.size = YESize;
    self.frame = frame;
}

- (CGSize)YESize {
    return self.frame.size;
}

- (void)setYEOrigin:(CGPoint)YEOrigin {
    CGRect frame = self.frame;
    frame.origin = YEOrigin;
    self.frame = frame;
}

- (CGPoint)YEOrigin {
    return self.frame.origin;
}

- (CGFloat)YERightX {
    return self.YEOriginX + self.YEWidth;
}

- (void)setYEBottomY:(CGFloat)YEBottomY {
    CGRect frame = self.frame;
    frame.origin.y = YEBottomY - self.YEHeight;
    self.frame = frame;
}

- (CGFloat)YEBottomY {
    return self.YEOriginY + self.YEHeight;
}



- (CGFloat)YELeft {
    return self.frame.origin.x;
}

- (void)setYELeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)YETop {
    return self.frame.origin.y;
}

- (void)setYETop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)YERight {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setYERight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)YEBottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setYEBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


- (CGFloat)YECenterX
{
    return self.YELeft + self.YEWidth * 0.5;
}

- (void)setYECenterX:(CGFloat)centerX
{
    self.YELeft = centerX - self.YEWidth * 0.5;
}

- (CGFloat)YECenterY
{
    return self.YETop + self.YEHeight * 0.5;
}

- (void)setYECenterY:(CGFloat)centerY
{
    self.YETop = centerY - self.YEHeight * 0.5;
}

// 获取当前屏幕显示的viewcontroller
- (UIViewController *)findBestViewController:(UIViewController *)vc {
    if (vc.presentedViewController) {
        
        return [self findBestViewController:vc.presentedViewController];
    } else if ([vc isKindOfClass:[UISplitViewController class]]) {
        
        UISplitViewController *svc = (UISplitViewController *)vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.viewControllers.lastObject];
        else
            return vc;
    } else if ([vc isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController *svc = (UINavigationController *)vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.topViewController];
        else
            return vc;
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController *svc = (UITabBarController *) vc;
        if (svc.viewControllers.count > 0)
            return [self findBestViewController:svc.selectedViewController];
        else
            return vc;
    } else {
        
        return vc;
    }
}

- (UIViewController *) currentViewController {
    
    UIViewController *viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self findBestViewController:viewController];
}

- (UINavigationController *)YENavigationController {
    
    return [self currentViewController].navigationController;
}

- (UIViewController *)YEViewController {
    
    return [self currentViewController];
}

- (void)removeAllSubviews {
    
    while (self.subviews.count)
    {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}


- (NSIndexPath *)YEIndexPath {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setYEIndexPath:(NSIndexPath *)YEIndexPath {
    objc_setAssociatedObject(self, @selector(YEIndexPath), YEIndexPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
