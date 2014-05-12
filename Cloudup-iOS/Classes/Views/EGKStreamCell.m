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
#import "EGKArrayDataSource.h"
#import "EGKAppearanceManager.h"

NSString *const EGKStreamCellIdentifier = @"EGKStreamCell";

@interface EGKStreamCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) EGKArrayDataSource *source;

@end

@implementation EGKStreamCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (!self) {
        return nil;
    }
    
    self.contentView.backgroundColor = [EGKAppearanceManager tan];
    
    [self setupTitleLabel];
    [self setupCountLabel];
    [self setupCollectionDataSource];
    [self setupCollectionView];
    
    return self;
}

- (void)setupTitleLabel
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 200, 20)];
    _titleLabel.textColor = [EGKAppearanceManager textGrey];
    _titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    [self.contentView addSubview:_titleLabel];
}

- (void)setupCountLabel
{
    _countLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 10, 80, 20)];
    _countLabel.textColor = [EGKAppearanceManager textGrey];
    _countLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    _countLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_countLabel];
}

- (void)setupCollectionDataSource
{
    CellConfigureBlock configureCell = ^(EGKStreamItemCell *cell, EGKStreamItem *item) {
        [cell configureForItem:item];
    };
    
    _source = [[EGKArrayDataSource alloc] initWithCellIdentifier:EGKStreamItemCellIdentifier
                                              configureCellBlock:configureCell];
}

- (void)setupCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 60, 0, 60);
    flowLayout.itemSize = CGSizeMake(200, 170);
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, 320, 180)
                                         collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [EGKAppearanceManager tan];
    _collectionView.alwaysBounceHorizontal = YES;
    
    [_collectionView registerClass:[EGKStreamItemCell class]
        forCellWithReuseIdentifier:EGKStreamItemCellIdentifier];
    
    _collectionView.dataSource = self.source;

    [self.contentView addSubview:_collectionView];
}

- (void)configureForStream:(EGKStream *)stream
{
    NSString *title = stream.title.length > 0 ? stream.title : @"Untitled";
    self.titleLabel.text = [title uppercaseString];
    
    NSString *item = stream.items.count != 1 ? @"ITEMS" : @"ITEM";
    NSString *count = [NSString stringWithFormat:@"%d %@", stream.items.count, item];
    self.countLabel.text = count;

    [stream fetchItemsWithCompletionBlock:^(NSArray *items) {
        [self.source addItems:items];
        [self.collectionView reloadData];
    }];
}

@end
