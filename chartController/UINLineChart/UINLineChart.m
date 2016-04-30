//
//  UINLineChart.m
//  chartController
//
//  Created by harald bregu on 17/10/15.
//  Copyright © 2015 atom. All rights reserved.
//

#import "UINLineChart.h"

@interface UINLineChart () {

    //UIView *chartContainer;
    UIView *axisContainerHorizontal;
    UIView *axisHorizontalItem;
    
    // Line
    UIBezierPath *linePath;
    CAShapeLayer *lineLayer;
    
    // Line closed
    UIBezierPath *linePathClosed;
    CAShapeLayer *lineLayerClosed;

    // Mask
    CAShapeLayer *maskLayer;
    
    // Gradient
    CAGradientLayer *gradientLayer;
    
    //
    NSUInteger selectedIndex;
}

- (NSInteger)numberOfPointsInLineChart:(UINLineChart *)linechart;
- (CGPoint)positionOfPointInLineChart:(UINLineChart *)linechart atIndex:(NSUInteger)index;
- (nonnull UINDashLine *)dashLineAtIndex:(NSUInteger)index;

@property (nonatomic, strong) NSArray *positions;

@end


@implementation UINLineChart

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
    _showDashLines = NO;
    
    /*** CHART CONTAINER ***/
    _chartContainer = [[UIView alloc] initWithFrame:CGRectZero];
    _chartContainer.backgroundColor = [UIColor clearColor];
    
    /*** AXIS CONTAINER HORIZONTAL ***/
    axisContainerHorizontal = [[UIView alloc] initWithFrame:CGRectZero];
    
    // Line path
    linePath = [UIBezierPath bezierPath];
    lineLayer = [[CAShapeLayer alloc] init];
    
    // Line path closed Layer
    linePathClosed = [UIBezierPath bezierPath];
    lineLayerClosed = [[CAShapeLayer alloc] init];
    
    // Mask layer
    maskLayer = [[CAShapeLayer alloc] init];
    
    // Gradient layer
    gradientLayer = [[CAGradientLayer alloc] init];
}

- (void)layoutSubviews {
    [super layoutSubviews];

    /*************** REMOVE SUBVIEWS ******************/
    for (UIView *subview in _chartContainer.subviews)
        if ([subview isKindOfClass:[UINPoint class]])
            [subview removeFromSuperview];
    for (UIView *subview in _chartContainer.subviews)
        if ([subview isKindOfClass:[UINDashLine class]])
            [subview removeFromSuperview];
    for (UIView *subview in _chartContainer.subviews)
        [subview removeFromSuperview];
    for (UIView *subview in axisContainerHorizontal.subviews)
        [subview removeFromSuperview];

    /*** AXIS CONTAINER ***/
    [self addSubview:axisContainerHorizontal];

    /*** CHART CONTAINER ***/
    [self addSubview:_chartContainer];
    _chartContainer.frame = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height-axisContainerHorizontal.bounds.size.height);

    [_chartContainer.layer addSublayer:gradientLayer];
    [_chartContainer.layer addSublayer:lineLayer];
    [_chartContainer.layer addSublayer:lineLayerClosed];
    
    lineLayerClosed.frame = _chartContainer.bounds;
    maskLayer.frame = _chartContainer.bounds;
    lineLayer.frame = _chartContainer.bounds;
    gradientLayer.frame = _chartContainer.bounds;
    
    [linePath removeAllPoints];
    [linePathClosed removeAllPoints];
    
    /**** POINTS, LINES, AXIS VIEW ****/
    for (int i = 0; i < [self numberOfPointsInLineChart:self]; i++) {
        
        // POINT
        UINPoint *point = [self pointAtIndex:i];
        [_chartContainer addSubview:point];

        /*** HORIZONTAL AXIS ITEMS ***/
        UIView *viewItem = [self viewItemAtIndex:i];
        viewItem.center = CGPointMake(point.center.x, viewItem.center.y);
        [axisContainerHorizontal addSubview:viewItem];
        axisContainerHorizontal.frame = CGRectMake(0, self.bounds.size.height-viewItem.bounds.size.height, self.bounds.size.width, viewItem.bounds.size.height);
        
        /*** CHART CONTAINER ***/
        CGRect chartContainerRect = _chartContainer.frame;
        chartContainerRect.size.height = self.bounds.size.height - axisContainerHorizontal.bounds.size.height;
        _chartContainer.frame = chartContainerRect;

        if (i == 0) {
            [linePath moveToPoint:CGPointMake(point.center.x, point.center.y)];
            [linePathClosed moveToPoint:CGPointMake(0 + point.touchSize.width/2, _chartContainer.bounds.size.height)];
            [linePathClosed addLineToPoint:CGPointMake(point.center.x, point.center.y)];
        } else {
            [linePath addLineToPoint:CGPointMake(point.center.x, point.center.y)];
            [linePathClosed addLineToPoint:CGPointMake(point.center.x, point.center.y)];
        }
        
        if (i == [self numberOfPointsInLineChart:self]-1) {
            [linePathClosed addLineToPoint:CGPointMake(_chartContainer.bounds.size.width - point.touchSize.width/2, _chartContainer.bounds.size.height)];
            [linePathClosed closePath];
        }
        
        /*** LINES ***/
        UINDashLine *dashLine = [self dashLineAtIndex:i];
        dashLine.startPoint = point.center;
        dashLine.targetView = _chartContainer;
        dashLine.direction = UINDashDirectionVertical;
        [_chartContainer addSubview:dashLine];
        [_chartContainer sendSubviewToBack:dashLine];
    }

    lineLayerClosed.path = linePathClosed.CGPath;
    lineLayerClosed.fillColor = nil;
    
    lineLayer.path = linePath.CGPath;
    lineLayer.strokeColor = _lineColor.CGColor;
    lineLayer.lineWidth = _lineWidth;
    lineLayer.fillColor = nil;
    
    maskLayer.path = linePathClosed.CGPath;
    gradientLayer.colors = _gradientColors;
    gradientLayer.mask = maskLayer;
}

