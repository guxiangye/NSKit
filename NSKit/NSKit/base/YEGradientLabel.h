//
//  YEGradientLabel.h
//  ModaiTreasure
//
//  Created by 相晔谷 on 2016/11/1.
//  Copyright © 2016年 modai_sun. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 文字 渐变 label
 */
@interface YEGradientLabel : UIView

@property (nonatomic, assign) CGFloat tintWidth;

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray;

@end
