//
//  EGKArrayDataSource.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/28/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKArrayDataSource.h"

@interface EGKArrayDataSource ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;

@end

@implementation EGKArrayDataSource

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithCellIdentifier:(NSString *)aCellIdentifier
                    configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock
{
    self = [super init];
    
    if (!self) {
        return nil;
    }

    _items = [NSMutableArray new];
    _cellIdentifier = aCellIdentifier;
    _configureCellBlock = aConfigureCellBlock;

    return self;
}

- (id)itemForSection:(NSInteger)section
{
    return self.items[(NSUInteger)section];
}

- (void)addItems:(NSArray *)items
{
    [self.items addObjectsFromArray:items];
}


#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return (NSInteger)self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    id item = [self itemForSection:section];
    return [item description];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    
    id item = [self itemForSection:indexPath.section];
    self.configureCellBlock(cell, item);
    return cell;
}

@end
