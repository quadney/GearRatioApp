//
//  GraphView.m
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import "GraphView.h"

#import "Effort.h"
#import "EffortPoint.h"

@interface GraphView(){
    NSInteger _maxCadence;
    NSTimeInterval _timeLength;
    NSDate* _maxTime;
    NSDate* _minTime;
    Effort* _effort;
    NSDate* _touchStartDate;
    NSDate* _touchEndDate;
    CGFloat _startXPixel;
    CGFloat _endXPixel;
}

@end

@implementation GraphView

- (void)setEffort:(Effort*)effort
{
    _effort = effort;
    _minTime = [effort.effortPoints firstObject].pointDate;
    _maxTime = [effort.effortPoints lastObject].pointDate;
    _timeLength = [_maxTime timeIntervalSinceDate:_minTime];
    
    // get the max cadence
    for (EffortPoint* point in effort.effortPoints) {
        if ([point.cadence integerValue] > _maxCadence) {
            _maxCadence = [point.cadence integerValue];
        }
    }
//    _maxCadence += 60;
    _startXPixel = 0.;
    _endXPixel = 0.;
}

- (void)drawRect:(CGRect)rect
{
    if (_effort) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextMoveToPoint(context, 0., 0.);
        
        for (EffortPoint* point in _effort.effortPoints) {
            CGFloat cadence = [self mapCadence:[point.cadence integerValue] height:self.bounds.size.height];
            CGFloat time = [self mapTime:[point.pointDate timeIntervalSinceDate:_minTime] width:self.bounds.size.width];
            
            CGContextAddLineToPoint(context, time, cadence);
        }
        CGContextStrokePath(context);
        
        CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0. green:0. blue:1.0 alpha:.5].CGColor);
        CGContextFillRect(context, CGRectMake(_startXPixel, 0., _endXPixel - _startXPixel, self.bounds.size.height));
    }
}

- (CGFloat)mapCadence:(NSInteger)cadence height:(CGFloat)height
{
    return height - cadence*1.0f / _maxCadence * height;
}

- (CGFloat)mapTime:(NSTimeInterval)time width:(CGFloat)width
{
    return abs((int)time) / _timeLength * width;
}

- (NSTimeInterval)timeForPoint:(CGFloat)timePixel
{
    return _timeLength * timePixel / self.bounds.size.width;
}

#pragma mark - Gesture Recognizer

- (void)didPan:(UIGestureRecognizer*)gestureRecognizer
{
    CGFloat x = [gestureRecognizer locationInView:self].x;
    NSTimeInterval timeInterval = [self timeForPoint:x];
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        // set the beginning point
        _touchStartDate = [NSDate dateWithTimeInterval:timeInterval sinceDate:_minTime];
        _startXPixel = x;
        _endXPixel = x;
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateChanged) {
        _endXPixel = x;
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        // set the end point
        _touchEndDate = [NSDate dateWithTimeInterval:timeInterval sinceDate:_minTime];
        Effort* newEffort = [_effort createSubEffortFromFirstDate:_touchStartDate date:_touchEndDate];
        [self setEffort:newEffort];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateFailed || gestureRecognizer.state == UIGestureRecognizerStateCancelled) {
        _touchStartDate = nil;
        _touchEndDate = nil;
    }
    
    [self setNeedsDisplay];
}

@end
