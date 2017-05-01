//
//  AnalyzeViewController.m
//  GearRatioApp
//
//  Created by Sydney Richardson on 4/2/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import "AnalyzeViewController.h"

#import "GraphView.h"

@interface AnalyzeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *dataTextView;
@property (weak, nonatomic) IBOutlet GraphView *graphView;

@property (weak, nonatomic) IBOutlet UILabel *chainringChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cogChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cadenceChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedChangeLabel;

@property (strong, nonatomic) Effort *recordedEffort;
@property (strong, nonatomic) Effort *changedEffort;

@end

@implementation AnalyzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSAssert(_recordedEffort, @"_recordedEffort must exist before initializing AnalyzeViewController");
    
    [self.graphView setEffort:self.effort];
    [self.graphView setNeedsDisplay];
    
    // set changedEffort to be a copy of recordedEffort
    
    // setup speed/cadence min/max/average to reflect recorded data
    
    // setup initial values for stepper and labels
}

- (IBAction)didChangeChainring:(id)sender {
    // change gear ratio and recalculate
}

- (IBAction)didChangeCog:(id)sender {
    
}

- (IBAction)didChangeCadence:(id)sender {
    // disable speed if not 0
    // when cadence is affected, every cadence reading in an Effort Point is affected, as well as the speed
}

- (IBAction)didChangeSpeed:(id)sender {
    // disable cadence if not 0
    // when speed is affected, every speed reading is an Effort Point is affected, as well as the cadence
}

@end
