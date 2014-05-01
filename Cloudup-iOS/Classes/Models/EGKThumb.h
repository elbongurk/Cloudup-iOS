//
//  EGKThumb.h
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/30/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EGKThumb : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSUInteger width;
@property (nonatomic, assign) NSUInteger height;
@property (nonatomic, copy) NSString *format;
@property (nonatomic, copy) NSString *size;


+ (NSArray *)thumbsWithJSON:(NSArray *)JSONArray;
- (instancetype)initWithJSON:(NSDictionary *)JSONDictionary;

@end
