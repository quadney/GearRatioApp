//
//  ViewController.m
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import "ViewController.h"

#import "Effort.h"
#import "EffortPoint.h"
#import "GPXFileParser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)didPressButton:(id)sender
{
    // get the file, data, and begin parsing the gpx data
    NSData* fileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"strava_test" ofType:@"gpx"]];
    GPXFileParser* parser = [[GPXFileParser alloc] init];
    Effort* effort = [parser parseData:fileData];
    NSLog(@"Returned Effort: %@", effort);
}

@end
