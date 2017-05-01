//
//  ImportViewController.m
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import "ImportViewController.h"

#import "AnalyzeViewController.h"
#import "Effort.h"
#import "EffortPoint.h"
#import "GPXFileParser.h"
#import "GraphView.h"

@interface ImportViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet GraphView *graphView;
@property (weak, nonatomic) IBOutlet UIButton *analyzeButton;

@property (weak, nonatomic) IBOutlet UILabel *chainringLabel;
@property (weak, nonatomic) IBOutlet UILabel *cogLabel;

@property (nonatomic, strong) Effort* calculatedEffort;

@end

@implementation ImportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.graphView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self.graphView action:@selector(didPan:)]];
    
    [self configureAnalyzeButton];
    
    [self didPressResetButton:self];
}

- (IBAction)didPressResetButton:(id)sender
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
        [analyzeVC setEffort:self.graphView.effort];
    }
}

#pragma mark - Stepper outlets

- (IBAction)didChangeChainring:(id)sender {
    // set the gear ratio, and make sure that it affects the graph view's effort
}

- (IBAction)didChangeCog:(id)sender {
}

@end
