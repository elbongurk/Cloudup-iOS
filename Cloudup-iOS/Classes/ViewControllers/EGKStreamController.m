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
#import "EGKApplicationController.h"
#import "EGKUserSession.h"
#import "EGKAppearanceManager.h"

@interface EGKStreamController () <UITableViewDelegate>

@property (nonatomic, strong) EGKArrayDataSource *source;

@end

@implementation EGKStreamController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Streams";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logout:)];
    
    [self setupTableDataSource];
    [self setupTable];
    
    [[EGKCloudupClient sharedClient] fetchStreamsWithCompletionBlock:^(NSArray *streams) {
        [self.source addItems:streams];
        [self.tableView reloadData];
    }];
}

- (void)setupTableDataSource
{
    CellConfigureBlock configureCell = ^(EGKStreamCell *cell, EGKStream *stream) {
        [cell configureForStream:stream];
    };
    
    self.source = [[EGKArrayDataSource alloc] initWithCellIdentifier:EGKStreamCellIdentifier
                                                  configureCellBlock:configureCell];
}

- (void)setupTable
{
    self.tableView.backgroundColor = [EGKAppearanceManager tan];
    self.tableView.dataSource = self.source;
    self.tableView.rowHeight = 240.0f;

    [self.tableView registerClass:[EGKStreamCell class] forCellReuseIdentifier:EGKStreamCellIdentifier];
}

- (void)logout:(id)sender
{
    EGKUserSession *session = [EGKUserSession currentUserSession];
    
    if ([session clearSession]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:EGKDidLogoutNotification object:self];
    }
}

@end
