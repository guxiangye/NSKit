//
//  UITextField+NSManager.m
//  NSKitDemo
//
//  Created by 相晔谷 on 2017/1/23.
//  strongright © 2017年 相晔谷. All rights reserved.
//

#import "UITextField+NSManager.h"
#import <objc/runtime.h>

@interface NSTextFieldModel()

@property (nonatomic, strong) NSTextFieldModelItem *textField_text;
@property (nonatomic, strong) NSTextFieldModelItem *textField_placeholder;
@property (nonatomic, strong) NSTextFieldModelItem *textField_textColor;
@property (nonatomic, strong) NSTextFieldModelItem *textField_textFont;
@property (nonatomic, strong) NSTextFieldModelItem *textField_textAlignment;
@property (nonatomic, strong) NSTextFieldModelItem *textField_returnKeyType;
@property (nonatomic, strong) NSTextFieldModelItem *textField_borderStyle;
@property (nonatomic, strong) NSTextFieldModelItem *textField_clearsOnBeginEditing;
@property (nonatomic, strong) NSTextFieldModelItem *textField_adjustsFontSizeToFitWidth;
@property (nonatomic, strong) NSTextFieldModelItem *textField_minimumFontSize;
@property (nonatomic, strong) NSTextFieldModelItem *textField_delegate;
@property (nonatomic, strong) NSTextFieldModelItem *textField_background;
@property (nonatomic, strong) NSTextFieldModelItem *textField_leftView;
@property (nonatomic, strong) NSTextFieldModelItem *textField_rightView;
@property (nonatomic, strong) NSTextFieldModelItem *textField_addOnView;
@property (nonatomic, strong) NSTextFieldModelItem *textField_textFieldType;
@property (nonatomic, strong) NSTextFieldModelItem *textField_keyboardType;
@property (nonatomic, strong) NSTextFieldModelItem *textField_clearButtonMode;

@end

@implementation NSTextFieldModel
@synthesize text = _text;
@synthesize placeholder = _placeholder;
@synthesize textColor = _textColor;
@synthesize textFont = _textFont;
@synthesize textAlignment = _textAlignment;
@synthesize returnKeyType = _returnKeyType;
@synthesize borderStyle = _borderStyle;
@synthesize clearsOnBeginEditing = _clearsOnBeginEditing;
@synthesize adjustsFontSizeToFitWidth = _adjustsFontSizeToFitWidth;
@synthesize minimumFontSize = _minimumFontSize;
@synthesize delegate = _delegate;
@synthesize background = _background;
@synthesize leftView = _leftView;
@synthesize rightView = _rightView;
@synthesize addOnView = _addOnView;
@synthesize textFieldType = _textFieldType;
@synthesize keyboardType = _keyboardType;
@synthesize clearButtonMode = _clearButtonMode;

