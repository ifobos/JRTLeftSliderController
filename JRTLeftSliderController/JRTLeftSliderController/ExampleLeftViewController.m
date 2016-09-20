//
//  ExampleLeftViewController.m
//  JRTLeftSliderController
//
//  Created by Juan Garcia on 9/20/16.
//  Copyright © 2016 jerti. All rights reserved.
//

#import "ExampleLeftViewController.h"
#import "JRTLeftSliderController.h"

@interface ExampleLeftViewController ()
@property (nonatomic, readonly) JRTLeftSliderController *leftSliderController;
@end

@implementation ExampleLeftViewController

- (JRTLeftSliderController *)leftSliderController {
    if ([self.parentViewController isKindOfClass:[JRTLeftSliderController class]]) {
        return (JRTLeftSliderController *)self.parentViewController;
    }
    return nil;
}

- (IBAction)mainAction:(id)sender {
    [self.leftSliderController showLeftContainer:NO animated:YES];
}


@end
