//
//  EffortPoint.m
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import "EffortPoint.h"

@implementation EffortPoint

- (id)initWithLatLongAttributes:(NSDictionary<NSString *,NSString *>*)attributes
{
    NSAssert([attributes count] == 2, @"Passed in attributes expect only 2 values");
    self = [super init];
    if (self) {
        NSString* lat = attributes[@"lat"];
        NSString* lon = attributes[@"lon"];
        _location = [[CLLocation alloc] initWithLatitude:[lat doubleValue] longitude:[lon doubleValue]];
    }
    
    return self;
}

- (float)speedAtGearRatio:(float)gearRatio
{
    NSAssert(self.cadence, @"Cadence cannot be nil");
    
    // formula is circumference of tire x gear ratio x cadence
    // 0.79 is the standard 700c tire diameter
    //TODO: change this later if incorporate different tire sizes...
    return 0.79f * [self.cadence floatValue] * gearRatio;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"Effort point with lat: %f long: %f cadence: %li heartrate: %li elevation: %f time: %@", self.location.coordinate.latitude, self.location.coordinate.longitude, (long) [self.cadence integerValue], (long) [self.heartrate integerValue], [self.elevation doubleValue], self.pointDate];
}

@end
