//
//  WebViewController.m
//  NavCtrl
//
//  Created by Juliana Strawn on 12/6/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "WebViewController.h"
#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "Product.h"
#import "Company.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize the webview
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame];
    _webView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    NSString *currentURL = self.currentProduct.url;
    NSURL *url = [NSURL URLWithString:currentURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
    [self.view addSubview:_webView];
}
    
    
//    //If statement for each product's website
//    if ([self.title isEqualToString:@"iPad"]) {
//        NSString *urlString = @"http://www.apple.com/ipad/";
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:urlRequest];
//        [self.view addSubview:_webView];
//    } else if ([self.title isEqualToString:@"iPod Touch"]) {
//        NSString *urlString = @"http://www.apple.com/ipod-touch/";
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:urlRequest];
//        [self.view addSubview:_webView];
//    } else if ([self.title isEqualToString:@"iPhone"]) {
//        NSString *urlString = @"http://www.apple.com/iphone-7/";
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:urlRequest];
//        [self.view addSubview:_webView];
//    } else if ([self.title isEqualToString:@"Galaxy S4"]) {
//        NSString *urlString = @"http://www.samsung.com/us/mobile/phones/galaxy-s/samsung-galaxy-s4-verizon-white-frost-16gb-sch-i545zwavzw/";
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:urlRequest];
//        [self.view addSubview:_webView];
//    } else if ([self.title isEqualToString:@"Galaxy Note"]) {
//        NSString *urlString = @"http://www.samsung.com/us/mobile/phones/galaxy-note/samsung-galaxy-note5-32gb-at-t-black-sapphire-sm-n920azkaatt/";
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:urlRequest];
//        [self.view addSubview:_webView];
//    } else if ([self.title isEqualToString:@"Galaxy Tab"]) {
//        NSString *urlString = @"http://www.samsung.com/us/mobile/tablets/galaxy-tab-s2/sm-t713-sm-t713nzkexar/";
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:urlRequest];
//        [self.view addSubview:_webView];
//    } else if ([self.title isEqualToString:@"Google Pixel"]) {
//        NSString *urlString = @"https://madeby.google.com/phone/";
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:urlRequest];
//        [self.view addSubview:_webView];
//    } else if ([self.title isEqualToString:@"Nexus 6P"]) {
//        NSString *urlString = @"https://www.google.com/nexus/6p/";
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:urlRequest];
//        [self.view addSubview:_webView];
//    } else if ([self.title isEqualToString:@"Nexus 5X"]) {
//        NSString *urlString = @"https://www.google.com/nexus/5x/";
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:urlRequest];
//        [self.view addSubview:_webView];
//    } else if ([self.title isEqualToString:@"Amazon Fire Phone"]) {
//        NSString *urlString = @"https://www.amazon.com/Amazon-Fire-Phone-32GB-Unlocked/dp/B00OC0USA6";
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:urlRequest];
//        [self.view addSubview:_webView];
//    } else if ([self.title isEqualToString:@"Kindle Fire"]) {
//        NSString *urlString = @"https://www.amazon.com/Amazon-Fire-7-Inch-Tablet-8GB/dp/B00TSUGXKE";
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:urlRequest];
//        [self.view addSubview:_webView];
//    } else {
//        NSString *urlString = @"https://www.amazon.com/Amazon-Kindle-Paperwhite-6-Inch-4GB-eReader/dp/B00OQVZDJM";
//        NSURL *url = [NSURL URLWithString:urlString];
//        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//        [_webView loadRequest:urlRequest];
//        [self.view addSubview:_webView];
//    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
