//
//  SettingsViewController.m
//  MySafety
//
//  Created by Naidu on 9/30/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "SettingsViewController.h"
#import "AlarmSettingsViewController.h"
#import "HelpViewController.h"
#import "EditMyAccountDetailsViewController.h"
#import "AppDelegate.h"
@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    
    [self.navigationController setNavigationBarHidden:YES];


    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
//    self.tabBarController.tabBar.hidden = NO;
    
    NSLog(@"View Controller : %@",self.navigationController);
    
    self.navigationController.navigationItem.title = nil;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    imageview.image = [UIImage imageNamed:@"Settings-Top.PNG"];
    [self.navigationController.navigationBar addSubview:imageview];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logout:(id)sender {

   AppDelegate  *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate facebookLogout];
}

- (IBAction)alarm:(id)sender {
    
    AlarmSettingsViewController *alarm = [[AlarmSettingsViewController alloc]initWithNibName:@"AlarmSettingsViewController" bundle:nil];
    alarm.nav = self.navigationController;
    [self.navigationController pushViewController:alarm animated:YES];
}

- (IBAction)help:(id)sender {
    
    HelpViewController *help = [[HelpViewController alloc]initWithNibName:@"HelpViewController" bundle:nil];
    
    [self.navigationController pushViewController:help animated:YES];
    
}

- (IBAction)editac:(id)sender {
    
    EditMyAccountDetailsViewController *editAc = [[EditMyAccountDetailsViewController alloc]initWithNibName:@"EditMyAccountDetailsViewController" bundle:nil];
    
    [self.navigationController pushViewController:editAc animated:YES];
    
}
@end
