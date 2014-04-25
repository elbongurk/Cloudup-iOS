//
//  EGKAppDelegate.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/22/14
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKAppDelegate.h"
#import "EGKApplicationController.h"

@implementation EGKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.rootViewController = [EGKApplicationController new];

    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
