//
//  GraphView.h
//  GearRatioApp
//
//  Created by Sydney Richardson on 1/22/17.
//  Copyright © 2017 Sydney Richardson. All rights reserved.
//

@import UIKit;

@class Effort;

@interface GraphView : UIView

@property (nonatomic, strong) Effort* effort;

- (void)didPan:(UIGestureRecognizer*)gestureRecognizer;
- (void)shoudEnableSelectionGesture:(BOOL)enabled;

@end
