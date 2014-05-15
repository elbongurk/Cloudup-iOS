//
//  EGKStreamItemCell.h
//  Cloudup-iOS
//
//  Created by Ryan Krug on 5/1/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const EGKStreamItemCellIdentifier;

@class EGKStreamItem;

@interface EGKStreamItemCell : UICollectionViewCell

- (void)configureForItem:(EGKStreamItem *)item;

@end
