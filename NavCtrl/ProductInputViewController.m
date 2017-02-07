//
//  ProductInputViewController.m
//  NavCtrl
//
//  Created by Juliana Strawn on 12/15/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductInputViewController.h"
#import <Quartzcore/Quartzcore.h>
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

-(void)SetTextFieldBorder :(UITextField *)textField{
    
    CALayer *border = [CALayer layer];
    CGFloat borderWidth = 2;
    border.borderColor = [UIColor grayColor].CGColor;
    border.frame = CGRectMake(0, textField.frame.size.height - borderWidth, textField.frame.size.width, textField.frame.size.height);
    border.borderWidth = borderWidth;
    [textField.layer addSublayer:border];
    textField.layer.masksToBounds = YES;
    
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    CGRect frm = self.view.frame;
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(frm.size.width/6, frm.size.height/3, ((self.view.frame.size.width)/1.5), 30)];
    self.nameTextField.borderStyle = UITextBorderStyleNone;
    self.nameTextField.returnKeyType = UIReturnKeyDone;
    self.nameTextField.delegate = self;
    self.nameTextField.textAlignment = NSTextAlignmentCenter;
    [self SetTextFieldBorder:self.nameTextField];
    
    self.imageTextField = [[UITextField alloc]initWithFrame:CGRectMake(frm.size.width/6, frm.size.height/2.3, ((self.view.frame.size.width)/1.5), 30)];
    self.imageTextField.borderStyle = UITextBorderStyleNone;
    self.imageTextField.returnKeyType = UIReturnKeyDone;
    self.imageTextField.delegate = self;
    self.imageTextField.textAlignment = NSTextAlignmentCenter;
    [self SetTextFieldBorder:self.imageTextField];

    
    self.urlTextField = [[UITextField alloc]initWithFrame:CGRectMake(frm.size.width/6, frm.size.height/1.85, ((self.view.frame.size.width)/1.5), 30)];
    self.urlTextField.borderStyle = UITextBorderStyleNone;
    self.urlTextField.returnKeyType = UIReturnKeyDone;
    self.urlTextField.delegate = self;
    self.urlTextField.textAlignment = NSTextAlignmentCenter;
    [self SetTextFieldBorder:self.urlTextField];

    
    [self.view addSubview: self.nameTextField];
    [self.view addSubview: self.imageTextField];
    [self.view addSubview: self.urlTextField];
    
    if (self.isEditMode == YES)
    {
        self.title = @"Edit a Product";
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
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
    
    
    if (self.isEditMode == YES)
    {
     
        NSString *originalProdName = self.productToEdit.name;
        self.productToEdit.name = self.nameTextField.text;
        self.productToEdit.image = self.imageTextField.text;
        self.productToEdit.url = self.urlTextField.text;
        
        [self.sharedManager editManagedProduct:self.productToEdit inCompany:self.currentCompany withOriginalName:originalProdName];
        
        [[self navigationController] popViewControllerAnimated:YES];
        self.isEditMode = NO;
        
    } else {
        
        Product *newProduct = [[Product alloc]initWithName:self.nameTextField.text andImage:self.imageTextField.text andURL:self.urlTextField.text];
        
        [self.currentCompany.products addObject:newProduct];
        
        [self.sharedManager createManagedProduct:newProduct inCompany:self.currentCompany];
        
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
    
        CGRect frm = self.view.frame;

        [UIView animateWithDuration:0.3f animations:^ {
            self.nameTextField.frame = CGRectMake(frm.size.width/6, frm.size.height/11, frm.size.width, 30);
            self.imageTextField.frame = CGRectMake(frm.size.width/6, frm.size.height/6,  frm.size.width, 30);
            self.urlTextField.frame = CGRectMake(frm.size.width/6, frm.size.height/4.1,  frm.size.width, 30);
        }];
        
}

-(void)dismissKeyboard
{
    CGRect frm = self.view.frame;
    
    [UIView animateWithDuration:0.3f animations:^ {
        self.nameTextField.frame = CGRectMake(frm.size.width/6, frm.size.height/3, self.view.frame.size.width, 30);
        self.imageTextField.frame = CGRectMake(frm.size.width/6, frm.size.height/2.3, self.view.frame.size.width, 30);
        self.urlTextField.frame = CGRectMake(frm.size.width/6, frm.size.height/1.85, self.view.frame.size.width, 30);
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

-(void)dealloc {
    [_nameTextField release];
    [_imageTextField release];
    [_urlTextField release];
    [_sharedManager release];
    [_productToEdit release];
    [_currentCompany release];
    [_companyViewController release];
    [super dealloc];
}

@end
