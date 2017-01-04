//
//  ProductInputViewController.m
//  NavCtrl
//
//  Created by Juliana Strawn on 12/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductInputViewController.h"
#import "Product.h"
#import "Company.h"
#import "DAO.h"
#import "CompanyViewController.h"

@interface ProductInputViewController () <UITextFieldDelegate>

@end

@implementation ProductInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sharedManager = [DAO sharedManager];

    self.title = @"Create a New Product";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(didPressButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGRect frm = self.view.frame;
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(frm.size.width/4, frm.size.height/3, ((self.view.frame.size.width)/2), 30)];
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTextField.returnKeyType = UIReturnKeyDone;
    self.nameTextField.delegate = self;
    
    self.imageTextField = [[UITextField alloc]initWithFrame:CGRectMake(frm.size.width/4, frm.size.height/2.3, ((self.view.frame.size.width)/2), 30)];
    self.imageTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.imageTextField.returnKeyType = UIReturnKeyDone;
    self.imageTextField.delegate = self;
    
    self.urlTextField = [[UITextField alloc]initWithFrame:CGRectMake(frm.size.width/4, frm.size.height/1.85, ((self.view.frame.size.width)/2), 30)];
    self.urlTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.urlTextField.returnKeyType = UIReturnKeyDone;
    self.urlTextField.delegate = self;

    [self.view addSubview: self.nameTextField];
    [self.view addSubview: self.imageTextField];
    [self.view addSubview: self.urlTextField];
    
    if (self.isEditMode == YES)
    {
        self.title = @"Edit a Company";
        self.nameTextField.text = self.productToEdit.name;
        self.imageTextField.text = self.productToEdit.image;
        self.urlTextField.text = self.productToEdit.url;
    } else {
        self.nameTextField.placeholder = @"Product Name";
        self.imageTextField.placeholder = @"Image.png";
        self.urlTextField.placeholder = @"www.apple.com/iphone";
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dismissKeyboard)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}


- (void)didPressButton
{
    Product *newProduct = [[Product alloc]initWithName:self.nameTextField.text andImage:self.imageTextField.text andURL:self.urlTextField.text];
    
    if (self.isEditMode == YES)
    {
        NSUInteger productIndex = [self.currentCompany.products indexOfObject:self.productToEdit];
        [self.currentCompany.products replaceObjectAtIndex:productIndex withObject:newProduct];
        [[self navigationController] popViewControllerAnimated:YES];
        self.isEditMode = NO;

    } else {
        [self.currentCompany.products addObject:newProduct];
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    [UIView animateWithDuration:0.3f animations:^ {
        self.nameTextField.frame = CGRectMake(75, 100, 170, 30);
        self.imageTextField.frame = CGRectMake(75, 135, 170, 30);
        self.urlTextField.frame = CGRectMake(75, 170, 170, 30);
        
    }];
}

-(void)dismissKeyboard
{
    CGRect frm = self.view.frame;
    
    [UIView animateWithDuration:0.3f animations:^ {
        self.nameTextField.frame = CGRectMake(frm.size.width/4, frm.size.height/3, self.view.frame.size.width/2, 30);
        self.imageTextField.frame = CGRectMake(frm.size.width/4, frm.size.height/2.3, self.view.frame.size.width/2, 30);
        self.urlTextField.frame = CGRectMake(frm.size.width/4, frm.size.height/1.85, self.view.frame.size.width/2, 30);
    }];
    
    [self.view endEditing:YES];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [self.view endEditing:YES];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
