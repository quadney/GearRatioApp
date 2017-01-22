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

@interface GPXFileParser() <NSXMLParserDelegate>

@property (nonatomic, strong) NSXMLParser* parser;
@property (nonatomic, strong) Effort* parsedEffort;
@property (nonatomic, strong) NSMutableDictionary<NSString*, id>* currentElement;
@property (nonatomic, strong) NSString* currentElementKey;

@end

@implementation GPXFileParser

- (Effort*)parseData:(NSData*)gpxData
{
    self.parser = [[NSXMLParser alloc] initWithData:gpxData];
    self.parser.delegate = self;
    [self.parser parse];
    
    return self.parsedEffort;
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    NSLog(@"Starting parsing of document");
    self.parsedEffort = [[Effort alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"Completed parsing document");
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict
{
    NSLog(@"on element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"end element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSLog(@"Found characters: %@", string);
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"%@", [parseError localizedDescription]);
}

@end
