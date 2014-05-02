//
//  EGKStreamCell.h
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/30/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EGKStream;

extern NSString *const EGKStreamCellIdentifier;

@interface EGKStreamCell : UITableViewCell

- (void)configureForStream:(EGKStream *)stream;

@end
