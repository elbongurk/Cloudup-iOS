//
//  EGKStreamItemController.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 5/13/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKStreamItemController.h"
#import "EGKStreamItem.h"
#import "UIImageView+AFNetworking.h"

@interface EGKStreamItemController ()<UIScrollViewDelegate>

@property (strong, nonatomic) EGKStreamItem *item;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIScrollView *scrollView;

- (void)centerScrollViewContents;

@end

@implementation EGKStreamItemController

- (instancetype)init
{
    return nil;
}

- (instancetype)initWithStreamItem:(EGKStreamItem *)item
{
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    _item = item;
    
    return self;
}

- (void)loadView
{
    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:appFrame];

    self.view = self.scrollView;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerScrollViewContents];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGSize size;
    NSURL *url;
    
    if (self.item.directURL) {
        size = self.item.size;
        url = [NSURL URLWithString:self.item.directURL];
    }
    else if (self.item.oembedUrl) {
        size = self.item.oembedSize;
        url = [NSURL URLWithString:self.item.oembedUrl];
    }
    
    self.scrollView.contentSize = size;
    self.scrollView.delegate = self;

    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    [self.view addSubview:self.imageView];

    [self.imageView setImageWithURL:url];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setToolbarHidden:NO animated:animated];

    CGRect scrollViewFrame = self.scrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / self.scrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / self.scrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);

    self.scrollView.minimumZoomScale = minScale;
    self.scrollView.maximumZoomScale = 1.0f;
    self.scrollView.zoomScale = minScale;
    
    [self centerScrollViewContents];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:animated];
}

- (void)centerScrollViewContents
{
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
}

@end
