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
    _title = JSONDictionary[@"title"];
    _filename = JSONDictionary[@"filename"];
    _progress = [JSONDictionary[@"progress"] unsignedIntegerValue];
    _url = JSONDictionary[@"url"];
    _directURL = JSONDictionary[@"direct_url"];
    _mime = JSONDictionary[@"mime"];
    _complete = [JSONDictionary[@"complete"] boolValue];
    _created = [[NSDateFormatter RFC3339DateFormatter]
                dateFromString:JSONDictionary[@"created_at"]];

    NSString *thumbUrl = JSONDictionary[@"thumb_url"];
    if (thumbUrl) {
        _thumbUrl = [[EGKThumb alloc] initWithUrl:thumbUrl];
    }

    _thumbs = [EGKThumb thumbsWithJSON:JSONDictionary[@"thumbs"]];
    
    [self setTypeWithString:JSONDictionary[@"type"]];

    _oembedUrl = JSONDictionary[@"oembed_url"];
    _oembedProviderName = JSONDictionary[@"oembed_provider_name"];
    
    NSString *oembedThumbUrl = JSONDictionary[@"oembed_thumbnail_url"];
    if (oembedThumbUrl) {
        _oembedThumbUrl = [[EGKThumb alloc] initWithUrl:oembedThumbUrl];
    }
    
    [self setOembedTypeWithString:JSONDictionary[@"oembed_type"]];

    return self;
}

- (void)setOembedTypeWithString:(NSString *)oembedType
{
    if ([oembedType isEqualToString:@"photo"]) {
        _oembedType = EGKStreamItemOembedTypePhoto;
    }
    else if ([oembedType isEqualToString:@"video"]) {
        _oembedType = EGKStreamItemOembedTypeVideo;
    }
    else if ([oembedType isEqualToString:@"link"]) {
        _oembedType = EGKStreamItemOembedTypeLink;
    }
    else if ([oembedType isEqualToString:@"rich"]) {
        _oembedType = EGKStreamItemOembedTypeRich;
    }
    else {
        _oembedType = EGKStreamItemOembedTypeUnknown;
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

- (EGKThumb *)thumbForSize:(EGKThumbSize)size
{
    EGKThumb *found = nil;
    
    for (EGKThumb *thumb in self.thumbs) {
        if (thumb.size >= size) {
            return thumb;
        }
        found = thumb;
    }
    
    if (!found) {
        found = self.oembedThumbUrl;
    }
    
    if (!found) {
        found = self.thumbUrl;
    }
    
    return found;
}

- (BOOL)isImage
{
    BOOL imageFile = self.type == EGKStreamItemTypeFile &&
    [self.mime hasPrefix:@"image"];

    BOOL imageEmbed = self.type == EGKStreamItemTypeEmbed &&
    self.oembedType == EGKStreamItemOembedTypePhoto;
    
    return imageFile || imageEmbed;
}

- (BOOL)isVideo
{
    BOOL videoFile = self.type == EGKStreamItemTypeFile &&
    [self.mime hasPrefix:@"video"];
    
    BOOL videoEmbed = self.type == EGKStreamItemTypeEmbed &&
    self.oembedType == EGKStreamItemOembedTypeVideo;
    
    return videoFile || videoEmbed;
}

- (BOOL)isAudio
{
    BOOL audioFile = self.type == EGKStreamItemTypeFile &&
    [self.mime hasPrefix:@"audio"];
    
    return audioFile;
}

- (BOOL)isText
{
    return self.type == EGKStreamItemTypeCode;
}

- (BOOL)isLink
{
    BOOL link = self.type == EGKStreamItemTypeArticle ||
    self.type == EGKStreamItemTypeUrl;
    
    BOOL linkEmbed = self.type == EGKStreamItemTypeEmbed &&
    self.oembedType == EGKStreamItemOembedTypeLink;
    
    return link || linkEmbed;
}



@end
