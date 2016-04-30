//
//  ViewController.m
//  chartController
//
//  Created by harald bregu on 09/10/15.
//  Copyright © 2015 atom. All rights reserved.
//

#import "ViewController.h"
#import "AMPopTip.h"
#import "UINLineChart.h"


@interface ViewController ()<UINLineChartDataSource, UINLineChartDelegate> {
    NSMutableArray *positions;
}
@property (nonatomic, strong) AMPopTip *popTip;
//@property (nonatomic, strong) UINLineChart *linechart;

@property (nonatomic, strong) IBOutlet UINLineChart *linechart01;
@property (nonatomic, strong) IBOutlet UINLineChart *linechart02;
@property (nonatomic, strong) IBOutlet UINLineChart *linechart03;
@property (nonatomic, strong) IBOutlet UINLineChart *linechart04;
@property (nonatomic, strong) IBOutlet UINLineChart *linechart05;
@property (nonatomic, strong) IBOutlet UINLineChart *linechart06;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithRed:69.0/255.0 green: 115.0/255.0 blue: 175.0/255.0 alpha:1.0];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.popTip = [AMPopTip popTip];
    self.popTip.radius = 3.0f;
    self.popTip.popoverColor = [UIColor whiteColor];
    self.popTip.borderColor = [UIColor colorWithRed:50.0/255.0 green: 50.0/255.0 blue: 50.0/255.0 alpha:1.0];
    self.popTip.borderWidth = 0.6f;
    self.popTip.textColor = [UIColor colorWithRed:50.0/255.0 green: 50.0/255.0 blue: 50.0/255.0 alpha:1.0];
    self.popTip.edgeInsets = UIEdgeInsetsMake(4, 4, 4, 4);
    self.popTip.offset = 11.0f;
    
    positions = [@[[NSValue valueWithCGPoint:CGPointMake( 0,  (int)0 + arc4random() % (100-0+1))],
                   [NSValue valueWithCGPoint:CGPointMake(10, (int)0 + arc4random() % (100-0+1))],
                   [NSValue valueWithCGPoint:CGPointMake(20, (int)0 + arc4random() % (100-0+1))],
                   [NSValue valueWithCGPoint:CGPointMake(30, (int)0 + arc4random() % (100-0+1))],
                   [NSValue valueWithCGPoint:CGPointMake(40, (int)0 + arc4random() % (100-0+1))],
                   [NSValue valueWithCGPoint:CGPointMake(50, (int)0 + arc4random() % (100-0+1))]] mutableCopy];

