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

- (void)showController:(UIViewController *)toController
{
    UIViewController *fromController = self.childViewControllers.firstObject;
    
    [fromController willMoveToParentViewController:nil];
    
    [self addChildViewController:toController];
    
    if (fromController) {
        [self transitionFromViewController:fromController
                          toViewController:toController
                                  duration:1.0f
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:nil
                                completion:^(BOOL finished) {
                                    [toController didMoveToParentViewController:self];
                                    [fromController removeFromParentViewController];
                                }];
    }
    else {
        [self.view addSubview:toController.view];
        
        [UIView animateWithDuration:1.0f animations:^{
            toController.view.alpha = 0.0f;
            toController.view.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [toController didMoveToParentViewController:self];
        }];
        
    }
    
}

- (void)showLoginController
{
    [self showController:self.loginController];
}

- (void)showStreamController
{
    [self showController:self.streamNavController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    EGKStreamController *streamController = [EGKStreamController new];
    
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

@end
