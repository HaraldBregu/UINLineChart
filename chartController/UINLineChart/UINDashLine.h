//
//  UINDashLine.h
//
//  Created by harald bregu on 18/10/15.
//  Copyright © 2015 atom. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UINDashLineDirection) {
    UINDashDirectionNone, // Default
    UINDashDirectionVertical,
    UINDashDirectionHorizontal
};

@interface UINDashLine : UIView
@property (nonatomic, assign) UINDashLineDirection direction;
@property (nonatomic, strong) UIView *targetView;;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGPoint startPoint;
@end
