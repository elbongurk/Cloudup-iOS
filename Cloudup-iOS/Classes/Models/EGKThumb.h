//
//  EGKThumb.h
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/30/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EGKThumbSize) {
    EGKThumbSizeUnknown,
    EGKThumbSize50X50,
    EGKThumbSize150X150,
    EGKThumbSize300X300,
    EGKThumbSize600X600,
    EGKThumbSize900X900,
    EGKThumbSize1200X1200,
    EGKThumbSize2000X2000,
    EGKThumbSize3000X3000
};

@interface EGKThumb : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSUInteger width;
@property (nonatomic, assign) NSUInteger height;
@property (nonatomic, copy) NSString *format;
@property (nonatomic, assign) EGKThumbSize size;


+ (NSArray *)thumbsWithJSON:(NSArray *)JSONArray;
- (instancetype)initWithJSON:(NSDictionary *)JSONDictionary;
- (instancetype)initWithUrl:(NSString *)url;

@end
