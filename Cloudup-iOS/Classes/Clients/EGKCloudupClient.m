//
//  EGKCloudupClient.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/24/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKCloudupClient.h"
#import "EGKUserSession.h"
#import "EGKUser.h"

@implementation EGKCloudupClient

+ (instancetype)sharedClient
{
    static EGKCloudupClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *baseURL = [NSURL URLWithString:ROOT_URL];
        _sharedClient = [[EGKCloudupClient alloc] initWithBaseURL:baseURL];
    });
    
    EGKUserSession *session = [EGKUserSession currentUserSession];
    if (session) {
        [_sharedClient.requestSerializer setAuthorizationHeaderFieldWithUsername:session.username
                                                                        password:session.password];
    }
    
    return _sharedClient;
}

+ (NSURLSessionDataTask *)testUserSession:(EGKUserSession *)userSession
                      withCompletionBlock:(EGKCloudupClientUserSessionCompletionBlock)block
{
    NSURL *baseURL = [NSURL URLWithString:ROOT_URL];
    EGKCloudupClient *client = [[EGKCloudupClient alloc] initWithBaseURL:baseURL];
    
    [client.requestSerializer setAuthorizationHeaderFieldWithUsername:userSession.username
                                                             password:userSession.password];
    
    return [client fetchUserWithCompletionBlock:^(EGKUser *user) {
        block(user != nil);
    }];
}

- (NSURLSessionDataTask *)fetchUserWithCompletionBlock:(EGKCloudupClientUserCompletionBlock)block
{
    return [self GET:@"user"
             parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 EGKUser *user = nil;
                 if ([responseObject isKindOfClass:[NSDictionary class]]) {
                     user = [[EGKUser alloc] initWithJSON:responseObject];
                 }
                 block(user);
             } failure:^(NSURLSessionDataTask *task, NSError *error) {
                 block(nil);
             }];
}



@end
