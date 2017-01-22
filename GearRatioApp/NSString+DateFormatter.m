//
//  NSString+DateFormatter.m
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import "NSString+DateFormatter.h"

static NSDateFormatter* date_formatter(void);

@implementation NSString (DateFormatter)

- (NSDate*)formatDateString
{
    NSDateFormatter* formatter = date_formatter();
    return [formatter dateFromString:self];
}

static NSDateFormatter* date_formatter(void)
{
    static NSDateFormatter* defaultDateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultDateFormatter = [[NSDateFormatter alloc] init];
        [defaultDateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        [defaultDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [defaultDateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    });
    return defaultDateFormatter;
}

@end
