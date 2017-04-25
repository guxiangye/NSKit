//
//  UILabel+NSManager.m
//  NSKitDemo
//
//  Created by 相晔谷 on 2017/1/23.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import "UILabel+NSManager.h"
#import <objc/runtime.h>

@interface NSLabelViewModel ()

@property (nonatomic, strong) NSLabelViewModelItem *label_title;
@property (nonatomic, strong) NSLabelViewModelItem *label_textColor;
@property (nonatomic, strong) NSLabelViewModelItem *label_textFont;
@property (nonatomic, strong) NSLabelViewModelItem *label_addOnView;
@property (nonatomic, strong) NSLabelViewModelItem *label_textAlignment;
@property (nonatomic, strong) NSLabelViewModelItem *label_lineNumber;

@property (nonatomic, strong) NSLabelViewModelItem *label_attributed;

@end

@implementation NSLabelViewModel
@synthesize textAlignment = _textAlignment;
@synthesize textColor = _textColor;
@synthesize addOnView = _addOnView;
@synthesize textFont = _textFont;
@synthesize lineNumber = _lineNumber;
@synthesize title = _title;

@synthesize attributed = _attributed;

- (InitLabelViewSubManagar)title {
    
    if (!_title) {
        _title = [self initViewblockWithKey:@"label_title"];
    }
    return _title;
}

- (InitLabelViewSubManagar)textColor {
    
    if (!_textColor) {
        _textColor = [self initViewblockWithKey:@"label_textColor"];
    }
    return _textColor;
}

- (InitLabelViewSubManagar)textFont {
    
    if (!_textFont) {
        _textFont = [self initViewblockWithKey:@"label_textFont"];
    }
    return _textFont;
}

- (InitLabelViewSubManagar)textAlignment {
    
    if (!_textAlignment) {
        _textAlignment = [self initViewblockWithKey:@"label_textAlignment"];
    }
    return _textAlignment;
}

- (InitLabelViewSubManagar)lineNumber {
    
    if (!_lineNumber) {
        _lineNumber = [self initViewblockWithKey:@"label_lineNumber"];
    }
    return _lineNumber;
}

- (InitLabelViewSubManagar)addOnView {
    
    if (!_addOnView) {
        _addOnView = [self initViewblockWithKey:@"label_addOnView"];
    }
    return _addOnView;
}

- (InitAttributedLabelViewSubManagar)attributed {
    
    if (!_attributed) {
        _attributed = [self initAttritedViewblockWithKey:@"label_attributed"];
    }
    return _attributed;
}

- (InitLabelViewSubManagar)initViewblockWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(id value) {
        NSLabelViewModelItem *item = [NSLabelViewModelItem new];
        item.value = value;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

- (InitAttributedLabelViewSubManagar)initAttritedViewblockWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(NSString *cutStr, id value) {
        
        NSLabelViewModelItem *item = [NSLabelViewModelItem new];
        item.cutStr = cutStr;
        item.value = value;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

- (void)setLabel_title:(NSLabelViewModelItem *)label_title {
    
    _label_title = label_title;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.text = label_title.value;
}

- (void)setLabel_textColor:(NSLabelViewModelItem *)label_textColor {
    
    _label_textColor = label_textColor;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.textColor = label_textColor.value;
}

- (void)setLabel_textFont:(NSLabelViewModelItem *)label_textFont {
    
    _label_textColor = label_textFont;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.font = label_textFont.value;
}

- (void)setLabel_lineNumber:(NSLabelViewModelItem *)label_lineNumber {
    
    _label_lineNumber = label_lineNumber;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.numberOfLines = [label_lineNumber.value integerValue];
}

- (void)setLabel_textAlignment:(NSLabelViewModelItem *)label_textAlignment {
    
    _label_textAlignment = label_textAlignment;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.textAlignment = [label_textAlignment.value integerValue];
}

- (void)setLabel_addOnView:(NSLabelViewModelItem *)label_addOnView {
    
    _label_addOnView = label_addOnView;
    __weak typeof(self) weakSelf = self;
    [label_addOnView.value addSubview:weakSelf.needsInitView];
}

- (void)setLabel_attributed:(NSLabelViewModelItem *)label_attributed {
    
    _label_attributed = label_attributed;
    __weak typeof(self) weakSelf = self;
    
    NSMutableAttributedString *attriString;
    if (weakSelf.needsInitView.attributedText) {
        attriString = [[NSMutableAttributedString alloc] initWithAttributedString:weakSelf.needsInitView.attributedText];
    }else {
        attriString = [[NSMutableAttributedString alloc] initWithString:weakSelf.needsInitView.text];
    }
    
    if ([weakSelf.needsInitView.text containsString:label_attributed.cutStr]) {
        [attriString addAttributes:label_attributed.value range:[weakSelf.needsInitView.text rangeOfString:label_attributed.cutStr]];
        weakSelf.needsInitView.attributedText = attriString;
    }
}

@end

@implementation UILabel (NSManager)

- (NSLabelViewModel *)labelViewModel {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLabelViewModel:(NSLabelViewModel *)labelViewModel {
    objc_setAssociatedObject(self, @selector(labelViewModel), labelViewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSLabelViewModel *)ns_init {
    
    NSLabelViewModel *model = [self labelViewModel];
    if (!model) {
        model = [NSLabelViewModel new];
        model.needsInitView = self;
        [self setLabelViewModel:model];
    }
    return model;
}


@end


@implementation NSLabelViewModelItem

@end





