//
//  UITextField+NSManager.h
//  NSKitDemo
//
//  Created by 相晔谷 on 2017/1/23.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSTextFieldModel, NSTextFieldModelItem;

typedef NS_ENUM(NSInteger, NSSTextFieldType) {
    /***  默认*/
    NSSTextFieldTypeDefault     = 0,
    /***  电话*/
    NSSTextFieldTypePhoneNumber = 1,
    /***  银行卡*/
    NSSTextFieldTypeBankCard    = 2,
    /***  昵称*/
    NSSTextFieldTypeNickname    = 3,
    /***  ID Card*/
    NSSTextFieldTypeIDCard      = 4,
    /***  数字,及两位小数*/
    NSSTextFieldTypeFloatNumber = 5
};

typedef NSTextFieldModel *(^InitTextFieldSubManagar)(id value);


@interface NSTextFieldModel : NSObject
/**
 输入的文本
 */
@property (nonatomic, copy, readonly) InitTextFieldSubManagar text;
/**
 默认文字
 */
@property (nonatomic, copy, readonly) InitTextFieldSubManagar placeholder;
/**
 文本颜色
 */
@property (nonatomic, copy, readonly) InitTextFieldSubManagar textColor;
/**
 字体
 */
@property (nonatomic, copy, readonly) InitTextFieldSubManagar textFont;
/**
 对其方式
 */
@property (nonatomic, copy, readonly) InitTextFieldSubManagar textAlignment;
/**
 键盘按钮文字
 */
@property (nonatomic, copy, readonly) InitTextFieldSubManagar returnKeyType;
/**
 边框
 */
@property (nonatomic, copy, readonly) InitTextFieldSubManagar borderStyle;
/**
 其他属性..
 */
@property (nonatomic, copy, readonly) InitTextFieldSubManagar clearsOnBeginEditing;
@property (nonatomic, copy, readonly) InitTextFieldSubManagar adjustsFontSizeToFitWidth;
@property (nonatomic, copy, readonly) InitTextFieldSubManagar minimumFontSize;
@property (nonatomic, copy, readonly) InitTextFieldSubManagar delegate;
@property (nonatomic, copy, readonly) InitTextFieldSubManagar background;
@property (nonatomic, copy, readonly) InitTextFieldSubManagar keyboardType;
@property (nonatomic, copy, readonly) InitTextFieldSubManagar clearButtonMode;
/**
 左视图
 */
@property (nonatomic, copy, readonly) InitTextFieldSubManagar leftView;
/**
 右视图
 */
@property (nonatomic, copy, readonly) InitTextFieldSubManagar rightView;
/**
 添加到父视图
 */
@property (nonatomic, copy, readonly) InitTextFieldSubManagar addOnView;
/**
 类型 见:NSTextFieldType
 */
@property (nonatomic, copy, readonly) InitTextFieldSubManagar textFieldType;

@property (nonatomic, weak) UITextField *needsInitView;

@end


@interface NSTextFieldModelItem : NSObject

@property (nonatomic, strong) id value;

@end


@interface UITextField (NSManager)

@property (nonatomic, strong, readonly) NSTextFieldModel *textFieldModel;

@property (nonatomic, assign) NSSTextFieldType textFieldType;

- (NSTextFieldModel *)ns_init;

@end
