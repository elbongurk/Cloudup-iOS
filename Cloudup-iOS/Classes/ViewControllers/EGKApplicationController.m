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
@property (strong, nonatomic) NSMutableArray *observers;

@end

@implementation EGKApplicationController

- (instancetype)init
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _observers = [NSMutableArray new];
    
    return self;
}

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

    __weak EGKApplicationController *weakSelf = self;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    id observer = [center addObserverForName:EGKDidLoginNotification object:nil
                                       queue:[NSOperationQueue mainQueue]
                                  usingBlock:^(NSNotification *note) {
                                      [weakSelf showStreamController];
                                  }];
    
    [self.observers addObject:observer];
    
    observer = [center addObserverForName:EGKDidLogoutNotification
                                   object:nil
                                    queue:[NSOperationQueue mainQueue]
                               usingBlock:^(NSNotification *note) {
                                   [weakSelf showLoginController];
                               }];
    
    [self.observers addObject:observer];
    
    if ([EGKUserSession currentUserSession]) {
        [self showStreamController];
    }
    else {
        [self showLoginController];
    }
}

- (void)dealloc
{
    for (id observer in self.observers) {
        [[NSNotificationCenter defaultCenter] removeObserver:observer];
    }
}

@end
