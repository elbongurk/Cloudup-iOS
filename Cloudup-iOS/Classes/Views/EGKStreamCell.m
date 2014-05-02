//
//  EGKStreamCell.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/30/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKStreamCell.h"
#import "EGKStreamItemCell.h"
#import "EGKStream.h"
#import "EGKStreamItem.h"
#import "EGKItemDataSource.h"
#import "EGKAppearanceManager.h"

NSString *const EGKStreamCellIdentifier = @"EGKStreamCell";

@interface EGKStreamCell ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) EGKItemDataSource *source;

@end

@implementation EGKStreamCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (!self) {
        return nil;
    }
    
    [self setupViews];
    
    return self;
}

- (void)setupViews
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 60, 0, 60);
    flowLayout.itemSize = CGSizeMake(200, 170);
    
    //TODO: use autolayout here
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)
                                         collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [EGKAppearanceManager tan];
    _collectionView.alwaysBounceHorizontal = YES;
    
    [_collectionView registerClass:[EGKStreamItemCell class]
        forCellWithReuseIdentifier:EGKStreamItemCellIdentifier];
    
    [self.contentView addSubview:_collectionView];
    
    CollectionViewCellConfigureBlock configureCell = ^(EGKStreamItemCell *cell, EGKStreamItem *item) {
        [cell configureForItem:item];
    };
    
    self.source = [[EGKItemDataSource alloc] initWithCellIdentifier:EGKStreamItemCellIdentifier
                                                  configureCellBlock:configureCell];
    
    _collectionView.dataSource = self.source;
}

- (void)configureForStream:(EGKStream *)stream
{
    [stream fetchItemsWithCompletionBlock:^(NSArray *items) {
        [self.source addItems:items];
        [self.collectionView reloadData];
    }];
}

@end
