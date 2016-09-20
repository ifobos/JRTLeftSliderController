//
//  AppDelegate.m
//  JRTLeftSliderController
//
//  Created by Juan Garcia on 1/7/16.
//  Copyright © 2016 jerti. All rights reserved.
//

#import "AppDelegate.h"
#import "JRTLeftSliderController.h"
#import "ExampleRightViewController.h"
#import "ExampleLeftViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    JRTLeftSliderController *leftSliderController = [JRTLeftSliderController new];
    leftSliderController.leftViewController = [ExampleLeftViewController new];
    leftSliderController.mainViewController = [ExampleRightViewController new];
    leftSliderController.interactiveShowGestureRecognizerEnable = YES;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0e9 * 3), dispatch_get_main_queue(), ^(void) {
        [leftSliderController showLeftContainer:YES animated:YES];
    });
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = leftSliderController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
