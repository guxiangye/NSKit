//
//  UIViewController+NSManager.m
//  NSKit
//
//  Created by 相晔谷 on 2017/3/8.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import "UIViewController+NSManager.h"
#import "UIButton+NSManager.h"
#import <objc/runtime.h>
#import "Aspects.h"

#define __kScreenWidth           [UIScreen mainScreen].bounds.size.width
#define __kScreenHeight          [UIScreen mainScreen].bounds.size.height
#define YERGB(r,g,b)             [UIColor colorWithRed:(float)r green:(float)g blue:(float)b alpha:1]
#define __kNavigationViewWidth   64.0f
#define __kTabBarBackViewHeigth  49.0f

static const float NSBackBtnImageToLeftLength = 15.0f;
static const float NSBackBtnImageToUpLength   = 10.0f;
static const float NSBackBtnImageToDownLength = 10.0f;

@implementation UIViewController (NSManager)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(ns_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)ns_viewWillAppear:(BOOL)animated {
    
    [self ns_viewWillAppear:animated];
    
    if (self.isCustomerNavBar) {
        self.view.backgroundColor = [UIColor whiteColor];
        self.fd_prefersNavigationBarHidden = YES;
        self.view.accessibilityElementsHidden = YES;
        
        if (!self.navigationBackGroudView) {
            self.navigationBackGroudView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __kScreenWidth, __kNavigationViewWidth)];
            self.navigationBackGroudView.backgroundColor = YERGB(2.49f, 2.49f, 2.49f);
            self.navigationBackGroudView.image = [UIImage imageNamed:@"navigationBackImgView"];
            [self.view addSubview:self.navigationBackGroudView];
            
            self.navigationBackGroudView.userInteractionEnabled = YES;
        }
    }
}

