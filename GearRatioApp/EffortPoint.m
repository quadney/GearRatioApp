//
//  EffortPoint.m
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import "EffortPoint.h"

@implementation EffortPoint

- (float)speedAtGearRatio:(float)gearRatio
{
    NSAssert(self.cadence, @"Cadence cannot be nil");
    
    // formula is circumference of tire x gear ratio x cadence
    // 0.79 is the standard 700c tire diameter
    //TODO: change this later if incorporate different tire sizes...
    return 0.79f * [self.cadence floatValue] * gearRatio;
}

@end
