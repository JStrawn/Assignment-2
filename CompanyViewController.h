//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "ItemInputViewController.h"

@class ProductViewController;
@class ItemInputViewController;

@interface CompanyViewController : UITableViewController

//@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) IBOutlet  ProductViewController *productViewController;
@property (nonatomic, retain) IBOutlet  ItemInputViewController *itemInputViewController;
@property (nonatomic, retain) DAO *sharedManager;
@property (nonatomic, retain) Company *currentCompany;
@end
