//
//  ProductInputViewController.h
//  NavCtrl
//
//  Created by Juliana Strawn on 12/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Company.h"
#import "CompanyViewController.h"

@interface ProductInputViewController : UIViewController
//@property (nonatomic, retain) Product *newProduct;
@property (retain, nonatomic) UITextField *nameTextField;
@property (retain, nonatomic) UITextField *imageTextField;
@property (retain, nonatomic) UITextField *urlTextField;
@property (retain, nonatomic) Company *currentCompany;
@property (retain, nonatomic) CompanyViewController *companyViewController;
@property (nonatomic, retain) DAO *sharedManager;
@property (nonatomic, retain) Product *productToEdit;
@property BOOL isEditMode;

@end