//    positions = [@[[NSValue valueWithCGPoint:CGPointMake( 60,  60)],
//                   [NSValue valueWithCGPoint:CGPointMake( 60,  60)],
//                   [NSValue valueWithCGPoint:CGPointMake( 60,  60)],
//                   [NSValue valueWithCGPoint:CGPointMake( 60,  60)],
//                   [NSValue valueWithCGPoint:CGPointMake( 60,  60)],
//                   [NSValue valueWithCGPoint:CGPointMake( 60,  60)]]
//                 mutableCopy];

    
    // UILineChart 01
    self.linechart01.backgroundColor = [UIColor clearColor];
    self.linechart01.gradientColors = @[(id)[UIColor colorWithRed:50.0/255.0 green: 50.0/255.0 blue: 50.0/255.0 alpha:1.0].CGColor,
                                        (id)[UIColor colorWithRed:50.0/255.0 green: 50.0/255.0 blue: 50.0/255.0 alpha:0.0].CGColor];
    self.linechart01.lineWidth = 1.0;
    self.linechart01.lineColor = [UIColor colorWithRed:50.0/255.0 green: 50.0/255.0 blue: 50.0/255.0 alpha:1.0];
    
    
    // UILineChart 02
    self.linechart02.backgroundColor = [UIColor clearColor];
    self.linechart02.gradientColors = @[(id)[UIColor colorWithRed:183.0/255.0 green: 32.0/255.0 blue: 79.0/255.0 alpha:1.0].CGColor,
                                        (id)[UIColor colorWithRed:183.0/255.0 green: 32.0/255.0 blue: 79.0/255.0 alpha:0.0].CGColor];
    self.linechart02.lineWidth = 1.0;
    self.linechart02.lineColor = [UIColor colorWithRed:183.0/255.0 green: 32.0/255.0 blue: 79.0/255.0 alpha:1.0];

    // UILineChart 03
    self.linechart03.backgroundColor = [UIColor clearColor];
    self.linechart03.gradientColors = @[(id)[UIColor colorWithRed:94.0/255.0 green: 177.0/255.0 blue: 143.0/255.0 alpha:1.0].CGColor,
                                        (id)[UIColor colorWithRed:94.0/255.0 green: 177.0/255.0 blue: 143.0/255.0 alpha:0.0].CGColor];
    self.linechart03.lineWidth = 1.0;
    self.linechart03.lineColor = [UIColor colorWithRed:94.0/255.0 green: 177.0/255.0 blue: 143.0/255.0 alpha:1.0];

    // UILineChart 04
    self.linechart04.backgroundColor = [UIColor clearColor];
    self.linechart04.gradientColors = @[(id)[UIColor colorWithRed:30.0/255.0 green: 201.0/255.0 blue: 221.0/255.0 alpha:1.0].CGColor,
                                        (id)[UIColor colorWithRed:30.0/255.0 green: 201.0/255.0 blue: 221.0/255.0 alpha:0.0].CGColor];
    self.linechart04.lineWidth = 1.0;
    self.linechart04.lineColor = [UIColor colorWithRed:30.0/255.0 green: 201.0/255.0 blue: 221.0/255.0 alpha:1.0];

    // UILineChart 05
    self.linechart05.backgroundColor = [UIColor clearColor];
    self.linechart05.gradientColors = @[(id)[UIColor colorWithRed:233.0/255.0 green: 201.0/255.0 blue: 76.0/255.0 alpha:1.0].CGColor,
                                        (id)[UIColor colorWithRed:233.0/255.0 green: 201.0/255.0 blue: 76.0/255.0 alpha:0.0].CGColor];
    self.linechart05.lineWidth = 1.0;
    self.linechart05.lineColor = [UIColor colorWithRed:233.0/255.0 green: 201.0/255.0 blue: 76.0/255.0 alpha:1.0];

    // UILineChart 06
    self.linechart06.backgroundColor = [UIColor clearColor];
    self.linechart06.gradientColors = @[(id)[UIColor colorWithRed:95.0/255.0 green: 80.0/255.0 blue: 85.0/255.0 alpha:1.0].CGColor,
                                        (id)[UIColor colorWithRed:95.0/255.0 green: 80.0/255.0 blue: 85.0/255.0 alpha:0.0].CGColor];
    self.linechart06.lineWidth = 1.0;
    self.linechart06.lineColor = [UIColor colorWithRed:95.0/255.0 green: 80.0/255.0 blue: 85.0/255.0 alpha:1.0];

}


#pragma mark - UINLineChart DataSource
- (NSUInteger)numberOfPointsInLineChart:(UINLineChart *)linechart {
    return [positions count];
    return 0;
}

- (CGPoint)positionOfPointInLineChart:(UINLineChart *)linechart atIndex:(NSUInteger)index {
    return [[positions objectAtIndex:index] CGPointValue];
//    return CGPointZero;
}

