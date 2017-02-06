//
//  DAO.h
//  NavCtrl
//
//  Created by Juliana Strawn on 12/12/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DaoDelegate.h"
#import <CoreData/CoreData.h>
#import "ManagedCompany+CoreDataClass.h"
#import "ManagedProduct+CoreDataClass.h"
#import "ManagedCompany+CoreDataProperties.h"
#import "ManagedProduct+CoreDataProperties.h"
#import "Company.h"
#import "Product.h"


@interface DAO : NSObject

@property (nonatomic, retain) NSMutableArray *companyList;
@property (strong) NSManagedObjectContext *managedObjectContext;
@property (strong) NSMutableArray *managedCompanies;
@property (strong) NSMutableArray *fetchedCompanies;

- (void)initializeCoreData;
+ (id)sharedManager ;
@property (retain, nonatomic) id<DaoDelegate> reloadDelegate;
- (void)loadStockPrices;
-(void)editManagedCompany:(Company*)comp;
-(void)createManagedCompany:(Company*)comp;
-(void)deleteManagedCompany:(NSUInteger)index;
-(void)editManagedProduct:(Product*)product inCompany:(Company*)currentCompany withOriginalName:(NSString*)original;
-(void)createManagedProduct:(Product*)product inCompany:(Company*)currentCompany;
-(void)deleteManagedProduct:(NSUInteger)index inCompany:(Company*)currentCompany;
-(void)saveChanges;

- (void)undoLastAction:(id)sender;
- (void)redoLastUndo:(id)sender;



@end
