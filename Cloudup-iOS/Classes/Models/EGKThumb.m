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
    
    NSComparator thumbComparator = ^NSComparisonResult(EGKThumb *item1, EGKThumb *item2) {
        return item1.size - item2.size;
    };

    for (NSDictionary *JSONDictionary in JSONArray) {
        EGKThumb *thumb = [[EGKThumb alloc] initWithJSON:JSONDictionary];

        NSUInteger index = [thumbs indexOfObject:thumb
                                  inSortedRange:NSMakeRange(0, [thumbs count])
                                        options:NSBinarySearchingInsertionIndex
                                usingComparator:thumbComparator];
        
        
        [thumbs insertObject:thumb atIndex:index];
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

    [self setSizeWithString:size[@"string"]];
    
    return self;
}

- (instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _url = url;
    
    return self;
}

- (void)setSizeWithString:(NSString *)size
{
    if ([size isEqualToString:@"50x50"]) {
        _size = EGKThumbSize50X50;
    }
    else if ([size isEqualToString:@"150x150"]) {
        _size = EGKThumbSize150X150;
    }
    else if ([size isEqualToString:@"300x300"]) {
        _size = EGKThumbSize300X300;
    }
    else if ([size isEqualToString:@"600x600"]) {
        _size = EGKThumbSize600X600;
    }
    else if ([size isEqualToString:@"900x900"]) {
        _size = EGKThumbSize900X900;
    }
    else if ([size isEqualToString:@"1200x1200"]) {
        _size = EGKThumbSize1200X1200;
    }
    else if ([size isEqualToString:@"2000x2000"]) {
        _size = EGKThumbSize2000X2000;
    }
    else if ([size isEqualToString:@"3000x3000"]) {
        _size = EGKThumbSize3000X3000;
    }
    else {
        _size = EGKThumbSizeUnknown;
    }
}


@end
