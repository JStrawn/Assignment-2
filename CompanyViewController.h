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

@interface CompanyViewController : UITableViewController<DaoDelegate>
{
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

@property (nonatomic, retain) IBOutlet  ProductViewController *productViewController;
@property (nonatomic, retain) IBOutlet  ItemInputViewController *itemInputViewController;
@property (nonatomic, retain) DAO *sharedManager;
@property (nonatomic, retain) Company *currentCompany;

-(UIImage *) getImageFromURL:(NSString *)fileURL;

-(void)addItem:sender;
-(NSString *) archivePath;
-(void)initModelContext;


-(void)createCompany:(NSNumber*)emp_id name:(NSString*)name loc:(NSString*)loc;
-(void)deleteCompany:(int)index;
-(void)saveChanges;

-(void)loadAllCompanies;


@end
