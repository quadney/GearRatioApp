//
//  AnalyzeViewController.m
//  GearRatioApp
//
//  Created by Sydney Richardson on 4/2/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

#import "AnalyzeViewController.h"

#import "GraphView.h"

@interface AnalyzeViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *gearPickerView;
@property (weak, nonatomic) IBOutlet GraphView *graphView;

@property (strong, nonatomic) NSArray* chainrings;
@property (strong, nonatomic) NSArray* cogs;
@end

@implementation AnalyzeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.graphView setEffort:self.effort];
    [self.graphView setNeedsDisplay];
    
    self.chainrings = @[@54, @53, @52, @51, @50, @49, @48, @47, @46];
    self.cogs = @[@17, @16, @15, @14, @13, @12, @11];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [self.chainrings count];
            break;
        case 1:
            return [self.cogs count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%li", (long) [self.chainrings[row] integerValue]];
            break;
        case 1:
            return [NSString stringWithFormat:@"%li", (long) [self.cogs[row] integerValue]];
            break;
        default:
            return @"";
            break;
    }
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //TODO:
}

@end