- (void)reloadLineChart {
    [self setNeedsLayout];
}

//-----------------------------------
#pragma mark - Instance Methods
//-----------------------------------

- (UINPoint *)dequeuePointWithIdentifier:(NSString *)identifier{
    return [[UINPoint alloc] initWithFrame:CGRectZero];
}

- (UINDashLine *)dequeueDashLine {
    return [[UINDashLine alloc] initWithFrame:CGRectZero];
}

//----------------------------
#pragma mark - Datasource
//----------------------------

- (void)setDatasource:(id<UINLineChartDataSource>)datasource {
    if (_datasource != datasource) {
        _datasource = datasource;
    }
}

- (void)setDelegate:(id<UINLineChartDelegate>)delegate {
    if (_delegate != delegate) {
        _delegate = delegate;
    }
}

- (void)setShowDashLines:(BOOL)showDashLines {
    _showDashLines = showDashLines;
    [self setNeedsLayout];
}

//-------------------------------------
#pragma mark - UIPoint Datasource
//-------------------------------------

- (NSInteger)numberOfPointsInLineChart:(UINLineChart *)linechart {
    if ([_datasource respondsToSelector:@selector(numberOfPointsInLineChart:)]) {
        return [_datasource numberOfPointsInLineChart:linechart];
    } else {
        NSAssert(_datasource, @"Data source is not set.");
        NSAssert([_datasource respondsToSelector:@selector(numberOfPointsInLineChart:)], @"numberOfPointsInLineChart: not implemented.");
        return 0;
    }
}

- (CGPoint)positionOfPointInLineChart:(UINLineChart *)linechart atIndex:(NSUInteger)index {
    if ([_datasource respondsToSelector:@selector(positionOfPointInLineChart:atIndex:)]) {
        CGPoint position = [_datasource positionOfPointInLineChart:linechart atIndex:index];
        if (isnan(position.x) || isnan(position.y)) {
            position = CGPointZero;
        }
        return position;
    } else {
        NSAssert(_datasource, @"Data source is not set.");
        NSAssert([_datasource respondsToSelector:@selector(positionOfPointInLineChart:atIndex:)], @"positionOfPointInLineChart:atIndex: not implemented.");
        return CGPointZero;
    }
}

- (UINPoint *)pointAtIndex:(NSUInteger)index {
    if ([_datasource respondsToSelector:@selector(linechart:pointAtIndex:)]) {
        
        /*** POINT ***/
        UINPoint *point = [_datasource linechart:self pointAtIndex:index];
        
        /*** POSITION ***/
        CGPoint position = [self positionOfPointInLineChart:self atIndex:index];

//        if (isnan(position.y) || isnan(position.x)) {
//            position = CGPointZero;
//        }
        
        CGFloat pointWidth = point.touchSize.width;
        CGFloat pointHeight = point.size.height;
        CGFloat pointWidthOffset = pointWidth/2;
        CGFloat pointHeightOffset = pointHeight/2;
        
        CGRect newRect = CGRectMake(_chartContainer.bounds.origin.x + pointWidthOffset,
                                    _chartContainer.bounds.origin.y + pointHeightOffset,
                                    _chartContainer.bounds.size.width - pointWidth,
                                    _chartContainer.bounds.size.height - pointHeight);
        
        /*** X ***/
        CGFloat maxWidth  = [self maxPositionX] - [self minPositionX];
        if (maxWidth == 0) {
            maxWidth = [self maxPositionX];
        }
        CGFloat x = position.x - [self minPositionX];
        x = x * (newRect.size.width / maxWidth);
        x += pointWidthOffset;
        
        /*** Y ***/
        CGFloat maxHeight = [self maxPositionY] - [self minPositionY];
        CGFloat y;
        if (maxHeight == 0) {
            maxHeight = [self maxPositionY];
            y = _chartContainer.bounds.size.height/2;
        } else {
            y = position.y - [self minPositionY];
            y = y * (newRect.size.height / maxHeight);
            y += pointHeightOffset;
        }
        
        point.center = CGPointMake(x, _chartContainer.bounds.size.height - y);
        
        point.tag = index;
        
        [point addTarget:self action:@selector(willSelectPoint:) forControlEvents:UIControlEventTouchDown];
        [point addTarget:self action:@selector(didSelectPoint:) forControlEvents:UIControlEventTouchUpInside];
        [point addTarget:self action:@selector(didSelectPoint:) forControlEvents:UIControlEventTouchUpOutside];

        return point;
        
    } else {
        NSAssert(_datasource, @"Data source is not set.");
        NSAssert([_datasource respondsToSelector:@selector(linechart:pointAtIndex:)], @"linechart:pointAtIndex: not implemented.");
        return nil;
    }
}

