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
    
//    // Initialize Products
//    Product *iPad = [[Product alloc]initWithName:@"iPad" andImage:@"apple-xxl.png" andURL:@"http://www.apple.com/ipad/"];
//    Product *iPodTouch = [[Product alloc]initWithName:@"iPod Touch" andImage:@"apple-xxl.png" andURL:@"http://www.apple.com/ipod-touch/"];
//    Product *iPhone = [[Product alloc]initWithName:@"iPhone" andImage:@"apple-xxl.png" andURL:@"http://www.apple.com/iphone-7/"];
//    
//    Product *galaxyS4 = [[Product alloc]initWithName:@"Galaxy S4" andImage:@"samsung.jpg" andURL:@"http://www.samsung.com/us/mobile/phones/galaxy-s/samsung-galaxy-s4-verizon-white-frost-16gb-sch-i545zwavzw/"];
//    Product *galaxyNote = [[Product alloc]initWithName:@"Galaxy Note" andImage:@"samsung.jpg" andURL:@"http://www.samsung.com/us/mobile/phones/galaxy-note/samsung-galaxy-note5-32gb-at-t-black-sapphire-sm-n920azkaatt/"];
//    Product *galaxyTab = [[Product alloc]initWithName:@"Galaxy Tab" andImage:@"samsung.jpg" andURL:@"http://www.samsung.com/us/mobile/tablets/galaxy-tab-s2/sm-t713-sm-t713nzkexar/"];
//    
//    Product *googlePixel = [[Product alloc]initWithName:@"Google Pixel" andImage:@"google.png" andURL:@"https://madeby.google.com/phone/"];
//    Product *nexus6P = [[Product alloc]initWithName:@"Nexus 6P" andImage:@"google.png" andURL:@"https://www.google.com/nexus/6p/"];
//    Product *nexus5X = [[Product alloc]initWithName:@"Nexus 5X" andImage:@"google.png" andURL:@"https://www.google.com/nexus/5x/"];
//    
//    Product *amazonFire = [[Product alloc]initWithName:@"Amazon Fire Phone" andImage:@"amazon.png" andURL:@"https://www.amazon.com/Amazon-Fire-Phone-32GB-Unlocked/dp/B00OC0USA6"];
//    Product *kindleFire = [[Product alloc]initWithName:@"Kindle Fire" andImage:@"amazon.png" andURL: @"https://www.amazon.com/Amazon-Fire-7-Inch-Tablet-8GB/dp/B00TSUGXKE"];
//    Product *kindlePaperWhite = [[Product alloc]initWithName:@"Kindle PaperWhite" andImage:@"amazon.png" andURL:  @"https://www.amazon.com/Amazon-Kindle-Paperwhite-6-Inch-4GB-eReader/dp/B00OQVZDJM"];
    
//    // Initialize Companies with Products
//    Company *apple = [[Company alloc]initWithName:@"Apple" andTitle:@"Apple mobile products" andProducts:[[NSMutableArray alloc]initWithObjects:iPad, iPodTouch, iPhone, nil] andImage:@"apple-xxl.png"];
//    
//    Company *samsung = [[Company alloc]initWithName:@"Samsung" andTitle:@"Samsung mobile products" andProducts:[[NSMutableArray alloc]initWithObjects:galaxyS4, galaxyNote, galaxyTab, nil] andImage:@"samsung.jpg"];
//    
//    Company *google = [[Company alloc]initWithName:@"Google" andTitle:@"Google mobile products" andProducts:[[NSMutableArray alloc]initWithObjects:googlePixel, nexus6P, nexus5X, nil] andImage:@"google.png"];
//    
//    Company *amazon = [[Company alloc]initWithName:@"Amazon" andTitle:@"Amazon mobile devices" andProducts:[[NSMutableArray alloc]initWithObjects:amazonFire, kindleFire, kindlePaperWhite, nil] andImage:@"amazon.png"];
    
    // Place all companies into an array
//    self.companyList = [[NSMutableArray alloc]initWithObjects:apple, samsung, google, amazon, nil];
//    [[NSUserDefaults standardUserDefaults] setObject:self.companyList forKey:@"companyList"];
    self.title = @"Mobile device makers";
    self.sharedManager = [DAO sharedManager];
    
}

- (void)viewWillAppear:(BOOL)animated {
    //self.companyList = [[[NSUserDefaults standardUserDefaults] objectForKey:@"companyList"]mutableCopy];
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

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 50;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _sharedManager.companyList.count;
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
    Company *currentCompany = [_sharedManager.companyList objectAtIndex:[indexPath row]];
    cell.textLabel.text = currentCompany.title;
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
        [_sharedManager.companyList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        //[[NSUserDefaults standardUserDefaults] setObject:self.companyList forKey:@"companyList"];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *stringToMove = [_sharedManager.companyList objectAtIndex:sourceIndexPath.row];
    [_sharedManager.companyList removeObjectAtIndex:sourceIndexPath.row];
    [_sharedManager.companyList insertObject:stringToMove atIndex:destinationIndexPath.row];
}

// The 3 methods below enable rearranging of rows on the table view
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//you might be able to get rid of this line
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
    // Change the index path row in the array so the path to "products" is also rearranged
    Company *company = [_sharedManager.companyList objectAtIndex:indexPath.row];
    
    self.productViewController.currentCompany = company;
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
}

@end
