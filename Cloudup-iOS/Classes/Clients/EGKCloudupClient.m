//
//  EGKCloudupClient.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/24/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKCloudupClient.h"
#import "EGKUserSession.h"

static NSString *const EGKAppSecret = @"yourOwnUniqueAppSecretThatYouShouldRandomlyGenerateAndKeepSecret";

@implementation EGKCloudupClient

+ (instancetype)sharedClient
{
    static EGKCloudupClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // Create a client
        NSURL *baseURL = [NSURL URLWithString:ROOT_URL];
        _sharedClient = [[EGKCloudupClient alloc] initWithBaseURL:baseURL];
        
        // Set the client header fields
        if ([EGKUserSession userID])
            [_sharedClient.requestSerializer setValue:[EGKUserSession userID]
                                   forHTTPHeaderField:@"X-DEVICE-TOKEN"];
        else
            [_sharedClient.requestSerializer setValue:EGKAppSecret
                                   forHTTPHeaderField:@"X-APP-SECRET"];
        
    });
    
    return _sharedClient;
}

@end
