//
//  UIButton+NSManager.m
//  NSKitDemo
//
//  Created by 相晔谷 on 2017/1/23.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import "UIButton+NSManager.h"
#import <objc/runtime.h>
#import <UIView+WebCache.h>
#import <UIButton+WebCache.h>

#define SCELA_IMAGE_TITLE 5

@interface NSBtnViewModel ()

@property (nonatomic, strong) NSBtnViewModelItem *btn_title;
@property (nonatomic, strong) NSBtnViewModelItem *btn_textColor;
@property (nonatomic, strong) NSBtnViewModelItem *btn_textFont;
@property (nonatomic, strong) NSBtnViewModelItem *btn_imageView;
@property (nonatomic, strong) NSBtnViewModelItem *btn_bgImageView;
@property (nonatomic, strong) NSBtnViewModelItem *btn_hlightImageView;
@property (nonatomic, strong) NSBtnViewModelItem *btn_selectImageView;
@property (nonatomic, strong) NSBtnViewModelItem *btn_imageURL;
@property (nonatomic, strong) NSBtnViewModelItem *btn_targetAction;
@property (nonatomic, strong) NSBtnViewModelItem *btn_btnType;
@property (nonatomic, strong) NSBtnViewModelItem *btn_addOnView;

@end

@implementation NSBtnViewModel
@synthesize hlightImageView = _hlightImageView;
@synthesize selectImageView = _selectImageView;
@synthesize targetAction = _targetAction;
@synthesize bgImageView = _bgImageView;
@synthesize imageView = _imageView;
@synthesize imageURL = _imageURL;
@synthesize textColor = _textColor;
@synthesize addOnView = _addOnView;
@synthesize title = _title;
@synthesize textFont = _textFont;
@synthesize btnType = _btnType;

- (InitBtnViewSubManagar)title {
    
    if (!_title) {
        _title = [self initViewblockWithKey:@"btn_title"];
    }
    return _title;
}

- (InitBtnViewSubManagar)textColor {
    
    if (!_textColor) {
        _textColor = [self initViewblockWithKey:@"btn_textColor"];
    }
    return _textColor;
}

- (InitBtnViewSubManagar)textFont {
    
    if (!_textFont) {
        _textFont = [self initViewblockWithKey:@"btn_textFont"];
    }
    return _textFont;
}

- (InitBtnViewSubManagar)imageView {
    
    if (!_imageView) {
        _imageView = [self initViewblockWithKey:@"btn_imageView"];
    }
    return _imageView;
}

- (InitBtnViewSubManagar)bgImageView {
    
    if (!_bgImageView) {
        _bgImageView = [self initViewblockWithKey:@"btn_bgImageView"];
    }
    return _bgImageView;
}

- (InitBtnViewSubManagar)hlightImageView {
    
    if (!_hlightImageView) {
        _hlightImageView = [self initViewblockWithKey:@"btn_hlightImageView"];
    }
    return _hlightImageView;
}

- (InitBtnViewSubManagar)selectImageView {
    
    if (!_selectImageView) {
        _selectImageView = [self initViewblockWithKey:@"btn_selectImageView"];
    }
    return _selectImageView;
}

- (InitBtnViewSubManagar)imageURL {
    
    if (!_imageURL) {
        _imageURL = [self initViewblockWithKey:@"btn_imageURL"];
    }
    return _imageURL;
}

- (InitBtnViewSubManagar)addOnView {
    
    if (!_addOnView) {
        _addOnView = [self initViewblockWithKey:@"btn_addOnView"];
    }
    return _addOnView;
}

- (InitBtnViewSubManagar)btnType {
    
    if (!_btnType) {
        _btnType = [self initViewblockWithKey:@"btn_btnType"];
    }
    return _btnType;
}

- (InitBtnTargetManagar)targetAction {
    
    if (!_targetAction) {
        _targetAction = [self initTargetblockWithKey:@"btn_targetAction"];
    }
    return _targetAction;
}

