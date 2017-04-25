//
//  YEGradientLabel.m
//  ModaiTreasure
//
//  Created by 相晔谷 on 2016/11/1.
//  Copyright © 2016年 modai_sun. All rights reserved.
//

#import "YEGradientLabel.h"
#import "UIView+YEExtension.h"
#import "UIButton+NSManager.h"
#import "UILabel+NSManager.h"

#define __kFont(key)        [UIFont systemFontOfSize:key]
#define __kWeiHeiTextColor  [UIColor colorWithRed:104.f/255.f green:104.f/255.f blue:104.f/255.f alpha:1]
#define __kBrownTextColor   [UIColor colorWithRed:255.0/255.0 green:155.0/255.0 blue:57.0/255.0 alpha:1]
#define __kDetailTextColor        [UIColor colorWithRed:190.f/255.f green:190.f/255.f blue:190.f/255.f alpha:1] //3.正文

@implementation YEGradientLabel
{
    NSArray *_titleArray;
}
- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        
        _titleArray = titleArray;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 0.5
    UILabel *star = [[UILabel alloc] init];
    star.font = __kFont(15);
    star.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < _titleArray.count; i ++) {
        CGRect newRect = CGRectMake(i * rect.size.width/_titleArray.count, 0, rect.size.width/_titleArray.count, self.YEHeight);
        star.text = _titleArray[i];
        
        CGFloat m = self.tintWidth-i;
        if (m<0.f) {
            m = -m;
        }
        if (m>1.f) {
            m = 1.f;
        }
        star.font = __kFont((15+2)-2*m);
        [star drawTextInRect:newRect];
    }
    [__kWeiHeiTextColor setFill];
    UIRectFillUsingBlendMode(rect, kCGBlendModeSourceIn);
    
    [__kBrownTextColor setFill];
    CGRect highlight = CGRectMake(self.tintWidth * rect.size.width/_titleArray.count, 0, rect.size.width/_titleArray.count, rect.size.height);
    UIRectFillUsingBlendMode(highlight, kCGBlendModeSourceIn);
}

- (void)setTintWidth:(CGFloat)tintWidth {
    
    _tintWidth = tintWidth;
    [self setNeedsDisplay];
}

@end
