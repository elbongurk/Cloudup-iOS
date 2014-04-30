//
//  EGKStream.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/30/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKStream.h"
#import "NSDateFormatter+EGKDefaultDateFormatter.h"

@implementation EGKStream

+ (NSArray *)streamsWithJSON:(NSArray *)JSONArray
{
    NSMutableArray *streams = [NSMutableArray new];
    
    for (NSDictionary *JSONDictionary in JSONArray) {
        EGKStream *stream = [[EGKStream alloc] initWithJSON:JSONDictionary];
        [streams addObject:stream];
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
    _title = JSONDictionary[@"title"];
    _url = JSONDictionary[@"url"];
    _created = [[NSDateFormatter RFC3339DateFormatter]
                dateFromString:JSONDictionary[@"created_at"]];
    _updated = [[NSDateFormatter RFC3339DateFormatter]
                dateFromString:JSONDictionary[@"updated_at"]];
    
    
    
    _items = [NSArray arrayWithArray:JSONDictionary[@"items"]];
    
    return self;
}


@end
