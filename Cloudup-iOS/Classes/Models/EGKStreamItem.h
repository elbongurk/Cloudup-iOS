//
//  EGKStreamItem.h
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/30/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EGKStreamItemType) {
    EGKStreamItemTypeUnknown,
    EGKStreamItemTypeCode,
    EGKStreamItemTypeFile,
    EGKStreamItemTypeEmbed,
    EGKStreamItemTypeUrl,
    EGKStreamItemTypeArticle
};

@class EGKThumb;

@interface EGKStreamItem : NSObject

@property (copy, nonatomic) NSString *itemID;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *streamID;
@property (assign, nonatomic) EGKStreamItemType type;
@property (copy, nonatomic) NSString *filename;
@property (assign, nonatomic) NSUInteger progress;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *directURL;
@property (copy, nonatomic) NSString *mime;
@property (copy, nonatomic) NSArray *thumbs;
@property (assign, nonatomic) BOOL complete;
@property (strong, nonatomic) NSDate *created;

+ (NSArray *)itemsWithJSON:(NSArray *)JSONArray;
- (instancetype)initWithJSON:(NSDictionary *)JSONDictionary;
- (EGKThumb *)thumbForSize:(NSString *)size;

@end
