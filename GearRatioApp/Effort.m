//
//  Effort.m
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import "Effort.h"

#import "EffortPoint.h"

@implementation Effort

- (void)setGear:(NSNumber*)chainring cog:(NSNumber*)cog
{
    [self setChainring:chainring];
    [self setCog:cog];
}

- (float)gearRatio
{
    if ([self.chainring integerValue] <= 0 || [self.cog integerValue] <= 0) {
        NSLog(@"Invalid gear data");
        return 0.0;
    }
    
    return [self.chainring floatValue] / [self.cog floatValue];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"Effort: %@ gear: %@x%@ effortPoints: %@", self.title, self.chainring, self.cog, self.effortPoints];
}

- (Effort*)createSubEffortFromFirstDate:(NSDate*)date1 date:(NSDate*)date2
{
    // get the true start and end date
    NSDate* startDate = [date1 earlierDate:date2];
    NSDate* endDate = [date1 laterDate:date2];
    
    NSInteger startIndex = -1;
    NSInteger endIndex = -1;
    
    // find the index of dates closest to the start date / end date
    for (NSInteger i = 0; i < [self.effortPoints count]; i++) {
        EffortPoint* point = self.effortPoints[i];
        if ([[point.pointDate earlierDate:startDate] isEqualToDate:point.pointDate]) {
            startIndex = i;
        }
        
        if([[point.pointDate earlierDate:endDate] isEqualToDate:endDate]) {
            endIndex = i;
            break;
        }
    }
    
    if (endIndex < 0 || startIndex < 0) {
        NSLog(@"error, cannot find start and end index");
    }
    
    // take the effort points from that range, and return new effort
    NSArray<EffortPoint*>* newPoints = [self.effortPoints subarrayWithRange:NSMakeRange(startIndex, endIndex - startIndex + 1)];
    Effort* newEffort = [[Effort alloc] init];
    newEffort.chainring = [self.chainring copy];
    newEffort.cog = [self.cog copy];
    newEffort.title = @"Sub Effort";
    newEffort.time = self.time;
    newEffort.effortPoints = [newPoints copy];
    return newEffort;
}

@end
