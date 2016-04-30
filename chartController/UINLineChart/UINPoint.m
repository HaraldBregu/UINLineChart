//
//  UINPoint.m
//  chartController
//
//  Created by harald bregu on 17/10/15.
//  Copyright © 2015 atom. All rights reserved.
//

#import "UINPoint.h"

@interface UINPoint () {
    CALayer *sublayer;
}
@end

@implementation UINPoint

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    _cornerRadius = 0.0f;
    _borderWidth = 0.0f;
    _borderColor = [UIColor clearColor];
    _fillColor = [UIColor lightGrayColor];
    _selectedFillColor = [UIColor lightGrayColor];
    sublayer = [CALayer layer];
    [self addTarget:self action:@selector(didSelectPoint:) forControlEvents:UIControlEventTouchDown];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.layer addSublayer:sublayer];
    sublayer.cornerRadius = _cornerRadius;
    sublayer.borderWidth = _borderWidth;
    sublayer.borderColor = _borderColor.CGColor;
    sublayer.backgroundColor = _fillColor.CGColor;
    sublayer.backgroundColor = _fillColor.CGColor;
}

- (void)setTouchSize:(CGSize)touchSize {
    _touchSize = touchSize;
    CGRect newRect = self.frame;
    newRect = CGRectMake(0, 0, _touchSize.width, _touchSize.height);
    self.frame = newRect;
}

- (void)setSize:(CGSize)size {
    _size = size;
    sublayer.frame = CGRectMake(self.center.x, self.center.y, _size.width, _size.height);
    sublayer.anchorPoint = CGPointMake(1.0, 1.0);
}

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    [self setNeedsLayout];
}

- (void)setSelectedFillColor:(UIColor *)selectedFillColor {
    _selectedFillColor = selectedFillColor;
}

- (void)didSelectPoint:(id)sender {
}

- (void)didDeselectPoint:(id)sender {
}

- (CGRect)currentFrame {
    return CGRectMake(self.center.x-_size.width/2, self.center.y-_size.height/2, _size.width, _size.height);
}

@end
