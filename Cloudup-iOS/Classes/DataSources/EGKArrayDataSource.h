//
//  EGKArrayDataSource.h
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/28/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^TableViewCellConfigureBlock)(id cell, id item);

@interface EGKArrayDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithCellIdentifier:(NSString *)aCellIdentifier
                    configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;

- (void)addItems:(NSArray *)items;
- (id)itemForSection:(NSInteger)section;

@end
