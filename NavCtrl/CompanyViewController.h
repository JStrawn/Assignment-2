//
//  CompanyViewController.h
//  NavCtrl
//
//  Created by Juliana Strawn on 1/25/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"
#import "ItemInputViewController.h"
#import "ProductInputViewController.h"
#import "ProductViewController.h"
#import "CustomCell.h"

@class ProductViewController;
@class ItemInputViewController;

@interface CompanyViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

@property (nonatomic, retain) IBOutlet  ProductViewController *productViewController;
@property (nonatomic, retain) IBOutlet  ItemInputViewController *itemInputViewController;
@property (nonatomic, retain) DAO *sharedManager;
@property (nonatomic, retain) Company *currentCompany;

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) IBOutlet UIButton *addCompanyButton;
@property (retain, nonatomic) IBOutlet UINavigationBar *navBar;


@property (retain, nonatomic) IBOutlet UIView *undoRedoView;
@property (retain, nonatomic) IBOutlet UIButton *redoBtn;
@property (retain, nonatomic) IBOutlet UIButton *undoBtn;
- (IBAction)redoBtnWasPressed:(id)sender;
- (IBAction)undoBtnWasPressed:(id)sender;


- (IBAction)addCompanyButton:(id)sender;

-(UIImage *)getImageFromURL:(NSString *)fileURL withTableViewCell:(CustomCell*)cell;

-(void)addItem:sender;

@end

