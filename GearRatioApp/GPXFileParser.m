//
//  GPXFileParser.m
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import "GPXFileParser.h"

#import "Effort.h"
#import "EffortPoint.h"
#import "NSString+DateFormatter.h"

@interface GPXFileParser() <NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser* parser;
@property (nonatomic, strong) EffortPoint* currentEffortPoint;
@property (nonatomic, strong) NSString* currentEffortPointKey;
@property (nonatomic, strong) NSMutableArray<EffortPoint*>* parsedEffortPoints;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSDate* effortDate;

@end

@implementation GPXFileParser

- (Effort*)parseData:(NSData*)gpxData
{
    self.parser = [[NSXMLParser alloc] initWithData:gpxData];
    self.parser.delegate = self;
    [self.parser parse];
    
    return [self createEffortFromCollectedData];
}

- (Effort*)createEffortFromCollectedData
{
    Effort* effort = [[Effort alloc] init];
    effort.time = self.effortDate;
    effort.title = self.title;
    effort.effortPoints = [self.parsedEffortPoints copy];
    
    return effort;
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.title = nil;
    self.effortDate = nil;
    self.currentEffortPoint = nil;
    self.parsedEffortPoints = [NSMutableArray new];
    self.currentEffortPointKey = nil;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    //trkpt is new EffortPoint
    if ([elementName isEqualToString:@"trkpt"]) {
        // current element is new EffortPoint
        self.currentEffortPoint = [[EffortPoint alloc] initWithLatLongAttributes:attributeDict];
    }
    else {
        self.currentEffortPointKey = elementName;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // if element name is trkpt, then need to save the current element to the dictionary
    if ([elementName isEqualToString:@"trkpt"]) {
        [self.parsedEffortPoints addObject:self.currentEffortPoint];
        self.currentEffortPoint = nil;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([string length] < 1) {
        return;
    }
    
    if ([self.currentEffortPointKey isEqualToString:@"ele"]) {
        self.currentEffortPoint.elevation = @([string doubleValue]);
    }
    else if ([self.currentEffortPointKey isEqualToString:@"time"]) {
        NSDate* formattedDate = [string formatDateString];
        if (self.currentEffortPoint) {
            // it's the time of the current Element
            self.currentEffortPoint.pointDate = formattedDate;
        }
        else {
            self.effortDate = formattedDate;
        }
    }
    else if ([self.currentEffortPointKey isEqualToString:@"gpxtpx:hr"]) {
        self.currentEffortPoint.heartrate = @([string integerValue]);
    }
    else if ([self.currentEffortPointKey isEqualToString:@"gpxtpx:cad"]) {
        self.currentEffortPoint.cadence = @([string integerValue]);
    }
    else if ([self.currentEffortPointKey isEqualToString:@"name"]) {
        self.title = string;
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%@", [parseError localizedDescription]);
}

@end
