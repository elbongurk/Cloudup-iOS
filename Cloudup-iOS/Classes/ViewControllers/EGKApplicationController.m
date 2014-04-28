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

@interface EGKApplicationController ()
@property (strong, nonatomic) EGKLoginController *loginController;
@property (strong, nonatomic) UINavigationController *streamNavController;
@end

@implementation EGKApplicationController

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //create controllers
    self.loginController = [EGKLoginController new];
    self.streamNavController = [[UINavigationController alloc] initWithRootViewController:[EGKStreamController new]];

    //setup login (need to check about this)
    [self addChildViewController:self.loginController];
    [self.view addSubview:self.loginController.view];
    [self.loginController didMoveToParentViewController:self];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserverForName:EGKDidLoginNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        //login done show the next controller
        [self.loginController.view removeFromSuperview];
        [self.loginController removeFromParentViewController];
        
        [self addChildViewController:self.streamNavController];
        [self.view addSubview:self.streamNavController.view];
        [self.streamNavController didMoveToParentViewController:self];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}


@end
