//
//  EGKApplicationController.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/23/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKApplicationController.h"
#import "EGKLoginController.h"

@interface EGKApplicationController ()

@property (strong, nonatomic) EGKLoginController *loginController;

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

    self.view.backgroundColor = [UIColor blackColor];
    
    //would be cool here to do a animation that ends in showing the login controller
    
    self.loginController = [EGKLoginController new];

    [self addChildViewController:self.loginController];
    [self.view addSubview:self.loginController.view];
    [self.loginController didMoveToParentViewController:self];
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
