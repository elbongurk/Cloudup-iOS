//
//  EGKItemDataSource.h
//  Cloudup-iOS
//
//  Created by Ryan Krug on 5/1/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CollectionViewCellConfigureBlock)(id cell, id item);

@interface EGKItemDataSource : NSObject <UICollectionViewDataSource>

- (instancetype)initWithCellIdentifier:(NSString *)aCellIdentifier
                    configureCellBlock:(CollectionViewCellConfigureBlock)aConfigureCellBlock;

- (void)addItems:(NSArray *)items;
- (id)itemForIndexPath:(NSIndexPath *)indexPath;

@end
