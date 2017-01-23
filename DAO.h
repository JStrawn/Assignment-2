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


@interface DAO : NSObject
{
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

@property (nonatomic, retain) NSMutableArray *companyList;
@property (strong) NSManagedObjectContext *managedObjectContext;
@property (strong) NSMutableArray *managedCompanies;
@property (strong) NSMutableArray *fetchedCompanies;

- (void)initializeCoreData;
+ (id)sharedManager ;
@property (retain, nonatomic) id<DaoDelegate> reloadDelegate;
- (void)loadStockPrices;
-(void)editManagedCompany:(Company*)comp;

@end
