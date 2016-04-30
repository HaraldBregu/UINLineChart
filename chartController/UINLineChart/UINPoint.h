//
//  UINPoint.h
//  chartController
//
//  Created by harald bregu on 17/10/15.
//  Copyright © 2015 atom. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINPoint : UIControl
@property (nonatomic, assign) CGSize touchSize;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat cornerRadius;
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *selectedFillColor;
- (CGRect)currentFrame;
@end
