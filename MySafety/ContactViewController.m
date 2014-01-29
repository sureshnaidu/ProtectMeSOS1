//
//  ContactViewController.m
//  MySafety
//
//  Created by trilok kumar reddy munagala on 03/10/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController
{
    UIAlertView *alert;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    imageview.image = [UIImage imageNamed:@"sub-menu.png"];
    [self.navigationController.navigationBar addSubview:imageview];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 10, 60, 30);
    [btn setImage:[UIImage imageNamed:@"back-btn.PNG"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [imageview addSubview:btn];
    

   
}
- (IBAction)back:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)send:(id)sender {
    
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    
    if (self.name.text.length==0) {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide Name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else if (![[self.name.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString: self.name.text] || ![[self.name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString: self.name.text] )
        
    {
        
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide valid Name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    
    else if (self.surname.text.length==0)
    {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide Surname." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else  if (![[self.surname.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString:self.surname.text])
        
    {
        
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide valid Surname." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    
    else if (self.email.text.length==0)
    {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide Email." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else if ([emailTest evaluateWithObject:self.email.text] == NO) {
        
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Enter Valid Email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    else if (self.message.text.length==0)
    {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide Surname." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
     [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.name resignFirstResponder];
    [self.surname resignFirstResponder];
    [self.email resignFirstResponder];
    [self.message resignFirstResponder];
    
}


@end
