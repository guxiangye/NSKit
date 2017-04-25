//
//  UILabel+NSManager.h
//  NSKitDemo
//
//  Created by 相晔谷 on 2017/1/23.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSLabelViewModel, NSLabelViewModelItem, NSAttributedLabelViewModel;

typedef NSLabelViewModel *(^InitLabelViewSubManagar)(id value);
typedef NSLabelViewModel *(^InitAttributedLabelViewSubManagar)(NSString *cutStr, id value);

@interface NSLabelViewModel : NSObject
/**
 文本
 */
@property (nonatomic, copy, readonly) InitLabelViewSubManagar title;
/**
 文本颜色
 */
@property (nonatomic, copy, readonly) InitLabelViewSubManagar textColor;
/**
 字体
 */
@property (nonatomic, copy, readonly) InitLabelViewSubManagar textFont;
/**
 对其方式
 */
@property (nonatomic, copy, readonly) InitLabelViewSubManagar textAlignment;
/**
 行数
 */
@property (nonatomic, copy, readonly) InitLabelViewSubManagar lineNumber;
/**
 添加到父视图
 */
@property (nonatomic, copy, readonly) InitLabelViewSubManagar addOnView;

@property (nonatomic, weak) UILabel *needsInitView;
/**
 attr 属性 必须写在 设置文体下面
 */
@property (nonatomic, copy, readonly) InitAttributedLabelViewSubManagar attributed;

@end



@interface UILabel (NSManager)

@property (nonatomic, strong, readonly) NSLabelViewModel *labelViewModel;

- (NSLabelViewModel *)ns_init;

@end


@interface NSLabelViewModelItem : NSObject

@property (nonatomic, strong) NSString *type;

@property (nonatomic, strong) id value;

@property (nonatomic, strong) NSString *cutStr;

@end
