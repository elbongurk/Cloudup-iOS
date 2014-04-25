//
//  EGKUserSession.h
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/24/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EGKUserSession : NSObject

@property (readonly, nonatomic) NSString *username;
@property (readonly, nonatomic) NSString *password;

+ (EGKUserSession *)currentUserSession;

- (id)initWithPassword:(NSString *)password forUsername:(NSString *)username;
- (BOOL)useSession;
- (void)clearSession;

@end
