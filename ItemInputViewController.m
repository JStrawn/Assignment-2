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

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGRect frm = self.view.frame;
    
    self.nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(frm.size.width/4, frm.size.height/3, ((self.view.frame.size.width)/2), 30)];
    self.nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.nameTextField.returnKeyType = UIReturnKeyDone;
    self.nameTextField.delegate = self;

    
    self.tickerTextField = [[UITextField alloc]initWithFrame:CGRectMake(frm.size.width/4, frm.size.height/2.3, ((self.view.frame.size.width)/2), 30)];
    self.tickerTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.tickerTextField.returnKeyType = UIReturnKeyDone;
    self.tickerTextField.delegate = self;

    
    self.imageTextField = [[UITextField alloc]initWithFrame:CGRectMake(frm.size.width/4, frm.size.height/1.85, ((self.view.frame.size.width)/2), 30)];
    self.imageTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.imageTextField.returnKeyType = UIReturnKeyDone;
    self.imageTextField.delegate = self;
    
    [self.view addSubview: self.nameTextField];
    [self.view addSubview: self.tickerTextField];
    [self.view addSubview: self.imageTextField];
    
    if (self.isEditMode == YES)
    {
        self.title = @"Edit a Company";
        self.nameTextField.text = self.companyToEdit.name;
        self.tickerTextField.text = self.companyToEdit.ticker;
        self.imageTextField.text = self.companyToEdit.photo;
    } else {
        self.nameTextField.placeholder = @"Company Name";
        self.tickerTextField.placeholder = @"Ticker Symbol";
        self.imageTextField.placeholder = @"Image.png";
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
    Company *newCompany = [[Company alloc]initWithName:self.nameTextField.text andTicker:self.nameTextField.text andProducts:[[NSMutableArray alloc]init] andImage:self.imageTextField.text];
    
    if (self.isEditMode == YES) {
        
        //overwrite the old company object when hit save
        NSUInteger companyIndex = [self.sharedManager.companyList indexOfObject:self.companyToEdit];
        [self.sharedManager.companyList replaceObjectAtIndex:companyIndex withObject:newCompany];
        
        [[self navigationController] popViewControllerAnimated:YES];
        
    } else {
        
        [self.sharedManager.companyList addObject:newCompany];
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
    NSLog(@"keyboardWillShow");
    //self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Animate the current view out of the way
    [UIView animateWithDuration:0.3f animations:^ {
        self.nameTextField.frame = CGRectMake(75, 100, 170, 30);
        self.tickerTextField.frame = CGRectMake(75, 135, 170, 30);
        self.imageTextField.frame = CGRectMake(75, 170, 170, 30);
    }];
}

-(void)dismissKeyboard
{
    CGRect frm = self.view.frame;

    [UIView animateWithDuration:0.3f animations:^ {
        self.nameTextField.frame = CGRectMake(frm.size.width/4, frm.size.height/3, self.view.frame.size.width/2, 30);
        self.tickerTextField.frame = CGRectMake(frm.size.width/4, frm.size.height/2.3, self.view.frame.size.width/2, 30);
        self.imageTextField.frame = CGRectMake(frm.size.width/4, frm.size.height/1.85, self.view.frame.size.width/2, 30);
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
