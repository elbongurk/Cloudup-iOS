//
//  EGKUser.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/24/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKUser.h"

@implementation EGKUser

- (instancetype)initWithJSON:(NSDictionary *)JSONDictionary
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _userID = JSONDictionary[@"id"];
    _name = JSONDictionary[@"name"];
    _username = JSONDictionary[@"username"];

    return self;
}

@end
