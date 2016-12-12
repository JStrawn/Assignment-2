//
//  WebViewController.h
//  NavCtrl
//
//  Created by Juliana Strawn on 12/6/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Product.h"
#import "Company.h"

@interface WebViewController : UIViewController
@property(strong,nonatomic) WKWebView *webView;
//@property (strong, nonatomic) NSString *productURL;
//@property (nonatomic, retain) Product *currentURL;
@property (nonatomic, retain) Product *currentProduct;
//@property (nonatomic, retain) Company *currentCompany;

@end
