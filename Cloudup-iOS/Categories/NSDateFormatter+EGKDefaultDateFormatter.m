//
//  NSDateFormatter+EGKDefaultDateFormatter.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/30/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "NSDateFormatter+EGKDefaultDateFormatter.h"

@implementation NSDateFormatter (EGKDefaultDateFormatter)

+ (instancetype)RFC3339DateFormatter
{
    static NSDateFormatter *dateFormatter = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        NSLocale *enUSPOSIXLocale = [[NSLocale alloc]
                                     initWithLocaleIdentifier:@"en_US_POSIX"];
        
        [dateFormatter setLocale:enUSPOSIXLocale];
        [dateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    });
    
    return dateFormatter;
}

@end
