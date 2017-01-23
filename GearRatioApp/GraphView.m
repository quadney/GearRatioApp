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
    _maxCadence += 60;
}

- (void)drawRect:(CGRect)rect
{
    if (_effort) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
        CGContextMoveToPoint(context, 0., 0.);
        
        for (EffortPoint* point in _effort.effortPoints) {
            CGFloat cadence = [self mapCadence:[point.cadence integerValue] height:self.bounds.size.height];
            CGFloat time = [self mapTime:[point.pointDate timeIntervalSinceDate:_minTime] width:self.bounds.size.width];
            
//            CGContextMoveToPoint(context, time, cadence);
            CGContextAddLineToPoint(context, time, cadence);
//            CGContextFillEllipseInRect(context, CGRectMake(time - .5, cadence - .5, 1., 1.));
        }
        
        CGContextStrokePath(context);
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

@end
