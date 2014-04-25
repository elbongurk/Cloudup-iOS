//
//  EGKUserSession.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/24/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKUserSession.h"
#import "EGKUser.h"
#import <SSKeychain/SSKeychain.h>

static NSString *const EGKCurrentUserSessionKey = @"com.elbongurk.cloudup.currentUserSession";
static NSString *const EGKServiceKey = @"Cloudup";

static EGKUserSession *_currentUserSession = nil;

@implementation EGKUserSession

+ (instancetype)currentUserSession
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *username = [[NSUserDefaults standardUserDefaults] valueForKey:EGKCurrentUserSessionKey];
        if (username) {
            NSString *password = [SSKeychain passwordForService:EGKServiceKey account:username];
            if (password) {
                _currentUserSession = [[EGKUserSession alloc] initWithPassword:password forUsername:username];
            }
        }
    });
    
    return _currentUserSession;
}

- (id)initWithPassword:(NSString *)password forUsername:(NSString *)username
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _username = [username copy];
    _password = [password copy];
    
    return self;
}

- (BOOL)useSession
{
    if ([SSKeychain setPassword:self.password forService:EGKServiceKey account:self.username]) {
        [[NSUserDefaults standardUserDefaults] setValue:self.username forKey:EGKCurrentUserSessionKey];
        _currentUserSession = self;
        return YES;
    }
    
    return NO;
}

- (void)clearSession
{
    if (_currentUserSession == self) {
        _currentUserSession = nil;
    }
}

@end
