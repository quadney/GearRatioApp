//
//  Effort.m
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import "Effort.h"

@implementation Effort

- (float)gearRatio
{
    NSAssert([self.gears count] == 2, @"Gear array not set correctly!");
    float chainring = [self.gears[0] floatValue];
    float cog = [self.gears[1] floatValue];
    
    if (chainring <= 0 || cog <= 0) {
        NSLog(@"Invalid gear data");
        return 0;
    }
    
    return chainring/cog;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"Effort: %@ gears: %@ effortPoints: %@", self.title, self.gears, self.effortPoints];
}

@end
