//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "Product.h"

@class WebViewController;

@interface ProductViewController : UITableViewController
@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) Company *currentCompany;
@property (nonatomic, retain) Product *currentProduct;
@property (nonatomic, retain) IBOutlet  WebViewController * webViewController;


@end