- (UIImageView *)navigationBackGroudView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setNavigationBackGroudView:(UIImageView *)navigationBackGroudView {
    objc_setAssociatedObject(self, @selector(navigationBackGroudView), navigationBackGroudView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isCustomerNavBar {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsCustomerNavBar:(BOOL)isCustomerNavBar {
    objc_setAssociatedObject(self, @selector(isCustomerNavBar), @(isCustomerNavBar), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    
}

- (BOOL)fd_interactivePopDisabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFd_interactivePopDisabled:(BOOL)disabled {
    objc_setAssociatedObject(self, @selector(fd_interactivePopDisabled), @(disabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)fd_prefersNavigationBarHidden {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFd_prefersNavigationBarHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, @selector(fd_prefersNavigationBarHidden), @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)fd_interactivePopMaxAllowedInitialDistanceToLeftEdge {
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}

- (void)setFd_interactivePopMaxAllowedInitialDistanceToLeftEdge:(CGFloat)distance {
    SEL key = @selector(fd_interactivePopMaxAllowedInitialDistanceToLeftEdge);
    objc_setAssociatedObject(self, key, @(MAX(0, distance)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - pop

/**
 *  添加返回按钮，back
 *
 *  @param target 对象
 *  @param action 方法
 */
- (void)addBackBtnWithTarget:(id)target action:(SEL)action {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(NSBackBtnImageToLeftLength, NSBackBtnImageToUpLength + 20.0f, 15, __kNavigationViewWidth - NSBackBtnImageToDownLength - NSBackBtnImageToUpLength - 20.0f);
    backBtn.ns_init
    .imageView(@"zttop-fh")
    .targetAction(target, action)
    .addOnView(self.navigationBackGroudView);
}

- (void)addGrayBackBtnWithTarget:(id)target action:(SEL)action {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(NSBackBtnImageToLeftLength, NSBackBtnImageToUpLength + 20.0f, 15, __kNavigationViewWidth - NSBackBtnImageToDownLength - NSBackBtnImageToUpLength - 20.0f);
    backBtn.ns_init
    .imageView(@"top-fh")
    .targetAction(target, action)
    .addOnView(self.navigationBackGroudView);
    
    [self.navigationBackGroudView bringSubviewToFront:backBtn];
}

- (void)popBack {
    
    if ([self.navigationController canPerformAction:@selector(popViewControllerAnimated:) withSender:NULL]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)popBackToRoot {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popBackToViewController:(UIViewController *)vc {
    [self.navigationController popToViewController:vc animated:YES];
}

#pragma mark - 网络请求状态栏动画

- (void)networkActivityPlay {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)networkActivityStop {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end


@interface _FDFullscreenPopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UINavigationController *navigationController;
@end

@implementation _FDFullscreenPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    // Ignore when no view controller is pushed into the navigation stack.
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    
    // Ignore when the active view controller doesn't allow interactive pop.
    UIViewController *topViewController = self.navigationController.viewControllers.lastObject;
    if (topViewController.fd_interactivePopDisabled) {
        return NO;
    }
    
    // Ignore when the beginning location is beyond max allowed initial distance to left edge.
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = topViewController.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge;
    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
        return NO;
    }
    
    // Ignore pan gesture when the navigation controller is currently in transition.
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    // Prevent calling the handler when the gesture begins in an opposite direction.
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return YES;
}

@end


typedef void (^_FDViewControllerWillAppearInjectBlock)(UIViewController *viewController, BOOL animated);

@interface UIViewController (FDFullscreenPopGesturePrivate)
@property (nonatomic, copy) _FDViewControllerWillAppearInjectBlock fd_willAppearInjectBlock;
@end

@implementation UIViewController (FDFullscreenPopGesturePrivate)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewWillAppear:);
        SEL swizzledSelector = @selector(fd_viewWillAppear:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)fd_viewWillAppear:(BOOL)animated
{
    // Forward to primary implementation.
    [self fd_viewWillAppear:animated];
    
    if (self.fd_willAppearInjectBlock) {
        self.fd_willAppearInjectBlock(self, animated);
    }
}

- (_FDViewControllerWillAppearInjectBlock)fd_willAppearInjectBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setFd_willAppearInjectBlock:(_FDViewControllerWillAppearInjectBlock)block
{
    objc_setAssociatedObject(self, @selector(fd_willAppearInjectBlock), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end


@implementation UINavigationController (FDFullscreenPopGesture)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(pushViewController:animated:);
        SEL swizzledSelector = @selector(fd_pushViewController:animated:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        }else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)fd_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.fd_fullscreenPopGestureRecognizer]) {
        
        // Add our own gesture recognizer to where the onboard screen edge pan gesture recognizer is attached to.
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.fd_fullscreenPopGestureRecognizer];
        
        // Forward the gesture events to the private handler of the onboard gesture recognizer.
        NSArray *internalTargets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [internalTargets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        self.fd_fullscreenPopGestureRecognizer.delegate = self.fd_popGestureRecognizerDelegate;
        [self.fd_fullscreenPopGestureRecognizer addTarget:internalTarget action:internalAction];
        
        // Disable the onboard gesture recognizer.
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    // Handle perferred navigation bar appearance.
    [self fd_setupViewControllerBasedNavigationBarAppearanceIfNeeded:viewController];
    
    if (![self.viewControllers containsObject:viewController]) {
        [self fd_pushViewController:viewController animated:animated];
    }
}

- (void)fd_setupViewControllerBasedNavigationBarAppearanceIfNeeded:(UIViewController *)appearingViewController
{
    if (!self.fd_viewControllerBasedNavigationBarAppearanceEnabled) {
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    _FDViewControllerWillAppearInjectBlock block = ^(UIViewController *viewController, BOOL animated) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf setNavigationBarHidden:viewController.fd_prefersNavigationBarHidden animated:animated];
        }
    };
    
    // Setup will appear inject block to appearing view controller.
    // Setup disappearing view controller as well, because not every view controller is added into
    // stack by pushing, maybe by "-setViewControllers:".
    appearingViewController.fd_willAppearInjectBlock = block;
    UIViewController *disappearingViewController = self.viewControllers.lastObject;
    if (disappearingViewController && !disappearingViewController.fd_willAppearInjectBlock) {
        disappearingViewController.fd_willAppearInjectBlock = block;
    }
}

- (_FDFullscreenPopGestureRecognizerDelegate *)fd_popGestureRecognizerDelegate
{
    _FDFullscreenPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    
    if (!delegate) {
        delegate = [[_FDFullscreenPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

- (UIPanGestureRecognizer *)fd_fullscreenPopGestureRecognizer
{
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    
    if (!panGestureRecognizer) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}

- (BOOL)fd_viewControllerBasedNavigationBarAppearanceEnabled
{
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (number) {
        return number.boolValue;
    }
    self.fd_viewControllerBasedNavigationBarAppearanceEnabled = YES;
    return YES;
}

- (void)setFd_viewControllerBasedNavigationBarAppearanceEnabled:(BOOL)enabled
{
    SEL key = @selector(fd_viewControllerBasedNavigationBarAppearanceEnabled);
    objc_setAssociatedObject(self, key, @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

