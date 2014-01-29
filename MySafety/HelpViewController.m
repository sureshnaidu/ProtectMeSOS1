//
//  HelpViewController.m
//  MySafety
//
//  Created by trilok kumar reddy munagala on 03/10/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "HelpViewController.h"
#import "ContactViewController.h"
@interface HelpViewController ()

@end

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    [imageview addSubview:btn];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)contactForm:(id)sender {
    
    ContactViewController *contact = [[ContactViewController alloc]initWithNibName:@"ContactViewController" bundle:nil];
    [self.navigationController pushViewController:contact animated:YES];
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
