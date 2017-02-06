//
//  NavControllerAppDelegate.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataHelper.h"
#import "CompanyViewController.h"
#import "DAO.h"


@interface NavControllerAppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
//@property (nonatomic, strong, readonly) CoreDataHelper *coreDataHelper;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) CompanyViewController *viewController;

@property (nonatomic, retain) DAO *sharedManager;



- (void)saveContext;

@end


