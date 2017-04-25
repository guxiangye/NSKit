//
//  UIView+YEExtension.h
//  NSKitDemo
//
//  Created by 相晔谷 on 2017/1/23.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(YEExtension)

@property (assign, nonatomic) CGFloat YEOriginX;
@property (assign, nonatomic) CGFloat YEOriginY;
@property (assign, nonatomic) CGFloat YEWidth;
@property (assign, nonatomic) CGFloat YEHeight;
@property (assign, nonatomic) CGSize  YESize;
@property (assign, nonatomic) CGPoint YEOrigin;
@property (assign, nonatomic, readonly) CGFloat YERightX;
@property (assign, nonatomic) CGFloat YEBottomY;


@property (nonatomic) CGFloat YELeft;
@property (nonatomic) CGFloat YETop;
@property (nonatomic) CGFloat YERight;
@property (nonatomic) CGFloat YEBottom;
@property (nonatomic) CGFloat YECenterX;
@property (nonatomic) CGFloat YECenterY;

// 特殊用途
@property (nonatomic, strong) NSIndexPath *YEIndexPath;

@property (nonatomic, strong, readonly) UINavigationController *YENavigationController;
@property (nonatomic, strong, readonly) UIViewController *YEViewController;

- (void)removeAllSubviews;

@end
