//
//  EGKStreamCell.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/30/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKStreamCell.h"
#import "EGKStream.h"

@interface EGKStreamCell ()



@end

@implementation EGKStreamCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)configureForStream:(EGKStream *)stream
{
    //TODO: here is where we fetch items
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
