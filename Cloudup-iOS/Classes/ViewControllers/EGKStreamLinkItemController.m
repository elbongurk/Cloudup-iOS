//
//  EGKStreamLinkItemController.m
//  Cloudup-iOS
//
//  Created by Ryan Krug on 5/21/14.
//  Copyright (c) 2014 Elbongurk. All rights reserved.
//

#import "EGKStreamLinkItemController.h"
#import "EGKStreamItem.h"

@interface EGKStreamLinkItemController () <UIWebViewDelegate>

@property (strong, nonatomic) EGKStreamItem *item;
@property (strong, nonatomic) UIWebView *webView;

@end

@implementation EGKStreamLinkItemController

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
    self.title = @"Loading...";

    CGRect appFrame = [[UIScreen mainScreen] applicationFrame];
    
    self.webView = [[UIWebView alloc] initWithFrame:appFrame];
    self.webView.delegate = self;
    
    self.view = self.webView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.item.oembedUrl) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.item.oembedUrl]]];
    }
    else if (self.item.url) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.item.url]]];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.title = @"Loading...";
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}


@end
