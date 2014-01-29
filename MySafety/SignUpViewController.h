//
//  SignUpViewController.h
//  MySafety
//
//  Created by trilok kumar reddy munagala on 02/10/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"
#import "SaveAlaramDelayTime.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface SignUpViewController : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate,NSXMLParserDelegate,UIPickerViewDataSource,UIPickerViewDelegate,NSURLConnectionDelegate,MBProgressHUDDelegate,NSURLConnectionDataDelegate>
{
    NSXMLParser *rssParser;
    MBProgressHUD *HUD;
    NSMutableData *webData;
    int pickerNumber;

}

- (IBAction)signupSucessClose:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *signupSucess;

@property (strong, nonatomic) IBOutlet UIScrollView *scrlView;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *surname;
@property (strong, nonatomic) IBOutlet UITextField *email;

@property (strong, nonatomic) IBOutlet UITextField *country;
@property (strong, nonatomic) IBOutlet UITextField *city;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;
- (IBAction)finish:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *scrollBackground;
- (IBAction)checkmark:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *phone;
- (IBAction)dropDown:(id)sender;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (strong, nonatomic) IBOutlet UIButton *finishButton;
@end
