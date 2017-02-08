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
    _webView = [[[WKWebView alloc] initWithFrame:self.view.frame]autorelease];
    _webView.frame = CGRectMake(self.view.frame.origin.x,self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    NSString *currentURL = self.currentProduct.url;
    NSURL *url = [NSURL URLWithString:currentURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
    [self.view addSubview:_webView];
    
    //[super viewDidAppear:YES];
}
    


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

-(void)dealloc {
    //[_webView release];
    [_currentProduct release];
    [super dealloc];
}

@end
