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

NSString *const EGKStreamItemCellIdentifier = @"EGKStreamItemCell";

@interface EGKStreamItemCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end


@implementation EGKStreamItemCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (!self) {
        return nil;
    }
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.layer.cornerRadius = 5.0;
    
    self.contentView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.contentView.layer.shadowOffset = CGSizeMake(0.0f, 1.0f);
    self.contentView.layer.shadowRadius = 2.0f;
    self.contentView.layer.shadowOpacity = 0.15f;
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 170)];
    
    _imageView.contentMode = UIViewContentModeCenter;
    
    [self.contentView addSubview:_imageView];

    return self;
}

- (void)configureForItem:(EGKStreamItem *)item
{
    EGKThumb *thumb = [item thumbForSize:@"300x300"];

    if (thumb) {
        NSURL *url = [NSURL URLWithString:thumb.url];
        [self.imageView setImageWithURL:url];
    }
    else {
        //[self.imageView setImage:[UIImage imageNamed:@""]];
    }
}


@end
