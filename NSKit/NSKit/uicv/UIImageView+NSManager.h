//
//  UIImageView+NSManager.h
//  NSKitDemo
//
//  Created by 相晔谷 on 2017/3/1.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSImageViewModel;

typedef NSImageViewModel *(^InitImageViewSubManagar)(id value);

@interface NSImageViewModel : NSObject
/**
 本地图片名
 */
@property (nonatomic, copy, readonly) InitImageViewSubManagar image;
/**
 高亮本地图片名
 */
@property (nonatomic, copy, readonly) InitImageViewSubManagar highlightedImage;
/**
 网络图片地址
 */
@property (nonatomic, copy, readonly) InitImageViewSubManagar imageURL;
/**
 显示模式
 */
@property (nonatomic, copy, readonly) InitImageViewSubManagar contentMode;
/**
 添加到父视图
 */
@property (nonatomic, copy, readonly) InitImageViewSubManagar addOnView;
/**
 是否开启图片加载失败后重新加载
 */
@property (nonatomic, copy, readonly) InitImageViewSubManagar failureReload;

@property (nonatomic, weak) UIImageView *needsInitView;

@end


@interface UIImageView(NSManager)

@property (nonatomic, strong, readonly) NSImageViewModel *imageViewModel;

- (NSImageViewModel *)ns_init;


@end
