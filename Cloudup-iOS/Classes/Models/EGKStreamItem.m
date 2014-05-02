//
//  EGKStreamItem.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/30/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKStreamItem.h"
#import "EGKThumb.h"
#import "NSDateFormatter+EGKDefaultDateFormatter.h"

@implementation EGKStreamItem

+ (NSArray *)itemsWithJSON:(NSArray *)JSONArray
{
    NSMutableArray *items = [NSMutableArray new];
    
    NSComparator itemComparator = ^NSComparisonResult(EGKStreamItem *item1, EGKStreamItem *item2) {
        return [item1.created compare:item2.created];
    };
    
    for (NSDictionary *JSONDictionary in JSONArray) {
        EGKStreamItem *item = [[EGKStreamItem alloc] initWithJSON:JSONDictionary];
        
        NSUInteger index = [items indexOfObject:item
                                    inSortedRange:NSMakeRange(0, [items count])
                                          options:NSBinarySearchingInsertionIndex
                                  usingComparator:itemComparator];
        
        [items insertObject:item atIndex:index];
    }
    
    return items;
}

- (instancetype)initWithJSON:(NSDictionary *)JSONDictionary
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _itemID = JSONDictionary[@"id"];
    _streamID = JSONDictionary[@"stream_id"];
    _filename = JSONDictionary[@"filename"];
    _progress = [JSONDictionary[@"progress"] unsignedIntegerValue];
    _url = JSONDictionary[@"url"];
    _directURL = JSONDictionary[@"direct_url"];
    _mime = JSONDictionary[@"mime"];
    _complete = [JSONDictionary[@"complete"] boolValue];
    _created = [[NSDateFormatter RFC3339DateFormatter]
                dateFromString:JSONDictionary[@"created_at"]];
    
    [self setTitle:JSONDictionary[@"title"] withDefault:@"Unknown"];
    [self setTypeWithString:JSONDictionary[@"type"]];

    _thumbs = [EGKThumb thumbsWithJSON:JSONDictionary[@"thumbs"]];
    
    return self;
}

- (void)setTitle:(NSString *)title withDefault:(NSString *)defaultString
{
    _title = title;
    
    if (![_title length]) {
        _title = defaultString;
    }
}

- (void)setTypeWithString:(NSString *)type
{
    if ([type isEqualToString:@"code"]) {
        _type = EGKStreamItemTypeCode;
    }
    else if ([type isEqualToString:@"file"]) {
        _type = EGKStreamItemTypeFile;
    }
    else if ([type isEqualToString:@"embed"]) {
        _type = EGKStreamItemTypeEmbed;
    }
    else if ([type isEqualToString:@"url"]) {
        _type = EGKStreamItemTypeUrl;
    }
    else if ([type isEqualToString:@"article"]) {
        _type = EGKStreamItemTypeArticle;
    }
    else {
        _type = EGKStreamItemTypeUnknown;
    }
}

- (EGKThumb *)thumbForSize:(NSString *)size
{
    for (EGKThumb *thumb in self.thumbs) {
        if ([thumb.size isEqualToString:size]) {
            return thumb;
        }
    }
    
    return nil;
}


@end
