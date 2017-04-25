//
//  UIImage+NSManager.h
//  NSKitDemo
//
//  Created by 相晔谷 on 2017/3/7.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(NSManager)

/**
 图片压缩

 @param newSize 输入压缩 size
 @return return value description
 */
- (UIImage *)imageWithScaledToSize:(CGSize)newSize;

- (NSData *)dataFromImageCompression;

/**
 *  灰话图片
 *
 *  @return return value description
 */
- (UIImage *)grayImage;

@end
