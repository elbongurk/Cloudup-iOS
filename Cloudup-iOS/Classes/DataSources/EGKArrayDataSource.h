//
//  EGKArrayDataSource.h
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/28/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CellConfigureBlock)(id cell, id item);

@interface EGKArrayDataSource : NSObject <UITableViewDataSource, UICollectionViewDataSource>

- (instancetype)initWithCellIdentifier:(NSString *)aCellIdentifier
                    configureCellBlock:(CellConfigureBlock)aConfigureCellBlock;

- (void)addItems:(NSArray *)items;
- (id)itemForIndexPath:(NSIndexPath *)path;

@end
