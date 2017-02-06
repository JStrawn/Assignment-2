//
//  ItemInputViewController.m
//  NavCtrl
//
//  Created by Juliana Strawn on 12/13/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ItemInputViewController.h"
#import "Company.h"
#import "DAO.h"
#import <QuartzCore/Quartzcore.h>

@interface ItemInputViewController () <UITextFieldDelegate>

@end

@implementation ItemInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sharedManager = [DAO sharedManager];
    
    self.title = @"Create a New Company";
    
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

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGRect frm = self.view.frame;
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(frm.size.width/6, frm.size.height/3, ((self.view.frame.size.width)/1.5), 30)];
    self.nameTextField.borderStyle = UITextBorderStyleNone;
    self.nameTextField.returnKeyType = UIReturnKeyDone;
    self.nameTextField.delegate = self;
    self.nameTextField.textAlignment = NSTextAlignmentCenter;
    [self SetTextFieldBorder:self.nameTextField];


    
    self.tickerTextField = [[UITextField alloc]initWithFrame:CGRectMake(frm.size.width/6, frm.size.height/2.3, ((self.view.frame.size.width)/1.5), 30)];
    self.tickerTextField.borderStyle = UITextBorderStyleNone;
    self.tickerTextField.returnKeyType = UIReturnKeyDone;
    self.tickerTextField.delegate = self;
    self.tickerTextField.textAlignment = NSTextAlignmentCenter;
    [self SetTextFieldBorder:self.tickerTextField];


    
    self.imageTextField = [[UITextField alloc]initWithFrame:CGRectMake(frm.size.width/6, frm.size.height/1.85, ((self.view.frame.size.width)/1.5), 30)];
    self.imageTextField.borderStyle = UITextBorderStyleNone;
    self.imageTextField.returnKeyType = UIReturnKeyDone;
    self.imageTextField.delegate = self;
    self.imageTextField.textAlignment = NSTextAlignmentCenter;
    self.imageTextField.adjustsFontSizeToFitWidth = YES;
    self.imageTextField.minimumFontSize = 2.0;

    [self SetTextFieldBorder:self.imageTextField];

    
    [self.view addSubview: self.nameTextField];
    [self.view addSubview: self.tickerTextField];
    [self.view addSubview: self.imageTextField];
    
    if (self.isEditMode == YES)
    {
        self.title = @"Edit a Company";
        self.nameTextField.text = self.companyToEdit.name;
        self.tickerTextField.text = self.companyToEdit.ticker;
        self.imageTextField.text = self.companyToEdit.imageURL;
    } else {
        self.nameTextField.placeholder = @"Company Name";
        self.tickerTextField.placeholder = @"Ticker Symbol";
        self.imageTextField.placeholder = @"Image URL";
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
    
        if (self.isEditMode == YES) {
        
        //if edit mode, replace the current one on company list but also add to core data
        //or should i just add it to core data and fetch the results
        //make addedCompany method in DAO - look for equivalent company in managedCompany
        
        //we're editing, not adding, change properties, call method in DAO
        //not making anything new, just accessing and editing
        //editing a managed company,
        
        self.companyToEdit.name = self.nameTextField.text;
        self.companyToEdit.ticker = self.tickerTextField.text;
        self.companyToEdit.imageURL = self.imageTextField.text;
            
            //DAO Method that edits the corresponding company in managedcompany array
        
            [self.sharedManager editManagedCompany:self.companyToEdit];
            
            [self.navigationController popViewControllerAnimated:YES];
        
    } else {
        Company *newCompany = [[Company alloc]initWithName:self.nameTextField.text andTicker:self.tickerTextField.text andProducts:[[NSMutableArray alloc]init] andImage:self.imageTextField.text];
        
        [self.sharedManager.companyList addObject:newCompany];
        
        //the method in DAO creates managed company based on basic company
        
        [self.sharedManager createManagedCompany:newCompany];
        
        [[self navigationController] popViewControllerAnimated:YES];
        [self.sharedManager loadStockPrices];
        
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
        self.tickerTextField.frame = CGRectMake(frm.size.width/6, frm.size.height/6,  frm.size.width, 30);
        self.imageTextField.frame = CGRectMake(frm.size.width/6, frm.size.height/4.1,  frm.size.width, 30);
        
        self.nameTextField.textAlignment = NSTextAlignmentLeft;
        self.tickerTextField.textAlignment = NSTextAlignmentLeft;
        self.imageTextField.textAlignment = NSTextAlignmentLeft;

    }];
}

-(void)dismissKeyboard
{
    CGRect frm = self.view.frame;

    [UIView animateWithDuration:0.3f animations:^ {
        self.nameTextField.frame = CGRectMake(frm.size.width/6, frm.size.height/3, self.view.frame.size.width, 30);
        self.tickerTextField.frame = CGRectMake(frm.size.width/6, frm.size.height/2.3, self.view.frame.size.width, 30);
        self.imageTextField.frame = CGRectMake(frm.size.width/6, frm.size.height/1.85, self.view.frame.size.width, 30);
        
        
        self.nameTextField.adjustsFontSizeToFitWidth = NO;
        self.tickerTextField.adjustsFontSizeToFitWidth = NO;
        self.imageTextField.adjustsFontSizeToFitWidth = YES;

        self.nameTextField.textAlignment = NSTextAlignmentCenter;
        self.tickerTextField.textAlignment = NSTextAlignmentCenter;
        self.imageTextField.textAlignment = NSTextAlignmentCenter;
        
        self.nameTextField.center = self.view.center;
        self.tickerTextField.center = self.view.center;
        self.imageTextField.center = self.view.center;
    
    }];

    
    [self.view endEditing:YES];
    


}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
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
