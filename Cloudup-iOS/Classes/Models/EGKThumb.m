//
//  EGKThumb.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/30/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKThumb.h"

@implementation EGKThumb

+ (NSArray *)thumbsWithJSON:(NSArray *)JSONArray
{
    NSMutableArray *thumbs = [NSMutableArray new];
    
    for (NSDictionary *JSONDictionary in JSONArray) {
        EGKThumb *thumb = [[EGKThumb alloc] initWithJSON:JSONDictionary];
        [thumbs addObject:thumb];
    }
    
    return thumbs;
}

- (instancetype)initWithJSON:(NSDictionary *)JSONDictionary
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _url = JSONDictionary[@"url"];
    _width = [JSONDictionary[@"width"] unsignedIntegerValue];
    _height = [JSONDictionary[@"height"] unsignedIntegerValue];
    _format = JSONDictionary[@"format"];

    NSDictionary *size = JSONDictionary[@"size"];
    
    _size = size[@"string"];
    
    return self;
}

@end
