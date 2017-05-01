//
//  Effort.h
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EffortPoint;

@interface Effort : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSNumber* chainring;
@property (nonatomic, strong) NSNumber* cog;
@property (nonatomic, strong) NSDate* time;
@property (nonatomic, strong) NSArray<EffortPoint*>* effortPoints;

- (float)gearRatio;
- (Effort*)createSubEffortFromFirstDate:(NSDate*)date1 date:(NSDate*)date2;
- (void)setGear:(NSNumber*)chainring cog:(NSNumber*)cog;

@end
