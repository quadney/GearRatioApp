//
//  AnalyzeViewController.m
//  GearRatioApp
//
//  Created by Sydney Richardson on 4/2/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import "AnalyzeViewController.h"

#import "Effort.h"
#import "GraphView.h"

@interface AnalyzeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *dataTextView;
@property (weak, nonatomic) IBOutlet GraphView *graphView;

@property (weak, nonatomic) IBOutlet UILabel *chainringChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cogChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cadenceChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedChangeLabel;

@property (weak, nonatomic) IBOutlet UIStepper *chainringStepper;
@property (weak, nonatomic) IBOutlet UIStepper *cogStepper;
@property (weak, nonatomic) IBOutlet UIStepper *cadenceStepper;
@property (weak, nonatomic) IBOutlet UIStepper *speedStepper;

@property (strong, nonatomic) Effort *changedEffort;

@end

@implementation AnalyzeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSAssert(_effort, @"_effort must exist before initializing AnalyzeViewController");
    
    [self.graphView setEffort:self.effort];
    [self.graphView setNeedsDisplay];
    
    self.chainringStepper.value = self.effort.chainring.doubleValue;
    self.cogStepper.value = self.effort.cog.doubleValue;
    
    [self updateStepperUI];
    
    // set changedEffort to be a copy of recordedEffort
    
    // setup speed/cadence min/max/average to reflect recorded data
    
    // setup initial values for stepper and labels
}

#pragma mark - UIStepper configuration

- (void)updateStepperUI
{
    [self setLabelText:self.chainringChangeLabel forStepper:self.chainringStepper];
    [self setLabelText:self.cogChangeLabel forStepper:self.cogStepper];
    [self setLabelText:self.cadenceChangeLabel forStepper:self.cadenceStepper];
    [self setLabelText:self.speedChangeLabel forStepper:self.speedStepper];
}

- (IBAction)didChangeStepperValue:(id)sender
{
    // change gear ratio and recalculate
    [self updateStepperUI];
}

- (void)setLabelText:(UILabel*)label forStepper:(UIStepper*)stepper
{
    label.text = [NSString stringWithFormat:@"%lu", (long)stepper.value];
}

@end
