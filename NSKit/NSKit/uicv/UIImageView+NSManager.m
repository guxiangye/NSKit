//
//  UIImageView+NSManager.m
//  NSKitDemo
//
//  Created by 相晔谷 on 2017/3/1.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import "UIImageView+NSManager.h"
#import <UIImageView+WebCache.h>
#import <UIView+WebCache.h>
#import <objc/runtime.h>

@interface NSImageViewModel()

@property (nonatomic, strong) id imageView_image;
@property (nonatomic, strong) id imageView_highlightedImage;
@property (nonatomic, strong) id imageView_imageURL;
@property (nonatomic, strong) id imageView_contentMode;
@property (nonatomic, strong) id imageView_failureReload;
@property (nonatomic, strong) id imageView_addOnView;

@end

@implementation NSImageViewModel
@synthesize image = _image;
@synthesize highlightedImage = _highlightedImage;
@synthesize imageURL = _imageURL;
@synthesize contentMode = _contentMode;
@synthesize failureReload = _failureReload;
@synthesize addOnView = _addOnView;

- (InitImageViewSubManagar)initViewblockWithKey:(NSString *)key
{
    __weak typeof(self) weakSelf = self;
    return ^(id value) {
        id item = value;
        [weakSelf setValue:item forKey:key];
        return weakSelf;
    };
}

- (InitImageViewSubManagar)image {
    if (!_image) {
        _image = [self initViewblockWithKey:@"imageView_image"];
    }
    return _image;
}

- (InitImageViewSubManagar)highlightedImage {
    if (!_highlightedImage) {
        _highlightedImage = [self initViewblockWithKey:@"imageView_highlightedImage"];
    }
    return _highlightedImage;
}

- (InitImageViewSubManagar)imageURL {
    if (!_imageURL) {
        _imageURL = [self initViewblockWithKey:@"imageView_imageURL"];
    }
    return _imageURL;
}

- (InitImageViewSubManagar)contentMode {
    if (!_contentMode) {
        _contentMode = [self initViewblockWithKey:@"imageView_contentMode"];
    }
    return _contentMode;
}

- (InitImageViewSubManagar)failureReload {
    if (!_failureReload) {
        _failureReload = [self initViewblockWithKey:@"imageView_failureReload"];
    }
    return _failureReload;
}

- (InitImageViewSubManagar)addOnView {
    if (!_addOnView) {
        _addOnView = [self initViewblockWithKey:@"imageView_addOnView"];
    }
    return _addOnView;
}

- (void)setImageView_image:(id)imageView_image {
    _imageView_image = imageView_image;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.image = imageView_image;
}

- (void)setImageView_highlightedImage:(id)imageView_highlightedImage {
    _imageView_highlightedImage = imageView_highlightedImage;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.highlightedImage = imageView_highlightedImage;
}

- (void)setImageView_imageURL:(id)imageView_imageURL {
    _imageView_imageURL = imageView_imageURL;
    __weak typeof(self) weakSelf = self;
    UIImage *placeholderImage = nil;
    [self loadImageURL:imageView_imageURL imageView:weakSelf.needsInitView placeholderImage:placeholderImage];
}

- (void)setImageView_contentMode:(id)imageView_contentMode {
    _imageView_contentMode = imageView_contentMode;
    __weak typeof(self) weakSelf = self;
    weakSelf.needsInitView.contentMode = [imageView_contentMode integerValue];
}

- (void)setImageView_failureReload:(id)imageView_failureReload {
    _imageView_failureReload = imageView_failureReload;
    __weak typeof(self) weakSelf = self;
    
    UITapGestureRecognizer *tap;
    if ([imageView_failureReload boolValue]) {
        weakSelf.needsInitView.userInteractionEnabled = YES;
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(failureReload:)];
        [weakSelf.needsInitView addGestureRecognizer:tap];
    }else {
        if (tap) {
            [weakSelf.needsInitView removeGestureRecognizer:tap];
        }
    }
}

- (void)setImageView_addOnView:(id)imageView_addOnView {
    _imageView_addOnView = imageView_addOnView;
    __weak typeof(self) weakSelf = self;
    [imageView_addOnView addSubview:weakSelf.needsInitView];
}

- (void)loadImageURL:(NSString *)imageString imageView:(UIImageView *)imageView placeholderImage:(UIImage *)placeholderImage {
    
    [imageView sd_setShowActivityIndicatorView:YES];
    NSURL *imageURL = [[NSURL alloc] initWithString:imageString];
    [imageView sd_setImageWithPreviousCachedImageWithURL:imageURL placeholderImage:placeholderImage options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
}

- (void)failureReload:(UITapGestureRecognizer *)tap {
    UIImageView *imageView = (UIImageView *)tap.view;
    [self loadImageURL:self.imageView_imageURL imageView:imageView placeholderImage:nil];
}

@end


@implementation UIImageView (NSManager)

- (NSImageViewModel *)imageViewModel {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setImageViewModel:(NSImageViewModel *)imageViewModel {
    objc_setAssociatedObject(self, @selector(imageViewModel), imageViewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSImageViewModel *)ns_init {
    NSImageViewModel *model = [self imageViewModel];
    if (!model) {
        model = [NSImageViewModel new];
        model.needsInitView = self;
        [self setImageViewModel:model];
    }
    return model;
}

@end
