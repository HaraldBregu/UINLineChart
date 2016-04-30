//
//  UINDashLine.m
//
//  Created by harald bregu on 18/10/15.
//  Copyright © 2015 atom. All rights reserved.
//

#import "UINDashLine.h"

@interface UINDashLine () {
    UIBezierPath *linePath;
    CAShapeLayer *lineLayer;
}
@end

@implementation UINDashLine

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
    _lineColor = [UIColor redColor];
    _lineWidth = 1.0f;
    linePath = [UIBezierPath bezierPath];
    lineLayer = [[CAShapeLayer alloc] init];
    [self.layer addSublayer:lineLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    lineLayer.frame = self.bounds;
    [linePath moveToPoint:_startPoint];
    switch (_direction) {
        case UINDashDirectionNone:
            break;
        case UINDashDirectionVertical:
            [linePath addLineToPoint:CGPointMake(_startPoint.x, _targetView.frame.origin.x)];
            break;
        default:
            break;
    }
    
    lineLayer.path = linePath.CGPath;
    lineLayer.fillColor = nil;
    lineLayer.lineWidth = _lineWidth;
    lineLayer.strokeColor = _lineColor.CGColor;
    lineLayer.lineDashPattern = @[@4, @2];
}

@end
