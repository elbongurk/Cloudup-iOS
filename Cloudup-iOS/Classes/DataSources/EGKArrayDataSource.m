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
@property (nonatomic, copy) CellConfigureBlock configureCellBlock;

@end

@implementation EGKArrayDataSource

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithCellIdentifier:(NSString *)aCellIdentifier
                    configureCellBlock:(CellConfigureBlock)aConfigureCellBlock
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

- (id)itemForIndexPath:(NSIndexPath *)path
{
    return self.items[(NSUInteger)path.item];
}

- (void)addItems:(NSArray *)items
{
    [self.items removeAllObjects];
    [self.items addObjectsFromArray:items];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (NSInteger)self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier
                                                            forIndexPath:indexPath];
    
    id item = [self itemForIndexPath:indexPath];
    self.configureCellBlock(cell, item);

    return cell;
}

#pragma mark UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (NSInteger)self.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier
                                                                           forIndexPath:indexPath];
    
    id item = [self itemForIndexPath:indexPath];
    self.configureCellBlock(cell, item);
    
    return cell;
}


@end
