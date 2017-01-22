//
//  GPXFileParser.h
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Effort;

@interface GPXFileParser : NSObject

- (Effort*)parseData:(NSData*)gpxData;

@end
