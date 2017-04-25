//
//  UIButton+NSManager.h
//  NSKitDemo
//
//  Created by 相晔谷 on 2017/1/23.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSBtnViewModel, NSBtnViewModelItem;

typedef NS_ENUM(NSInteger, NSSButtonType) {
    /***  默认 左图右文字*/
    NSSButtonTypeImageAndTitleOne   = 0,
    /***  右图左文字*/
    NSSButtonTypeImageAndTitleTwo   = 1,
    /***  上图下文字*/
    NSSButtonTypeImageAndTitleThree = 2,
    /***  下图上文字*/
    NSSButtonTypeImageAndTitleFour  = 4
};

typedef NSBtnViewModel *(^InitBtnViewSubManagar)(id value);
typedef NSBtnViewModel *(^InitBtnTargetManagar)(id target, SEL action);

@interface NSBtnViewModel : NSObject

/**
 文本
 */
@property (nonatomic, copy, readonly) InitBtnViewSubManagar title;
/**
 文本颜色
 */
@property (nonatomic, copy, readonly) InitBtnViewSubManagar textColor;
/**
 字体
 */
@property (nonatomic, copy, readonly) InitBtnViewSubManagar textFont;
/**
 图片
 */
@property (nonatomic, copy, readonly) InitBtnViewSubManagar imageView;
@property (nonatomic, copy, readonly) InitBtnViewSubManagar bgImageView;
@property (nonatomic, copy, readonly) InitBtnViewSubManagar hlightImageView;
@property (nonatomic, copy, readonly) InitBtnViewSubManagar selectImageView;
/**
 网络图片地址
 */
@property (nonatomic, copy, readonly) InitBtnViewSubManagar imageURL;
/**
 响应对象
 */
@property (nonatomic, copy, readonly) InitBtnTargetManagar targetAction;

/**
 添加到父视图
 */
@property (nonatomic, copy, readonly) InitBtnViewSubManagar addOnView;
/**
 类型 见:NSSButtonType
 */
@property (nonatomic, copy, readonly) InitBtnViewSubManagar btnType;

@property (nonatomic, weak) UIButton *needsInitView;

@end



@interface UIButton (NSManager)

@property (nonatomic, strong, readonly) NSBtnViewModel *btnViewModel;

@property (nonatomic, assign) NSSButtonType btnType;

- (NSBtnViewModel *)ns_init;

@end


@interface NSBtnViewModelItem : NSObject

@property (nonatomic, strong) id value;
@property (nonatomic, assign) SEL action;

@end
