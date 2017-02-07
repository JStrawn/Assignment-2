//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Juliana Strawn on 1/25/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Company.h"
#import "Product.h"
#import "DAO.h"
#import "ItemInputViewController.h"
#import "CustomCell.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)reloadStockData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
    
}

//#pragma mark Initializing companies and products
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Preserve selection between presentations
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    // Edit Button
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //Add Button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    //Title and Color
        self.title = @"Stock Tracker";
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.18 green:0.80 blue:0.44 alpha:1.0];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        [self.navigationController.navigationBar
         setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        self.navigationController.navigationBar.translucent = NO;
    

    
    //Load shared manager for companies
    self.sharedManager = [DAO sharedManager];
    self.sharedManager.reloadDelegate = self;
    
    
    //    //undo and redo buttons
    //    UIButton *undoButton = [[UIButton alloc]init];
    //    undoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [undoButton addTarget:self
    //                   action:@selector(undoButtonPressed)
    //         forControlEvents:UIControlEventTouchUpInside];
    //    [undoButton setTitle:@"Undo" forState:UIControlStateNormal];
    //    undoButton.frame = CGRectMake(self.view.center.x, self.view.center.y, 160.0, 40.0);
    //
    //    [self.view addSubview:undoButton];
    //    [self.view bringSubviewToFront:undoButton];
    
    //    UIButton *redoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [redoButton addTarget:self
    //                   action:@selector(redoButtonPressed)
    //         forControlEvents:UIControlEventTouchUpInside];
    //    [redoButton setTitle:@"Redo" forState:UIControlStateNormal];
    //    redoButton.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    //    [self.view addSubview:redoButton];
}


- (void)addItem:sender
{
    self.itemInputViewController = [[[ItemInputViewController alloc]init]autorelease];
    self.itemInputViewController.isEditMode = NO;
    [self.navigationController
     pushViewController:self.itemInputViewController
     animated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
    self.itemInputViewController.isEditMode = NO;
    [self reloadStockData];
    

    
    [NSTimer scheduledTimerWithTimeInterval: 60.0 target: self
                                   selector: @selector(reloadStockData)
                                   userInfo: nil
                                    repeats: YES];
    
    if (self.sharedManager.companyList.count < 1) {
        [self.tableView setHidden:YES];
    } else {
        [self.tableView setHidden:NO];
    }
    
    self.undoRedoView.hidden = YES;
    self.undoBtn.hidden = YES;
    self.redoBtn.hidden = YES;

    [super viewWillAppear:YES];
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

//changing a cell's height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.sharedManager.companyList.count;
}



// Initialize the cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *cell = (CustomCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    // Configure the cells (Title and Photo)
    
    self.currentCompany = [self.sharedManager.companyList objectAtIndex:[indexPath row]];
    
    NSString *companyString = [NSString stringWithFormat:@"%@ (%@)", self.currentCompany.name, self.currentCompany.ticker];
    cell.companyName.text = companyString;
    
    UIImage *companyIcon = [self getImageFromURL:self.currentCompany.imageURL];
    cell.companyImage.image = companyIcon;
    
    cell.companyImageView.layer.borderColor = [[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1.0]CGColor];
    cell.companyImageView.layer.borderWidth = 1.0f;
    
    //cell bottom part, stock value
    if (self.currentCompany.stockPrice == nil) {
        cell.stockPrice.text = @"Loading...";
    } else {
        cell.stockPrice.text = [NSString stringWithFormat:@"$%@", self.currentCompany.stockPrice];
    }

    
    return cell;
}

// Enable editing the table view
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
    
    if (self.editing) {
        // we're in edit mode
//        [self.sharedManager saveChanges];
        self.undoRedoView.hidden = NO;
        self.undoBtn.hidden = NO;
        self.redoBtn.hidden = NO;
        
    } else {
        // we're not in edit mode
        self.undoRedoView.hidden = YES;
        self.undoBtn.hidden = YES;
        self.redoBtn.hidden = YES;

        
    }
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
        
        //call a DAO delete method here
        [self.sharedManager deleteManagedCompany:indexPath.row];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *stringToMove = [self.sharedManager.companyList objectAtIndex:sourceIndexPath.row];
    [self.sharedManager.companyList removeObjectAtIndex:sourceIndexPath.row];
    [self.sharedManager.companyList insertObject:stringToMove atIndex:destinationIndexPath.row];
    
    [self.sharedManager.managedCompanies removeObjectAtIndex:sourceIndexPath.row];
    

    
    [self.sharedManager.managedCompanies insertObject:stringToMove atIndex:destinationIndexPath.row];
    
    [self.sharedManager saveChanges];
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
        
        self.itemInputViewController = [[[ItemInputViewController alloc]init]autorelease];
        self.itemInputViewController.isEditMode = YES;
        self.itemInputViewController.companyToEdit = company;
        
        [self.navigationController
         pushViewController:self.itemInputViewController
         animated:YES];
        
    } else {
        
        // Change the index path row in the array so the path to "products" is also rearranged
        
        self.productViewController = [[[ProductViewController alloc]init]autorelease];
        self.itemInputViewController.isEditMode = NO;
        self.productViewController.currentCompany = company;
        
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:nil]autorelease];
        
        //        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:nil];
        //
        //        UIImage *undo = [UIImage imageNamed:@"undo2.png"];
        //
        //        UIBarButtonItem *undoButton = [[UIBarButtonItem alloc]initWithImage:undo style:UIBarButtonItemStylePlain target:self action:nil];
        //
        //        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:backButton, undoButton, nil];
        
        [self.navigationController
         pushViewController:self.productViewController
         animated:YES];
    }
    
}



- (IBAction)redoBtnWasPressed:(id)sender {
    [self.sharedManager redoLastUndo:self];
}

- (IBAction)undoBtnWasPressed:(id)sender {
    [self.sharedManager undoLastAction:self];
    //reload tableview
    [self.tableView reloadData];
}

- (IBAction)addCompanyButton:(id)sender {
    self.itemInputViewController = [[[ItemInputViewController alloc]init]autorelease];
    self.itemInputViewController.isEditMode = NO;
    [self.navigationController
     pushViewController:self.itemInputViewController
     animated:YES];
}

-(UIImage *) getImageFromURL:(NSString *)fileURL {
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    
    return result;
}


- (void)dealloc {
    [_tableView release];
    [_addCompanyButton release];
    [_navBar release];
    [_undoRedoView release];
    [_redoBtn release];
    [_undoBtn release];
    [_undoRedoView release];
    [_sharedManager release];
    [_itemInputViewController release];
    [_currentCompany release];
    [_productViewController release];
    [super dealloc];
}
@end
