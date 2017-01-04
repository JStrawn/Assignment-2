//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "Company.h"
#import "Product.h"
#import "DAO.h"
#import "ItemInputViewController.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

//#pragma mark Initializing companies and products
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Preserve selection between presentations
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Edit Button
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //Add Button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    self.navigationItem.leftBarButtonItem = addButton;

    self.title = @"Mobile device makers";
    self.sharedManager = [DAO sharedManager];
    
}

- (void)addItem:sender
{
    self.itemInputViewController = [[ItemInputViewController alloc]init];
    self.itemInputViewController.isEditMode = NO;
    [self.navigationController
     pushViewController:self.itemInputViewController
     animated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    //self.companyList = [[[NSUserDefaults standardUserDefaults] objectForKey:@"companyList"]mutableCopy];
    [self.tableView reloadData];
    self.itemInputViewController.isEditMode = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

//Example of changing a cell's height
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 50;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.sharedManager.companyList.count;
}

// Initialize the cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cells (Title and Photo)
    Company *currentCompany = [self.sharedManager.companyList objectAtIndex:[indexPath row]];
    cell.textLabel.text = currentCompany.name;
    [[cell imageView] setImage: [UIImage imageNamed:currentCompany.photo]];
    return cell;
}

// Enable editing the table view
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

// 3 methods below enable deleting a row on the table view
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.sharedManager.companyList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //[[NSUserDefaults standardUserDefaults] setObject:self.companyList forKey:@"companyList"];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *stringToMove = [self.sharedManager.companyList objectAtIndex:sourceIndexPath.row];
    [self.sharedManager.companyList removeObjectAtIndex:sourceIndexPath.row];
    [self.sharedManager.companyList insertObject:stringToMove atIndex:destinationIndexPath.row];
}

// The 3 methods below enable rearranging of rows on the table view
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Company *company = [self.sharedManager.companyList objectAtIndex:indexPath.row];

    if (tableView.editing == YES) {

        self.itemInputViewController = [[ItemInputViewController alloc]init];
        self.itemInputViewController.isEditMode = YES;
        self.itemInputViewController.companyToEdit = company;
        [self.navigationController
         pushViewController:self.itemInputViewController
         animated:YES];
        
    } else {
    
    // Change the index path row in the array so the path to "products" is also rearranged
        
    self.itemInputViewController.isEditMode = NO;
    self.productViewController.currentCompany = company;
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
    }
    
}

@end
