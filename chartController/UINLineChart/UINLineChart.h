//
//  UINLineChart.h
//  chartController
//
//  Created by harald bregu on 17/10/15.
//  Copyright © 2015 atom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINPoint.h"
#import "UINDashLine.h"

@class UINPoint, UINDashLine;
@protocol UINLineChartDataSource, UINLineChartDelegate;

@interface UINLineChart : UIView

@property CGFloat lineWidth;
@property (nonatomic, strong, nullable) UIColor *lineColor;
@property (nonatomic, strong, nullable) NSArray *gradientColors;
@property (nonatomic, strong, nonnull) UIView *chartContainer;

@property (nonatomic, assign) BOOL showDashLines;

- (nonnull UINPoint *)dequeuePointWithIdentifier:(nullable NSString *)identifier;
- (nonnull UINPoint *)pointAtIndex:(NSUInteger)index;
- (nonnull UINDashLine *)dequeueDashLine;

@property (nonatomic, weak) IBOutlet id<UINLineChartDataSource>datasource;
@property (nonatomic, weak) IBOutlet id<UINLineChartDelegate>delegate;

- (void)reloadLineChart;

@end

@protocol UINLineChartDataSource <NSObject>
@required
- (NSUInteger)numberOfPointsInLineChart:(nullable UINLineChart *)linechart;
- (CGPoint)positionOfPointInLineChart  :(nullable UINLineChart *)linechart atIndex:(NSUInteger)index;
- (nullable UINPoint *)linechart:(nullable UINLineChart *)linechart pointAtIndex:(NSUInteger)index;
@optional
- (nullable UINDashLine *)linechart:(nullable UINLineChart *)linechart dashLineAtIndex:(NSUInteger)index;
- (nullable UIView *)axisHorizontalItem:(nullable UINLineChart *)lineChart atIndex:(NSUInteger)index;
@end

@protocol UINLineChartDelegate <NSObject>
@optional
- (void)linechart:(nullable UINLineChart *)linechart willSelectPointAtIndex:(NSUInteger)index;
- (void)linechart:(nullable UINLineChart *)linechart didSelectPointAtIndex:(NSUInteger)index;
- (void)linechart:(nullable UINLineChart *)linechart willDeselectPointAtIndex:(NSUInteger)index;
@end
