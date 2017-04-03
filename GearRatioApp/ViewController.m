//
//  ViewController.m
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import "ViewController.h"

#import "AnalyzeViewController.h"
#import "Effort.h"
#import "EffortPoint.h"
#import "GPXFileParser.h"
#import "GraphView.h"

@interface ViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet GraphView *graphView;
@property (weak, nonatomic) IBOutlet UIButton *analyzeButton;

@property (nonatomic, strong) Effort* calculatedEffort;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.graphView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(didPan:)]];
    
    [self configureAnalyzeButton];
}

- (IBAction)didPressCalculateButton:(id)sender
{
    self.calculatedEffort = [self configureEffortFromFileName:@"strava_1"];
    
    [self.graphView setEffort:self.calculatedEffort];
    [self.graphView setNeedsDisplay];
    
    [self configureAnalyzeButton];
}

- (Effort*)configureEffortFromFileName:(NSString*)fileName
{
    // get the file, data, and begin parsing the gpx data
    NSData* fileData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:fileName ofType:@"gpx"]];
    GPXFileParser* parser = [[GPXFileParser alloc] init];
    return [parser parseData:fileData];
}

- (void)configureAnalyzeButton
{
    [self.analyzeButton setEnabled:self.calculatedEffort ? YES : NO];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:NSStringFromClass([AnalyzeViewController class])]) {
        AnalyzeViewController* analyzeVC = (AnalyzeViewController*)[segue destinationViewController];
        // this is terrible design but whatever
        [analyzeVC setEffort:self.graphView.effort];
    }
}

@end
