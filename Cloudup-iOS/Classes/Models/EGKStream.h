//
//  EGKStream.h
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/30/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^EGKStreamFetchItemsCompletionBlock)(NSArray *items);

@interface EGKStream : NSObject

@property (copy, nonatomic) NSString *streamID;
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *items;
@property (copy, nonatomic) NSString *url;
@property (strong, nonatomic) NSDate *created;
@property (strong, nonatomic) NSDate *updated;

+ (NSArray *)streamsWithJSON:(NSArray *)JSONArray;
- (instancetype)initWithJSON:(NSDictionary *)JSONDictionary;

- (void)fetchItemsWithCompletionBlock:(EGKStreamFetchItemsCompletionBlock)block;

@end
