//
//  EGKStreamController.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 4/22/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKStreamController.h"
#import "EGKCloudupClient.h"
#import "EGKArrayDataSource.h"
#import "EGKStream.h"
#import "EGKStreamCell.h"

static NSString *const EGKStreamCellIdentifier = @"StreamCell";

@interface EGKStreamController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) EGKArrayDataSource *source;
@end

@implementation EGKStreamController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Streams";
    
    TableViewCellConfigureBlock configureCell = ^(EGKStreamCell *cell, EGKStream *stream) {
        [cell configureForStream:stream];
    };
    
    [self.tableView registerClass:[EGKStreamCell class] forCellReuseIdentifier:EGKStreamCellIdentifier];

    [[EGKCloudupClient sharedClient] fetchStreamsWithCompletionBlock:^(NSArray *streams) {
        self.source = [[EGKArrayDataSource alloc] initWithItems:streams
                                                 cellIdentifier:EGKStreamCellIdentifier
                                             configureCellBlock:configureCell];
        self.tableView.dataSource = self.source;
        [self.tableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
