//
//  EGKStream.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/30/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKStream.h"
#import "NSDateFormatter+EGKDefaultDateFormatter.h"
#import "EGKCloudupClient.h"

@interface EGKStream ()

@property (nonatomic, strong) NSArray *fetchedItems;

@end


@implementation EGKStream

+ (NSArray *)streamsWithJSON:(NSArray *)JSONArray
{
    NSMutableArray *streams = [NSMutableArray new];
    
    NSComparator streamComparator = ^NSComparisonResult(EGKStream *stream1, EGKStream *stream2) {
        return [stream2.created compare:stream1.created];
    };
    
    for (NSDictionary *JSONDictionary in JSONArray) {
        EGKStream *stream = [[EGKStream alloc] initWithJSON:JSONDictionary];
        
        NSUInteger index = [streams indexOfObject:stream
                                     inSortedRange:NSMakeRange(0, [streams count])
                                           options:NSBinarySearchingInsertionIndex
                                   usingComparator:streamComparator];
        
        [streams insertObject:stream atIndex:index];
    }
    
    return streams;
}

- (instancetype)initWithJSON:(NSDictionary *)JSONDictionary
{
    self = [super init];
    
    if (!self) {
        return nil;
    }

    _streamID = JSONDictionary[@"id"];
    _url = JSONDictionary[@"url"];
    _created = [[NSDateFormatter RFC3339DateFormatter]
                dateFromString:JSONDictionary[@"created_at"]];
    _updated = [[NSDateFormatter RFC3339DateFormatter]
                dateFromString:JSONDictionary[@"updated_at"]];
    
    [self setTitle:JSONDictionary[@"title"] withDefault:@"Untitled"];
    
    _items = [NSArray arrayWithArray:JSONDictionary[@"items"]];
    
    return self;
}

- (void)setTitle:(NSString *)title withDefault:(NSString *)defaultString
{
    _title = title;
    
    if (![_title length]) {
        _title = defaultString;
    }
}

- (NSString *)description
{
    return self.title;
}

- (void)fetchItemsWithCompletionBlock:(EGKStreamFetchItemsCompletionBlock)block
{
    if (self.fetchedItems) {
        block(self.fetchedItems);
    }
    else {
        [[EGKCloudupClient sharedClient] fetchItemsForStream:self withCompletionBlock:^(NSArray *items) {
            self.fetchedItems = items;
            block(self.fetchedItems);
        }];
    }
}

@end
