//
//  YECustomMJHeader.m
//  NSKit
//
//  Created by 相晔谷 on 2017/4/6.
//  Copyright © 2017年 相晔谷. All rights reserved.
//

#import "YECustomMJHeader.h"
#import "NSKit.h"
#import "LPRefreshIndicator.h"

///下拉到此偏移量开始拉伸
const CGFloat YEBeganStretchOffset = 35.f;
///下拉到此偏移量开始刷新
const CGFloat YEBeganRefreshOffset = 85.f;
static NSString *KEY_PATH = @"contentOffset";

@interface YECustomMJHeader ()
@property (assign, nonatomic) CGFloat insetTDelta;
@property (nonatomic, strong) LPRefreshIndicator *indicator;
@end

@implementation YECustomMJHeader

#pragma mark - 懒加载.

- (LPRefreshIndicator *)indicator {
    
    if (!_indicator) {
        [self addSubview:_indicator = [LPRefreshIndicator new]];
        CGRect frame = self.indicator.frame;
        frame.origin.x = 0;
        frame.origin.y = 0;
        self.indicator.frame = frame;
        
        [self addObserver:self
               forKeyPath:KEY_PATH
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    }
    return _indicator;
}

- (void)setFrame:(CGRect)frame
{
    if (self.frame.size.width != frame.size.width) {
        [self centerSub:frame.size.width];
    }
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds
{
    if (self.bounds.size.width != bounds.size.width) {
        [self centerSub:bounds.size.width];
    }
    [super setBounds:bounds];
}

- (void)centerSub:(CGFloat)width
{
    CGRect frame = self.indicator.frame;
    frame.size.width = width;
    frame.origin.x = (width - frame.size.width) / 2.l;
    self.indicator.frame = frame;
}

#pragma mark - 覆盖父类的方法
- (void)prepare {
    [super prepare];
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 设置key
    self.lastUpdatedTimeKey = MJRefreshHeaderLastUpdatedTimeKey;
    
    // 设置高度
    self.mj_h = YEBeganStretchOffset;
    
    self.indicator.pullProgress = YEBeganStretchOffset;
}

- (void)placeSubviews {
    [super placeSubviews];
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState

//    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%ld", state);
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        
//        if (oldState != MJRefreshStateRefreshing) return;
        
        // 恢复inset和offset
        [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
//            self.scrollView.mj_insetT += self.insetTDelta;
            
            // 自动调整透明度
            if (self.isAutomaticallyChangeAlpha) self.alpha = 0.0;
            self.scrollView.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            self.pullingPercent = 0.0;
            self.indicator.pullProgress = 0.0;
            if (self.endRefreshingCompletionBlock) {
                self.endRefreshingCompletionBlock();
            }
        }];
    } else if (state == MJRefreshStatePulling) {
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            
        }];
    } else if (state == MJRefreshStateRefreshing) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                
                CGRect frame = self.frame;
                frame.origin.y = -YEBeganStretchOffset;
                frame.size.height = YEBeganStretchOffset;
                self.frame = frame;
                
                CGFloat top = self.mj_h;
                // 增加滚动区域top
                self.scrollView.mj_insetT = 0;
                // 设置滚动位置
                [self.scrollView setContentOffset:CGPointMake(0, -top) animated:NO];
            } completion:^(BOOL finished) {
                [self executeRefreshingCallback];
            }];
        });
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    
    [super scrollViewContentOffsetDidChange:change];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:KEY_PATH]) {
//        YEAFNAppLog(@"%.2lf | %ld", self.scrollView.contentOffset.y, self.state);
        // 在刷新的refreshing状态
        if (self.scrollView.decelerating && self.state == MJRefreshStateIdle) {
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                // 1.问题一
//                self.indicator.pullProgress = 0;
            } completion:^(BOOL finished) {
                
            }];
        }
        if (self.scrollView.decelerating && self.state == MJRefreshStatePulling) {
            self.indicator.pullProgress = YEBeganRefreshOffset;
            self.state = MJRefreshStateRefreshing;
            return;
        }
        
        CGFloat contentY = 0.f;
        contentY = -self.scrollView.contentOffset.y;
        
        if (contentY<=YEBeganStretchOffset) {
            CGRect frame = self.frame;
            frame.origin.y = -YEBeganStretchOffset;
            frame.size.height = YEBeganStretchOffset;
            self.frame = frame;
        }else {
            CGRect frame = self.frame;
            frame.origin.y = -contentY;
            frame.size.height = contentY;
            self.frame = frame;
        }
        if (contentY<YEBeganRefreshOffset) {
            self.indicator.pullProgress = contentY;
        }
        
        
        if (contentY<YEBeganStretchOffset) {
            if (self.scrollView.decelerating) {
                self.state = MJRefreshStateIdle;
            }
        }else if (contentY>=YEBeganStretchOffset && contentY < YEBeganRefreshOffset) {
            // 转为即将刷新状态
            self.state = MJRefreshStateWillRefresh;
            
        }else if (contentY>=YEBeganRefreshOffset) {
            // 转为松开就可以刷新状态
            self.state = MJRefreshStatePulling;
        }
    }
}

#pragma mark - 结束刷新
- (void)endRefreshingSuccess
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.indicator refreshSuccess:YES];
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [self endRefreshing];
        });
    });
}

- (void)endRefreshingFail
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.indicator refreshSuccess:NO];
        
        double delayInSeconds = 0.5;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [self endRefreshing];
        });
    });
}

@end
