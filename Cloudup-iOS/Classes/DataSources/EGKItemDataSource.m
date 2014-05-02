//
//  EGKItemDataSource.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 5/1/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKItemDataSource.h"

@interface EGKItemDataSource ()

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) CollectionViewCellConfigureBlock configureCellBlock;

@end


@implementation EGKItemDataSource

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithCellIdentifier:(NSString *)aCellIdentifier
                    configureCellBlock:(CollectionViewCellConfigureBlock)aConfigureCellBlock
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

- (void)addItems:(NSArray *)items
{
    [self.items removeAllObjects];
    [self.items addObjectsFromArray:items];
}

- (id)itemForIndexPath:(NSIndexPath *)indexPath
{
    return self.items[(NSUInteger)indexPath.item];
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
