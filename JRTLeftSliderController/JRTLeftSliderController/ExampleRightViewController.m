//
//  ExampleRightViewController.m
//  JRTLeftSliderController
//
//  Created by Juan Garcia on 9/20/16.
//  Copyright © 2016 jerti. All rights reserved.
//

#import "ExampleRightViewController.h"
#import "JRTLeftSliderController.h"

@interface ExampleRightViewController ()
@property (nonatomic, readonly) JRTLeftSliderController *leftSliderController;
@end

@implementation ExampleRightViewController

- (JRTLeftSliderController *)leftSliderController {
    if ([self.parentViewController isKindOfClass:[JRTLeftSliderController class]]) {
        return (JRTLeftSliderController *)self.parentViewController;
    }
    return nil;
}

- (IBAction)menuAction:(id)sender {
    [self.leftSliderController showLeftContainer:YES animated:YES];
}

@end
