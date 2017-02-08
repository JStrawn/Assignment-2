//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Juliana Strawn on 1/29/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"
#import "ProductInputViewController.h"
#import "WebViewController.h"
#import "CustomCellProduct.h"

@class ProductInputViewController;
@class WebViewController;

@interface ProductViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, retain) NSMutableArray *products;
@property (nonatomic, retain) Company *currentCompany;
@property (nonatomic, retain) Product *currentProduct;
@property (nonatomic, retain) IBOutlet  WebViewController * webViewController;
@property (nonatomic, retain) IBOutlet  ProductInputViewController *productInputViewController;
@property (nonatomic, retain) DAO *sharedManager;
@property (nonatomic, retain) Product *productToEdit;

@property (retain, nonatomic) IBOutlet UIImageView *companyImage;

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property (retain, nonatomic) IBOutlet UILabel *companyLabel;

@property (retain, nonatomic) IBOutlet UIView *companyImagePaddingView;

@property BOOL isOffline;

-(UIImage *)getImageFromURL:(NSString *)fileURL withTableViewCell:(CustomCellProduct*)cell;



@end
