//
//  EGKLoginController.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/22/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKLoginController.h"
#import "EGKAppearanceManager.h"

@interface EGKLoginController ()
@property (strong, nonatomic) UITextField *emailText;
@property (strong, nonatomic) UITextField *passwordText;
@end

@implementation EGKLoginController

- (id)init
{
    if (self = [super init]) {
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [EGKAppearanceManager orange];
    
    self.emailText = [UITextField new];
    self.emailText.placeholder = @"Username / Email";
    self.emailText.borderStyle = UITextBorderStyleRoundedRect;
    self.emailText.backgroundColor = [UIColor whiteColor];
    self.emailText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailText.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.emailText];

    self.passwordText = [UITextField new];
    self.passwordText.placeholder = @"Password";
    self.passwordText.secureTextEntry = YES;
    self.passwordText.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordText.backgroundColor = [UIColor whiteColor];
    self.passwordText.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.passwordText];

    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cloudup-white-logo"]];
    logoView.contentMode = UIViewContentModeCenter;
    logoView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:logoView];
    
    UIButton *loginButton = [UIButton new];
    [loginButton setTitle:[@"Login" uppercaseString] forState:UIControlStateNormal];
    loginButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    loginButton.backgroundColor = [EGKAppearanceManager blue];
    loginButton.layer.cornerRadius = 3.0;
    loginButton.translatesAutoresizingMaskIntoConstraints = NO;
    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];
    
    NSDictionary *map = @{ @"logo": logoView,
                           @"email": self.emailText,
                           @"password": self.passwordText,
                           @"login": loginButton };
    
    NSArray *constriants = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[email]-20-|" options:0 metrics:nil views:map];
    [self.view addConstraints:constriants];

    constriants = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[logo]|" options:0 metrics:nil views:map];
    [self.view addConstraints:constriants];
    
    constriants = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[password]-20-|" options:0 metrics:nil views:map];
    [self.view addConstraints:constriants];

    constriants = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[login]-20-|" options:0 metrics:nil views:map];
    [self.view addConstraints:constriants];

    constriants = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-130-[logo]-40-[email(==32)]-10-[password(==email)]-10-[login(==40)]" options:0 metrics:nil views:map];
    [self.view addConstraints:constriants];
}

- (void)login:(id)sender
{
    
}

@end