- (InitBtnViewSubManagar)initViewblockWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(id value) {
        NSBtnViewModelItem *item = [NSBtnViewModelItem new];
        item.value = value;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

- (InitBtnTargetManagar)initTargetblockWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(id target, SEL action) {
        NSBtnViewModelItem *item = [NSBtnViewModelItem new];
        item.value = target;
        item.action = action;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

- (void)setBtn_title:(NSBtnViewModelItem *)btn_title {
    
    _btn_title = btn_title;
    __weak typeof(self) weakSelf = self;
    [weakSelf.needsInitView setTitle:btn_title.value forState:UIControlStateNormal];
}

- (void)setBtn_textColor:(NSBtnViewModelItem *)btn_textColor {
    
    _btn_textColor = btn_textColor;
    __weak typeof(self) weakSelf = self;
    [weakSelf.needsInitView setTitleColor:btn_textColor.value forState:UIControlStateNormal];
}

- (void)setBtn_textFont:(NSBtnViewModelItem *)btn_textFont {
    
    _btn_textColor = btn_textFont;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.titleLabel.font = btn_textFont.value;
}

- (void)setBtn_imageView:(NSBtnViewModelItem *)btn_imageView {
    
    _btn_imageView = btn_imageView;
    __weak typeof(self) weakSelf = self;
    [weakSelf.needsInitView setImage:[UIImage imageNamed:btn_imageView.value] forState:UIControlStateNormal];
}

- (void)setBtn_bgImageView:(NSBtnViewModelItem *)btn_bgImageView {
    
    _btn_bgImageView = btn_bgImageView;
    __weak typeof(self) weakSelf = self;
    [weakSelf.needsInitView setBackgroundImage:[UIImage imageNamed:btn_bgImageView.value] forState:UIControlStateNormal];
}

- (void)setBtn_hlightImageView:(NSBtnViewModelItem *)btn_hlightImageView {
    
    _btn_hlightImageView = btn_hlightImageView;
    __weak typeof(self) weakSelf = self;
    [weakSelf.needsInitView setImage:[UIImage imageNamed:btn_hlightImageView.value] forState:UIControlStateHighlighted];
}

- (void)setBtn_selectImageView:(NSBtnViewModelItem *)btn_selectImageView {
    
    _btn_selectImageView = btn_selectImageView;
    __weak typeof(self) weakSelf = self;
    [weakSelf.needsInitView setImage:[UIImage imageNamed:btn_selectImageView.value] forState:UIControlStateSelected];
}

- (void)setBtn_imageURL:(NSBtnViewModelItem *)btn_imageURL {
    
    _btn_imageURL = btn_imageURL;
    __weak typeof(self) weakSelf = self;
    UIImage *placeholderImage = nil;
    [self loadImageURL:btn_imageURL.value button:weakSelf.needsInitView placeholderImage:placeholderImage];
}

- (void)setBtn_addOnView:(NSBtnViewModelItem *)btn_addOnView {
    
    _btn_addOnView = btn_addOnView;
    __weak typeof(self) weakSelf = self;
    [btn_addOnView.value addSubview:weakSelf.needsInitView];
}

- (void)setBtn_targetAction:(NSBtnViewModelItem *)btn_targetAction {
    
    _btn_targetAction = btn_targetAction;
    __weak typeof(self) weakSelf = self;
    [weakSelf.needsInitView addTarget:btn_targetAction.value action:btn_targetAction.action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setBtn_btnType:(NSBtnViewModelItem *)btn_btnType {
    
    _btn_btnType = btn_btnType;
    __weak typeof(self) weakSelf = self;
    NSSButtonType btnType = [btn_btnType.value integerValue];
    weakSelf.needsInitView.btnType = btnType;
}

- (void)loadImageURL:(NSString *)imageString button:(UIButton *)btn placeholderImage:(UIImage *)placeholderImage {
    
    [btn sd_setShowActivityIndicatorView:YES];
    NSURL *imageURL = [[NSURL alloc] initWithString:imageString];
    [btn sd_setImageWithURL:imageURL forState:UIControlStateNormal placeholderImage:placeholderImage options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

@end


@implementation UIButton (NSManager)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSArray *selStringsArray = @[@"layoutSubviews"];
        
        [selStringsArray enumerateObjectsUsingBlock:^(NSString *selString, NSUInteger idx, BOOL *stop) {
            NSString *mySelString = [@"ns_" stringByAppendingString:selString];
            
            Method originalMethod = class_getInstanceMethod(self, NSSelectorFromString(selString));
            Method myMethod = class_getInstanceMethod(self, NSSelectorFromString(mySelString));
            method_exchangeImplementations(originalMethod, myMethod);
        }];
    });
}

- (NSSButtonType)btnType {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setBtnType:(NSSButtonType)btnType {
    objc_setAssociatedObject(self, @selector(btnType), @(btnType), OBJC_ASSOCIATION_ASSIGN);
}

- (NSBtnViewModel *)btnViewModel {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setBtnViewModel:(NSBtnViewModel *)btnViewModel {
    objc_setAssociatedObject(self, @selector(btnViewModel), btnViewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)ns_layoutSubviews {
    
    [self ns_layoutSubviews];
    
    NSSButtonType btnType = self.btnType;
    
    CGSize selfSize = self.frame.size;
    CGFloat selfWidth = selfSize.width;
    CGFloat selfHeight = selfSize.height;
    
    CGSize imgSize = self.imageView.image.size;
    CGFloat imgWidth = imgSize.width;
    CGFloat imgHeight = imgSize.height;
    
    CGSize titleSize = self.titleLabel.frame.size;
    CGFloat titleWidth = titleSize.width;
    CGFloat titleHeight = titleSize.height;
    
    if (btnType == NSSButtonTypeImageAndTitleOne) {
        // 左图 右文
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -SCELA_IMAGE_TITLE * 0.5)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, -SCELA_IMAGE_TITLE * 0.5, 0, 0)];
        
    }else if (btnType == NSSButtonTypeImageAndTitleTwo) {
        // 右图
        [self setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 0, imgWidth * 2 + SCELA_IMAGE_TITLE * 0.5)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, titleWidth * 2 + SCELA_IMAGE_TITLE * 0.5, 0, 0)];
        
    }else if (btnType == NSSButtonTypeImageAndTitleThree) {
        // 下文
        CGFloat titleLeft = (selfWidth + (imgWidth + titleWidth)) * 0.5;
        CGFloat titleCenterLeft = (selfWidth + titleWidth) * 0.5;
        
        CGFloat titleTop = (selfHeight - titleHeight) * 0.5;
        CGFloat titleCenterTop = (selfHeight - (imgHeight + titleHeight)) * 0.5 + imgHeight + SCELA_IMAGE_TITLE * 0.5;
        // 上图
        CGFloat imgLeft = (selfWidth - (imgWidth + titleWidth)) * 0.5;
        CGFloat imgCenterLeft = (selfWidth - imgWidth) * 0.5;
        
        CGFloat imgbottom = (selfHeight + imgHeight) * 0.5;
        CGFloat imgCenterbottom = titleCenterTop - SCELA_IMAGE_TITLE * 0.5 * 2;
        
        [self setTitleEdgeInsets:UIEdgeInsetsMake((titleCenterTop - titleTop)*2, 0, 0, (titleLeft - titleCenterLeft)*2)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, (imgCenterLeft - imgLeft)*2, (imgbottom - imgCenterbottom)*2, 0)];

    }else if (btnType == NSSButtonTypeImageAndTitleFour) {
        // 上文
        CGFloat titleLeft = (selfWidth + (imgWidth + titleWidth)) * 0.5;
        CGFloat titleCenterLeft = (selfWidth + titleWidth) * 0.5;
        
        CGFloat titleTop = (selfHeight - titleHeight) * 0.5;
        CGFloat titleCenterTop = (selfHeight - (imgHeight + titleHeight)) * 0.5 + imgHeight + SCELA_IMAGE_TITLE * 0.5;
        // 上图
        CGFloat imgLeft = (selfWidth - (imgWidth + titleWidth)) * 0.5;
        CGFloat imgCenterLeft = (selfWidth - imgWidth) * 0.5;
        
        CGFloat imgbottom = (selfHeight + imgHeight) * 0.5;
        CGFloat imgCenterbottom = titleCenterTop - SCELA_IMAGE_TITLE * 0.5 * 2;
        
        [self setTitleEdgeInsets:UIEdgeInsetsMake(-(titleCenterTop - titleTop)*2, 0, 0, (titleLeft - titleCenterLeft)*2)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(0, (imgCenterLeft - imgLeft)*2, -(imgbottom - imgCenterbottom)*2, 0)];
    }
    [self setContentMode:UIViewContentModeScaleAspectFit];
}

/**
 取消高亮状态
 
 @param highlighted highlighted description
 */
- (void)setHighlighted:(BOOL)highlighted {}

/**
 放大热力区
 
 @param point point description
 @param event event description
 
 @return return value description
 */
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

- (NSBtnViewModel *)ns_init {
    
    NSBtnViewModel *model = [self btnViewModel];
    if (!model) {
        model = [NSBtnViewModel new];
        model.needsInitView = self;
        self.exclusiveTouch = YES;
        [self setBtnViewModel:model];
    }
    return model;
}


@end


@implementation NSBtnViewModelItem

@end
