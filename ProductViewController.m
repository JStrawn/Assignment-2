//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "WebViewController.h"
#import "Product.h"
#import "Company.h"
#import "ProductInputViewController.h"
#import "DAO.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Edit Button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProduct:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem, addButton, nil];
    
    
    self.sharedManager = [DAO sharedManager];
    
    self.tableView.allowsSelectionDuringEditing = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    //reload the tableview to update currentCompany and displayed products
    [self.tableView reloadData];
    [super viewWillAppear:animated];
    self.title = self.currentCompany.name;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.currentCompany.products count];
}

// Initialize the cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cells
    Product *currentProduct = [[Product alloc]init];
    currentProduct = [self.currentCompany.products objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = currentProduct.name;
    [[cell imageView] setImage: [UIImage imageNamed:currentProduct.image]];
    
    return cell;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    NSString *stringToMove = [self.currentCompany.products objectAtIndex:sourceIndexPath.row];
    [self.currentCompany.products removeObjectAtIndex:sourceIndexPath.row];
    [self.currentCompany.products insertObject:stringToMove atIndex:destinationIndexPath.row];
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (proposedDestinationIndexPath.section != sourceIndexPath.section)
    {
        return sourceIndexPath;
    }
    
    return proposedDestinationIndexPath;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.editing == YES) {
        self.productInputViewController = [[ProductInputViewController alloc]init];
        //initialize current company again so it carries over
        self.productInputViewController.currentCompany = self.currentCompany;
        
        Product* product = [self.currentCompany.products objectAtIndex:indexPath.row];
        self.productInputViewController.isEditMode = YES;
        self.productInputViewController.productToEdit = product;
        [self.navigationController
         pushViewController:self.productInputViewController
         animated:YES];
    } else {
        self.productInputViewController = [[ProductInputViewController alloc]init];
        self.productInputViewController.isEditMode = NO;
        
        WebViewController *webViewController = [[WebViewController alloc]init];
        //initialize current company again so it carries over
        self.productInputViewController.currentCompany = self.currentCompany;
        
        Product* product = [self.currentCompany.products objectAtIndex:indexPath.row];
        
        webViewController.title = product.name;
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:nil];
        
        //this sets the product property in WebviewController
        webViewController.currentProduct = product;
        [self.navigationController
         pushViewController:webViewController
         animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
        [self.currentCompany.products removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)addProduct:sender
{
    ProductInputViewController *productInputViewController = [[ProductInputViewController alloc]init];
    
    Company *company = self.currentCompany;
    
    productInputViewController.currentCompany = company;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:nil];
    
    [self.navigationController
     pushViewController:productInputViewController
     animated:YES];
}



@end
