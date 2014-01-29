//
//  EditMyAccountDetailsViewController.h
//  MySafety
//
//  Created by trilok kumar reddy munagala on 07/10/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface EditMyAccountDetailsViewController : UIViewController<UITextFieldDelegate,UIAlertViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,MBProgressHUDDelegate,NSXMLParserDelegate>
{
    MBProgressHUD *HUD;
}

- (IBAction)dropdown:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *chanepassword;
- (IBAction)changePassword:(id)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *mainBackground;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UIImageView *scrollBg;
@property (strong, nonatomic) IBOutlet UITextField *surname;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *country;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confirmpassword;
@property (strong, nonatomic) IBOutlet UIScrollView *scrlView;
@property (strong, nonatomic) IBOutlet UITextField *old;
@property (strong, nonatomic) IBOutlet UITextField *kothaPassword;
@property (strong, nonatomic) IBOutlet UITextField *confirm;
- (IBAction)save:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)back:(id)sender;

@end
