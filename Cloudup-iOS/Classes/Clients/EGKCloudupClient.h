//
//  EGKCloudupClient.h
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/24/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "AFHTTPSessionManager.h"
@class EGKUser;
@class EGKUserSession;
@class EGKStream;

typedef void(^EGKCloudupClientUserCompletionBlock)(EGKUser *user);
typedef void(^EGKCloudupClientUserSessionCompletionBlock)(BOOL authenticated);
typedef void(^EGKCloudupClientStreamsCompletionBlock)(NSArray *streams);
typedef void(^EGKCloudupClientStreamItemsCompletionBlock)(NSArray *items);

@interface EGKCloudupClient : AFHTTPSessionManager

+ (instancetype)sharedClient;
+ (NSURLSessionDataTask *)testUserSession:(EGKUserSession *)userSession
                      withCompletionBlock:(EGKCloudupClientUserSessionCompletionBlock)block;

- (NSURLSessionDataTask *)fetchUserWithCompletionBlock:(EGKCloudupClientUserCompletionBlock)block;
- (NSURLSessionDataTask *)fetchStreamsWithCompletionBlock:(EGKCloudupClientStreamsCompletionBlock)block;
- (NSURLSessionDataTask *)fetchItemsForStream:(EGKStream *)stream
                          withCompletionBlock:(EGKCloudupClientStreamItemsCompletionBlock)block;
- (NSURLSessionDataTask *)fetchItemsWithCompletionBlock:(EGKCloudupClientStreamItemsCompletionBlock)block;

@end
