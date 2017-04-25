//
//  UIViewController+NSManager.h
//  NSKit
//
//  Created by 相晔谷 on 2017/3/8.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NSManager)
/**
 是否自定义导航栏
 */
@property (nonatomic, assign) BOOL isCustomerNavBar;
@property (nonatomic, readonly) UIImageView *navigationBackGroudView;

#pragma mark - FullscreenPopGesture
/// Whether the interactive pop gesture is disabled when contained in a navigation
/// stack.
@property (nonatomic, assign) BOOL fd_interactivePopDisabled;

/// Indicate this view controller prefers its navigation bar hidden or not,
/// checked when view controller based navigation bar's appearance is enabled.
/// Default to NO, bars are more likely to show.
@property (nonatomic, assign) BOOL fd_prefersNavigationBarHidden;

/// Max allowed initial distance to left edge when you begin the interactive pop
/// gesture. 0 by default, which means it will ignore this limit.
@property (nonatomic, assign) CGFloat fd_interactivePopMaxAllowedInitialDistanceToLeftEdge;

#pragma mark - pop.
/**
 *  添加返回按钮，back
 */
-(void)addBackBtnWithTarget:(id)target action:(SEL)action;

/**
 *  灰色的返回按钮
 */
-(void)addGrayBackBtnWithTarget:(id)target action:(SEL)action;

/** 返回到之前*/
- (void)popBack;

/** 返回根视图*/
- (void)popBackToRoot;

- (void)popBackToViewController:(UIViewController *)vc;

#pragma mark - networkong.
/** 系统网络请求菊花-转*/
- (void)networkActivityPlay;

/** 系统网络请求菊花-停*/
- (void)networkActivityStop;

@end


@interface UINavigationController (FDFullscreenPopGesture)

/// The gesture recognizer that actually handles interactive pop.
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *fd_fullscreenPopGestureRecognizer;

/// A view controller is able to control navigation bar's appearance by itself,
/// rather than a global way, checking "fd_prefersNavigationBarHidden" property.
/// Default to YES, disable it if you don't want so.
@property (nonatomic, assign) BOOL fd_viewControllerBasedNavigationBarAppearanceEnabled;

@end
