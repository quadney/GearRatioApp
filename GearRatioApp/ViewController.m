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
#import "GraphView.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *chainringTextField;
@property (weak, nonatomic) IBOutlet UITextField *cogTextField;
@property (weak, nonatomic) IBOutlet GraphView *graphView;

@property (nonatomic, strong) Effort* calculatedEffort;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.graphView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(didPan:)]];
}

- (IBAction)didPressCalculateButton:(id)sender
{
    self.calculatedEffort = [self configureEffortFromFileName:@"strava_1"];
    
    [self.graphView setEffort:self.calculatedEffort];
    [self.graphView setNeedsDisplay];
}

- (Effort*)configureEffortFromFileName:(NSString*)fileName
{
    // get the file, data, and begin parsing the gpx data
    NSData* fileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@"gpx"]];
    GPXFileParser* parser = [[GPXFileParser alloc] init];
    Effort* effort = [parser parseData:fileData];
    effort.gears = @[@([self.chainringTextField.text integerValue]), @([self.cogTextField.text integerValue])];
    return effort;
}

@end
