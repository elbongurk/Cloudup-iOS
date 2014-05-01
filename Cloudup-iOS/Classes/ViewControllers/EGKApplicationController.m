//
//  EGKApplicationController.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/23/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKApplicationController.h"
#import "EGKLoginController.h"
#import "EGKStreamController.h"
#import "EGKUserSession.h"

NSString *const EGKDidLoginNotification = @"EGKDidLoginNotification";
NSString *const EGKDidLogoutNotification = @"EGKDidLogoutNotification";

@interface EGKApplicationController ()

@property (strong, nonatomic) EGKLoginController *loginController;
@property (strong, nonatomic) UINavigationController *streamNavController;

@end

@implementation EGKApplicationController

- (void)showLoginController
{
    if (self.streamNavController.parentViewController == self) {
        [self.streamNavController.view removeFromSuperview];
        [self.streamNavController removeFromParentViewController];
    }
    
    //TODO: Should handle animations
    
    [self addChildViewController:self.loginController];
    [self.view addSubview:self.loginController.view];
    [self.loginController didMoveToParentViewController:self];
}

- (void)showStreamController
{
    if (self.loginController.parentViewController == self) {
        [self.loginController.view removeFromSuperview];
        [self.loginController removeFromParentViewController];
    }

    //TODO: Should handle animations
    
    [self addChildViewController:self.streamNavController];
    [self.view addSubview:self.streamNavController.view];
    [self.streamNavController didMoveToParentViewController:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    EGKStreamController *streamController = [[EGKStreamController alloc] initWithStyle:UITableViewStyleGrouped];
    
    self.loginController = [EGKLoginController new];
    self.streamNavController = [[UINavigationController alloc] initWithRootViewController:streamController];

    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserverForName:EGKDidLoginNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self showStreamController];
    }];
    
    [center addObserverForName:EGKDidLogoutNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self showLoginController];
    }];
    
    if ([EGKUserSession currentUserSession]) {
        [self showStreamController];
    }
    else {
        [self showLoginController];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
