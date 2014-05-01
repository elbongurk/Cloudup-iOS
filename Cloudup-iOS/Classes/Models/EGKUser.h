//
//  EGKUser.h
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/24/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EGKUser : NSObject

@property (copy, nonatomic) NSString *userID;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *username;
@property (strong, nonatomic) NSArray *avatar;

- (instancetype)initWithJSON:(NSDictionary *)JSONDictionary;

@end
