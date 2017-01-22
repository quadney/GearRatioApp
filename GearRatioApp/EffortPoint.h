//
//  EffortPoint.h
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface EffortPoint : NSObject

// note: CLLocation has elevation, time, long and lat
@property (nonatomic, strong) CLLocation* location;
@property (nonatomic, strong) NSNumber* heartrate;
@property (nonatomic, strong) NSNumber* cadence;

- (float)speedAtGearRatio:(float)gearRatio;

@end