//-----------------------------------
#pragma mark - UIPoint Delegate
//-----------------------------------

- (void)willSelectPoint:(UINPoint *)point {
    if ([_delegate respondsToSelector:@selector(linechart:willSelectPointAtIndex:)]) {
        [_delegate linechart:self willSelectPointAtIndex:point.tag];
        [self willDeselectPoint:point];
    } else {
        //DLog(@"Will select point index: %li", (long)point.tag);
    }
}

- (void)didSelectPoint:(UINPoint *)point {
    if ([_delegate respondsToSelector:@selector(linechart:didSelectPointAtIndex:)]) {
        [_delegate linechart:self didSelectPointAtIndex:point.tag];
    } else {
        //DLog(@"Did select point index: %li", (long)point.tag);
    }
}

- (void)willDeselectPoint:(UINPoint *)point {
    if ([_delegate respondsToSelector:@selector(linechart:willDeselectPointAtIndex:)]) {
        if (!selectedIndex)
            selectedIndex = point.tag;
        if (selectedIndex && selectedIndex != point.tag) {
            UINPoint *point = [self pointAtIndex:selectedIndex];
            [_delegate linechart:self willDeselectPointAtIndex:selectedIndex];
            selectedIndex = point.tag;
        }
    }
}

//----------------------------------------
#pragma mark - UINDashLine Delegate
//----------------------------------------

- (UINDashLine *)dashLineAtIndex:(NSUInteger)index {
    if ([_datasource respondsToSelector:@selector(linechart:dashLineAtIndex:)]) {
        return (UINDashLine *)[_datasource linechart:self dashLineAtIndex:index];
    } else
        return nil;
}

//-------------------------------------
#pragma mark - ViewItem Delegate
//-------------------------------------

- (UIView *)viewItemAtIndex:(NSInteger)index {
    if ([_datasource respondsToSelector:@selector(axisHorizontalItem:atIndex:)]) {
        return [_datasource axisHorizontalItem:self atIndex:index];
    } else
        return nil;
}

//----------------------------
#pragma mark - Algorithms
//----------------------------

- (NSArray *)positions {
    NSMutableArray *positions = [NSMutableArray array];
    for (int p = 0; p<[self numberOfPointsInLineChart:self]; p++) {
        CGPoint pointCenter = [self positionOfPointInLineChart:self atIndex:p];
        if (isnan(pointCenter.x) || isnan(pointCenter.y)) {
            pointCenter = CGPointZero;
        }

        [positions addObject:[NSValue valueWithCGPoint:pointCenter]];
    }
    return positions;
}

- (CGFloat)minPositionX {
    NSMutableArray *points = [[self positions] mutableCopy];
    [points sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CGPoint firstPoint = [obj1 CGPointValue];
        CGPoint secondPoint = [obj2 CGPointValue];
        return firstPoint.x>secondPoint.x;
    }];
    return [[points firstObject] CGPointValue].x;
}

- (CGFloat)maxPositionX {
    NSMutableArray *points = [[self positions] mutableCopy];
    [points sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CGPoint firstPoint = [obj1 CGPointValue];
        CGPoint secondPoint = [obj2 CGPointValue];
        return firstPoint.x>secondPoint.x;
    }];
    return [[points lastObject] CGPointValue].x;
}

- (CGFloat)minPositionY {
    NSMutableArray *points = [[self positions] mutableCopy];
    [points sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CGPoint firstPoint = [obj1 CGPointValue];
        CGPoint secondPoint = [obj2 CGPointValue];
        return firstPoint.y>secondPoint.y;
    }];
    return [[points firstObject] CGPointValue].y;
}

- (CGFloat)maxPositionY {
    NSMutableArray *points = [[self positions] mutableCopy];
    [points sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        CGPoint firstPoint = [obj1 CGPointValue];
        CGPoint secondPoint = [obj2 CGPointValue];
        return firstPoint.y>secondPoint.y;
    }];
    return [[points lastObject] CGPointValue].y;
}

@end
