//
//  EGKStreamCell.h
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/30/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const EGKStreamCellIdentifier;

@class EGKStream;
@class EGKStreamItem;

@protocol EGKStreamCellDelegate <NSObject>

@optional

- (void)didSelectStreamItem:(EGKStreamItem *)item fromStream:(EGKStream *)stream;

@end

@interface EGKStreamCell : UITableViewCell

@property (assign, nonatomic) id <EGKStreamCellDelegate> delegate;

- (void)configureForStream:(EGKStream *)stream;

@end
