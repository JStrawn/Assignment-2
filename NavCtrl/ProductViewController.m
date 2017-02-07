//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Juliana Strawn on 1/29/17.
//  Copyright © 2017 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "WebViewController.h"
#import "Product.h"
#import "Company.h"
#import "ProductInputViewController.h"
#import "DAO.h"
#import "CustomCellProduct.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super init];
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
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    // Edit Button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProduct:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:self.editButtonItem, addButton, nil];
    
    
    self.sharedManager = [DAO sharedManager];
    
    self.tableView.allowsSelectionDuringEditing = YES;
    
    //company image
    NSURL * imageURL = [NSURL URLWithString:self.currentCompany.imageURL];
    NSData * imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage * image = [UIImage imageWithData:imageData];
    self.companyImage.image = image;
    
    self.companyImage.backgroundColor = [UIColor whiteColor];
    self.companyImagePaddingView.layer.cornerRadius = 15;
    
    self.companyImage.bounds = CGRectInset(self.companyImage.frame, 30.0, 30.0);

    
    //label text
    self.companyLabel.text = self.currentCompany.name;
    
    //hide tableview is there are no products
    if (self.currentCompany.products.count == 0) {
        [self.tableView setHidden:YES];
    } else {
        [self.tableView setHidden:NO];
    }

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

//changing a cell's height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
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
    
    CustomCellProduct *cell = (CustomCellProduct*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomCellProduct" owner:self options:nil];
        cell = [nib objectAtIndex:0];

    }
    // Configure the cells
    self.currentProduct = [self.currentCompany.products objectAtIndex:[indexPath row]];
    
    cell.productName.text = self.currentProduct.name;

    if (self.currentProduct.image == nil) {
        UIImage *defaultIcon = [self getImageFromURL:self.currentCompany.imageURL];
        cell.productImage.image = defaultIcon;
    } else if ([self.currentProduct.image isEqualToString: @""]) {
        UIImage *defaultIcon = [self getImageFromURL:self.currentCompany.imageURL];
        cell.productImage.image = defaultIcon;
    } else {
    UIImage *productIcon = [self getImageFromURL:self.currentProduct.image];
    cell.productImage.image = productIcon;
    }
    
    cell.imageView.layer.borderColor = [[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1.0]CGColor];
    cell.imageView.layer.borderWidth = 1.0f;

    
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
        self.productInputViewController = [[[ProductInputViewController alloc]init]autorelease];
        //initialize current company again so it carries over
        self.productInputViewController.currentCompany = self.currentCompany;
        
        Product* product = [self.currentCompany.products objectAtIndex:indexPath.row];
        self.productInputViewController.isEditMode = YES;
        self.productInputViewController.productToEdit = product;
        [self.navigationController
         pushViewController:self.productInputViewController
         animated:YES];
    } else {
        self.productInputViewController = [[[ProductInputViewController alloc]init]autorelease];
        self.productInputViewController.isEditMode = NO;
        
        WebViewController *webViewController = [[[WebViewController alloc]init]autorelease];
        //initialize current company again so it carries over
        self.productInputViewController.currentCompany = self.currentCompany;
        
        Product* product = [self.currentCompany.products objectAtIndex:indexPath.row];
        
        webViewController.title = product.name;
        
        self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:nil]autorelease];
        
        
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
        [self.sharedManager deleteManagedProduct:indexPath.row inCompany:self.currentCompany];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)addProduct:sender
{
    ProductInputViewController *productInputViewController = [[[ProductInputViewController alloc]init]autorelease];
    
    Company *company = self.currentCompany;
    
    productInputViewController.currentCompany = company;
    
    self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:nil]autorelease];
    
    
    
    
    [self.navigationController
     pushViewController:productInputViewController
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
    [_companyLabel release];
    [_companyImagePaddingView release];
    [_productToEdit release];
    [_currentProduct release];
    [_productInputViewController release];
    [_sharedManager release];
    [_currentCompany release];
    [_products release];
    [_webViewController release];
    [_companyImage release];
    [super dealloc];
}
@end
