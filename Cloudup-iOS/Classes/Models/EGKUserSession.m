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

static NSString *const EGKServiceKey = @"Cloudup";

static EGKUserSession *_currentUserSession = nil;

@implementation EGKUserSession

+ (instancetype)currentUserSession
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSDictionary *account = [[SSKeychain accountsForService:EGKServiceKey] lastObject];
        if (account) {
            NSString *username = account[kSSKeychainAccountKey];
            NSString *password = [SSKeychain passwordForService:EGKServiceKey account:username];
            _currentUserSession = [[EGKUserSession alloc] initWithPassword:password forUsername:username];
        }
    });
    
    return _currentUserSession;
}

- (instancetype)initWithPassword:(NSString *)password forUsername:(NSString *)username
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _username = username;
    _password = password;
    
    return self;
}

- (BOOL)useSession
{
    if ([SSKeychain setPassword:self.password forService:EGKServiceKey account:self.username]) {
        _currentUserSession = self;
        return YES;
    }
    
    return NO;
}

- (BOOL)clearSession
{
    if (_currentUserSession == self &&
        [SSKeychain deletePasswordForService:EGKServiceKey account:self.username]) {
        _currentUserSession = nil;
        return YES;
    }
    
    return NO;
}

@end