- (InitTextFieldSubManagar)initViewblockWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(id value) {
        NSTextFieldModelItem *item = [NSTextFieldModelItem new];
        item.value = value;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

- (InitTextFieldSubManagar)text {
    if (!_text) {
        _text = [self initViewblockWithKey:@"textField_text"];
    }
    return _text;
}

- (InitTextFieldSubManagar)placeholder {
    if (!_placeholder) {
        _placeholder = [self initViewblockWithKey:@"textField_placeholder"];
    }
    return _placeholder;
}

- (InitTextFieldSubManagar)textColor {
    if (!_textColor) {
        _textColor = [self initViewblockWithKey:@"textField_textColor"];
    }
    return _textColor;
}

- (InitTextFieldSubManagar)textFont {
    if (!_textFont) {
        _textFont = [self initViewblockWithKey:@"textField_textFont"];
    }
    return _textFont;
}

- (InitTextFieldSubManagar)textAlignment {
    if (!_textAlignment) {
        _textAlignment = [self initViewblockWithKey:@"textField_textAlignment"];
    }
    return _textAlignment;
}

- (InitTextFieldSubManagar)returnKeyType {
    if (!_returnKeyType) {
        _returnKeyType = [self initViewblockWithKey:@"textField_returnKeyType"];
    }
    return _returnKeyType;
}

- (InitTextFieldSubManagar)borderStyle {
    if (!_borderStyle) {
        _borderStyle = [self initViewblockWithKey:@"textField_borderStyle"];
    }
    return _borderStyle;
}

- (InitTextFieldSubManagar)clearsOnBeginEditing {
    if (!_clearsOnBeginEditing) {
        _clearsOnBeginEditing = [self initViewblockWithKey:@"textField_clearsOnBeginEditing"];
    }
    return _clearsOnBeginEditing;
}

- (InitTextFieldSubManagar)adjustsFontSizeToFitWidth {
    if (!_adjustsFontSizeToFitWidth) {
        _adjustsFontSizeToFitWidth = [self initViewblockWithKey:@"textField_adjustsFontSizeToFitWidth"];
    }
    return _adjustsFontSizeToFitWidth;
}

- (InitTextFieldSubManagar)minimumFontSize {
    if (!_minimumFontSize) {
        _minimumFontSize = [self initViewblockWithKey:@"textField_minimumFontSize"];
    }
    return _minimumFontSize;
}

- (InitTextFieldSubManagar)delegate {
    if (!_delegate) {
        _delegate = [self initViewblockWithKey:@"textField_delegate"];
    }
    return _delegate;
}

- (InitTextFieldSubManagar)background {
    if (!_background) {
        _background = [self initViewblockWithKey:@"textField_background"];
    }
    return _background;
}

- (InitTextFieldSubManagar)leftView {
    if (!_leftView) {
        _leftView = [self initViewblockWithKey:@"textField_leftView"];
    }
    return _leftView;
}

- (InitTextFieldSubManagar)rightView {
    if (!_rightView) {
        _rightView = [self initViewblockWithKey:@"textField_rightView"];
    }
    return _rightView;
}

- (InitTextFieldSubManagar)addOnView {
    if (!_addOnView) {
        _addOnView = [self initViewblockWithKey:@"textField_addOnView"];
    }
    return _addOnView;
}

- (InitTextFieldSubManagar)textFieldType {
    if (!_textFieldType) {
        _textFieldType = [self initViewblockWithKey:@"textField_textFieldType"];
    }
    return _textFieldType;
}

- (InitTextFieldSubManagar)keyboardType {
    if (!_keyboardType) {
        _keyboardType = [self initViewblockWithKey:@"textField_keyboardType"];
    }
    return _keyboardType;
}

- (InitTextFieldSubManagar)clearButtonMode {
    if (!_clearButtonMode) {
        _clearButtonMode = [self initViewblockWithKey:@"textField_clearButtonMode"];
    }
    return _clearButtonMode;
}

- (void)setTextField_text:(NSTextFieldModelItem *)textField_text {
    _textField_text = textField_text;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.text = textField_text.value;
}

- (void)setTextField_placeholder:(NSTextFieldModelItem *)textField_placeholder {
    _textField_placeholder = textField_placeholder;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.placeholder = textField_placeholder.value;
}

- (void)setTextField_textColor:(NSTextFieldModelItem *)textField_textColor {
    _textField_textColor = textField_textColor;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.textColor = textField_textColor.value;
}

- (void)setTextField_textFont:(NSTextFieldModelItem *)textField_textFont {
    _textField_textFont = textField_textFont;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.font = textField_textFont.value;
}

- (void)setTextField_textAlignment:(NSTextFieldModelItem *)textField_textAlignment {
    _textField_textAlignment = textField_textAlignment;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.textAlignment = [textField_textAlignment.value integerValue];
}

- (void)setTextField_returnKeyType:(NSTextFieldModelItem *)textField_returnKeyType {
    _textField_returnKeyType = textField_returnKeyType;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.returnKeyType = [textField_returnKeyType.value integerValue];
}

- (void)setTextField_borderStyle:(NSTextFieldModelItem *)textField_borderStyle {
    _textField_borderStyle = textField_borderStyle;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.borderStyle = [textField_borderStyle.value integerValue];
}

- (void)setTextField_clearsOnBeginEditing:(NSTextFieldModelItem *)textField_clearsOnBeginEditing {
    _textField_clearsOnBeginEditing = textField_clearsOnBeginEditing;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.clearsOnBeginEditing = [textField_clearsOnBeginEditing.value boolValue];
}

- (void)setTextField_adjustsFontSizeToFitWidth:(NSTextFieldModelItem *)textField_adjustsFontSizeToFitWidth {
    _textField_adjustsFontSizeToFitWidth = textField_adjustsFontSizeToFitWidth;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.adjustsFontSizeToFitWidth = [textField_adjustsFontSizeToFitWidth.value boolValue];
}

- (void)setTextField_minimumFontSize:(NSTextFieldModelItem *)textField_minimumFontSize {
    _textField_minimumFontSize = textField_minimumFontSize;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.minimumFontSize = [textField_minimumFontSize.value doubleValue];
}

- (void)setTextField_delegate:(NSTextFieldModelItem *)textField_delegate {
    _textField_delegate = textField_delegate;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.delegate = textField_delegate.value;
}

- (void)setTextField_background:(NSTextFieldModelItem *)textField_background {
    _textField_background = textField_background;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.background = textField_background.value;
}

- (void)setTextField_leftView:(NSTextFieldModelItem *)textField_leftView {
    _textField_leftView = textField_leftView;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.leftView = textField_leftView.value;
    weakSelf.needsInitView.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setTextField_rightView:(NSTextFieldModelItem *)textField_rightView {
    _textField_rightView = textField_rightView;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.rightView = textField_rightView.value;
    weakSelf.needsInitView.rightViewMode = UITextFieldViewModeAlways;
}

- (void)setTextField_addOnView:(NSTextFieldModelItem *)textField_addOnView {
    _textField_addOnView = textField_addOnView;
    __weak typeof(self) weakSelf = self;
    [textField_addOnView.value addSubview:weakSelf.needsInitView];
}

- (void)setTextField_textFieldType:(NSTextFieldModelItem *)textField_textFieldType {
    _textField_textFieldType = textField_textFieldType;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.textFieldType = [textField_textFieldType.value integerValue];
}

- (void)setTextField_keyboardType:(NSTextFieldModelItem *)textField_keyboardType {
    _textField_keyboardType = textField_keyboardType;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.keyboardType = [textField_keyboardType.value integerValue];
}

- (void)setTextField_clearButtonMode:(NSTextFieldModelItem *)textField_clearButtonMode {
    _textField_clearButtonMode = textField_clearButtonMode;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.clearButtonMode = [textField_clearButtonMode.value integerValue];
}

@end

@implementation NSTextFieldModelItem

@end

@implementation UITextField (NSManager)


- (NSTextFieldModel *)textFieldModel {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTextFieldModel:(NSTextFieldModel *)textFieldModel {
    objc_setAssociatedObject(self, @selector(textFieldModel), textFieldModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSSTextFieldType)textFieldType{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setTextFieldType:(NSSTextFieldType)textFieldType{
    objc_setAssociatedObject(self, @selector(textFieldType), @(textFieldType), OBJC_ASSOCIATION_ASSIGN);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userNameChange:) name:UITextFieldTextDidChangeNotification object:nil];
}

- (NSTextFieldModel *)ns_init {
    NSTextFieldModel *model = [self textFieldModel];
    if (!model) {
        model = [NSTextFieldModel new];
        model.needsInitView = self;
        [self setTextFieldModel:model];
    }
    return model;
}

- (void)userNameChange:(NSNotification *)notifi {
    
    NSSTextFieldType textFieldType = self.textFieldType;
    if (NSSTextFieldTypeDefault == textFieldType) {
        return;
    }else if (NSSTextFieldTypePhoneNumber == textFieldType) {
        NSMutableString *telphoneNum = [NSMutableString stringWithString:self.text];
        NSArray *array = [telphoneNum componentsSeparatedByString:@" "];
        telphoneNum = [NSMutableString stringWithString:[array componentsJoinedByString:@""]];
        
        NSInteger length = telphoneNum.length;
        if (length>0 && (![telphoneNum hasPrefix:@"+"])) {
            telphoneNum = [NSMutableString stringWithFormat:@"+86%@",telphoneNum];
        }
        length = telphoneNum.length;
        
        if (length>3) {
            [telphoneNum insertString:@" " atIndex:3];
            length++;
        }
        if (length>7) {
            [telphoneNum insertString:@" " atIndex:7];
            length++;
        }
        if (length>12) {
            [telphoneNum insertString:@" " atIndex:12];
            length++;
        }
        self.text = telphoneNum;
        if (self.text.length>17) {
            self.text = [telphoneNum substringToIndex:17];
        }
    }else if(NSSTextFieldTypeIDCard == textFieldType){
        NSMutableString *bankcardNum = [NSMutableString stringWithString:self.text];
        NSArray *array = [bankcardNum componentsSeparatedByString:@" "];
        bankcardNum = [NSMutableString stringWithString:[array componentsJoinedByString:@""]];
        
        NSInteger length = bankcardNum.length;
        if (length>4) {
            [bankcardNum insertString:@" " atIndex:4];
            length++;
        }
        if (length>9) {
            [bankcardNum insertString:@" " atIndex:9];
            length++;
        }
        if (length>14) {
            [bankcardNum insertString:@" " atIndex:14];
            length++;
        }
        if (length>19) {
            [bankcardNum insertString:@" " atIndex:19];
            length++;
        }
        self.text = bankcardNum;
        if (self.text.length>22) {
            self.text = [bankcardNum substringToIndex:22];
        }
    }else if (textFieldType == NSSTextFieldTypeNickname) {
        NSMutableString *nickName = [NSMutableString stringWithString:self.text];
        if (self.text.length>10) {
            self.text = [nickName substringToIndex:10];
        }
    }else if(textFieldType == NSSTextFieldTypeBankCard){
        NSMutableString *bankcardNum = [NSMutableString stringWithString:self.text];
        NSArray *array = [bankcardNum componentsSeparatedByString:@" "];
        bankcardNum = [NSMutableString stringWithString:[array componentsJoinedByString:@""]];
        
        NSInteger length = bankcardNum.length;
        if (length>4) {
            [bankcardNum insertString:@" " atIndex:4];
            length++;
        }
        if (length>9) {
            [bankcardNum insertString:@" " atIndex:9];
            length++;
        }
        if (length>14) {
            [bankcardNum insertString:@" " atIndex:14];
            length++;
        }
        if (length>19) {
            [bankcardNum insertString:@" " atIndex:19];
            length++;
        }
        self.text = bankcardNum;
        if (self.text.length>23) {
            self.text = [bankcardNum substringToIndex:23];
        }
    }else if(textFieldType == NSSTextFieldTypeFloatNumber){
        
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//- (CGRect)leftViewRectForBounds:(CGRect)bounds {
//    CGRect iconRect = [self leftViewRectForBounds:bounds];
//    iconRect.origin.x += 15.f;
//    iconRect.origin.y -= 1;
//    return iconRect;
//}
//- (CGRect)textRectForBounds:(CGRect)bounds {
//    CGRect textRect = [self textRectForBounds:bounds];
//    textRect.origin.x += 15.f+1;
//    return textRect;
//}
//- (CGRect)editingRectForBounds:(CGRect)bounds {
//    CGRect textRect = [self editingRectForBounds:bounds];
//    textRect.origin.x += 15.f;
//    return textRect;
//}

@end
