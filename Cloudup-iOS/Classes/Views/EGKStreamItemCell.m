//
//  EGKStreamItemCell.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 5/1/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKStreamItemCell.h"
#import "EGKStreamItem.h"
#import "UIImageView+AFNetworking.h"
#import "EGKThumb.h"
#import "EGKAppearanceManager.h"

NSString *const EGKStreamItemCellIdentifier = @"EGKStreamItemCell";

@interface EGKStreamItemCell ()

@property (nonatomic, strong) UIImageView *previewImage;
@property (nonatomic, strong) UIImageView *typeImage;
@property (nonatomic, strong) UILabel *titleLabel;

@end


@implementation EGKStreamItemCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (!self) {
        return nil;
    }
    
    [self setupContextView];
    [self setupPreviewImage];
    [self setupTypeImage];
    [self setupTitleLabel];

    return self;
}

- (void)setupContextView
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 5.0;
    
    self.contentView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.contentView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.contentView.layer.shadowRadius = 2.0f;
    self.contentView.layer.shadowOpacity = 0.15f;
}

- (void)setupPreviewImage
{
    _previewImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 180, 136)];
    _previewImage.clipsToBounds = YES;
    _previewImage.contentMode = UIViewContentModeScaleAspectFill;
    
    [self.contentView addSubview:_previewImage];
}

- (void)setupTypeImage
{
    _typeImage = [[UIImageView alloc] initWithFrame:CGRectMake(170, 148, 20, 20)];
    _typeImage.contentMode = UIViewContentModeCenter;
    
    [self.contentView addSubview:_typeImage];
}

- (void)setupTitleLabel
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 148, 160, 20)];
    _titleLabel.textColor = [EGKAppearanceManager blue];
    _titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];

    [self.contentView addSubview:_titleLabel];
}

- (void)configureForItem:(EGKStreamItem *)item
{
    UIImage *typeImage;
    UIImage *typeImageSmall;
    
    if (item.isAudio) {
        typeImage = [UIImage imageNamed:@"item-type-audio"];
        typeImageSmall = [UIImage imageNamed:@"item-type-audio-small"];
    }
    else if (item.isVideo) {
        typeImage = [UIImage imageNamed:@"item-type-video"];
        typeImageSmall = [UIImage imageNamed:@"item-type-video-small"];
    }
    else if (item.isImage) {
        typeImage = [UIImage imageNamed:@"item-type-image"];
        typeImageSmall = [UIImage imageNamed:@"item-type-image-small"];
    }
    else if (item.isText) {
        typeImage = [UIImage imageNamed:@"item-type-text"];
        typeImageSmall = [UIImage imageNamed:@"item-type-text-small"];
    }
    else if (item.isLink) {
        typeImage = [UIImage imageNamed:@"item-type-link"];
        typeImageSmall = [UIImage imageNamed:@"item-type-link-small"];
    }
    else {
        typeImage = [UIImage imageNamed:@"item-type-unknown"];
        typeImageSmall = [UIImage imageNamed:@"item-type-unknown-small"];
    }
    
    self.titleLabel.text = item.title;

    self.previewImage.image = nil;
    self.typeImage.image = typeImageSmall;

    EGKThumb *thumb = [item thumbForSize:EGKThumbSize300X300];
    
    if (thumb) {
        if (item.isText) {
            self.previewImage.contentMode = UIViewContentModeTopLeft;
        }
        else if ([thumb isSmallerThanSize:self.bounds.size]) {
            self.previewImage.contentMode = UIViewContentModeCenter;
        }
        else {
            self.previewImage.contentMode = UIViewContentModeScaleAspectFill;
        }
        
        NSURL *url = [NSURL URLWithString:thumb.url];
        [self.previewImage setImageWithURL:url
                          placeholderImage:typeImage];
    }
    else {
        self.previewImage.contentMode = UIViewContentModeCenter;
        self.previewImage.image = typeImage;
    }
}


@end
