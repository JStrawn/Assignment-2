//
//  ItemInputViewController.h
//  NavCtrl
//
//  Created by Juliana Strawn on 12/13/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "CompanyViewController.h"
#import "DAO.h"

@class Company;
@class CompanyViewController;

@interface ItemInputViewController : UIViewController
@property (nonatomic, retain) Company *newCompany;
@property (retain, nonatomic) UITextField *nameTextField;
@property (retain, nonatomic) UITextField *tickerTextField;
@property (retain, nonatomic) UITextField *imageTextField;

@property (nonatomic, retain) Company *companyToEdit;
@property (retain, nonatomic) Company *currentCompany;
@property (retain, nonatomic) CompanyViewController *companyViewController;
@property (nonatomic, retain) DAO *sharedManager;

@property BOOL isEditMode;
@property BOOL keyboardIsUp;

@end