- (UINPoint *)linechart:(UINLineChart *)linechart pointAtIndex:(NSUInteger)index {
    UINPoint *point = [linechart dequeuePointWithIdentifier:@"nil"];
    
    if (linechart == _linechart01) {
        point.touchSize = CGSizeMake(40, 40);
        point.size = CGSizeMake(6, 6);
        point.borderWidth = 1.0f;
        point.borderColor = [UIColor colorWithRed:50.0/255.0 green: 50.0/255.0 blue: 50.0/255.0 alpha:1.0];
        point.cornerRadius = 3.0f;
        point.fillColor = [UIColor groupTableViewBackgroundColor];
    }

    if (linechart == _linechart02) {
        point.touchSize = CGSizeMake(40, 40);
        point.size = CGSizeMake(8, 8);
        point.borderWidth = 1.0f;
        point.borderColor = [UIColor colorWithRed:183.0/255.0 green: 32.0/255.0 blue: 79.0/255.0 alpha:1.0];
        point.cornerRadius = 4.0f;
        point.fillColor = [UIColor groupTableViewBackgroundColor];
    }
    
    if (linechart == _linechart03) {
        point.touchSize = CGSizeMake(40, 40);
        point.size = CGSizeMake(6, 6);
        point.borderWidth = 1.0f;
        point.borderColor = [UIColor colorWithRed:94.0/255.0 green: 177.0/255.0 blue: 143.0/255.0 alpha:1.0];
        point.cornerRadius = 3.0f;
        point.fillColor = [UIColor groupTableViewBackgroundColor];
    }
    
    if (linechart == _linechart04) {
        point.touchSize = CGSizeMake(40, 40);
        point.size = CGSizeMake(12, 12);
        point.borderWidth = 2.0f;
        point.borderColor = [UIColor colorWithRed:30.0/255.0 green: 201.0/255.0 blue: 221.0/255.0 alpha:1.0];
        point.cornerRadius = 6.0f;
        point.fillColor = [UIColor groupTableViewBackgroundColor];
    }

    if (linechart == _linechart05) {
        point.touchSize = CGSizeMake(40, 40);
        point.size = CGSizeMake(4, 4);
        point.borderWidth = 1.0f;
        point.borderColor = [UIColor colorWithRed:233.0/255.0 green: 201.0/255.0 blue: 76.0/255.0 alpha:1.0];
        point.cornerRadius = 2.0f;
        point.fillColor = [UIColor groupTableViewBackgroundColor];
    }

    if (linechart == _linechart06) {
        point.touchSize = CGSizeMake(40, 40);
        point.size = CGSizeMake(10, 10);
        point.borderWidth = 1.0f;
        point.borderColor = [UIColor colorWithRed:95.0/255.0 green: 80.0/255.0 blue: 85.0/255.0 alpha:1.0];
        point.cornerRadius = 5.0f;
        point.fillColor = [UIColor groupTableViewBackgroundColor];
    }
    
    return point;
}

- (UIView *)axisHorizontalItem:(UINLineChart *)lineChart atIndex:(NSUInteger)index {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    label.text = [NSString stringWithFormat:@"%.1f", [[positions objectAtIndex:index] CGPointValue].x];
    label.textColor = [UIColor colorWithRed:50.0/255.0 green: 50.0/255.0 blue: 50.0/255.0 alpha:1.0];
    [label sizeToFit];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Helvetica" size:8];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (UINDashLine *)linechart:(UINLineChart *)linechart dashLineAtIndex:(NSUInteger)index {
    UINDashLine *dashLine = [linechart dequeueDashLine];
    dashLine.lineColor = [UIColor colorWithRed:50.0/255.0 green: 50.0/255.0 blue: 50.0/255.0 alpha:1.0];
    dashLine.lineWidth = 0.2;
    return dashLine;
}

#pragma mark - UINLineChart Delegate
- (void)linechart:(UINLineChart *)linechart willSelectPointAtIndex:(NSUInteger)index {
    NSLog(@"Will Select point:%i", index);
}

- (void)linechart:(UINLineChart *)linechart didSelectPointAtIndex:(NSUInteger)index {
    
    //NSLog(@"Point: %@", [linechart pointAtIndex:index]);
    NSLog(@"Did Select point:%i", index);
    
    if ([self.popTip isVisible])
        return;
    self.popTip.shouldDismissOnTap = YES;

    UINPoint *point = [linechart pointAtIndex:index];
    [self.popTip showText:@"UINLineChart is the best" direction:AMPopTipDirectionUp maxWidth:100 inView:linechart.chartContainer fromFrame:[point currentFrame]];

}

- (void)linechart:(UINLineChart *)linechart didDeselectPointAtIndex:(NSUInteger)index {
    NSLog(@"Deselect point: %lu", (unsigned long)index);
}





- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    
    //[self.linechart01 reloadData];
    //[self.linechart reordPositionsHorizontally];
}


@end
