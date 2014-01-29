//
//  ViewController.h
//  MySafety
//
//  Created by Naidu on 9/30/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"
@class SaveAlaramDelayTime;
@interface ViewController : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate,MBProgressHUDDelegate,NSXMLParserDelegate,UIAlertViewDelegate>
{
    BOOL _posting;
    NSMutableData *webData ;
    NSXMLParser *loginXmlParser ;

}
- (IBAction)cancelRecoverView:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *cancelRecoverView;
@property (strong, nonatomic) IBOutlet UIView *recoverView;
- (IBAction)getStarted:(id)sender;
- (IBAction)takeTour:(id)sender;
- (IBAction)SignIn:(id)sender;
- (IBAction)signUp:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *GetStartedView;
@property (strong, nonatomic) IBOutlet UIView *loginView;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)forgotPassword:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *forgotPassword;
- (IBAction)forgotCancel:(id)sender;
- (IBAction)loginCancel:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *recovertextfield;
@property (strong, nonatomic) IBOutlet UIButton *loginDone;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;


//properties

@property (strong, nonatomic) IBOutlet UIImageView *mainBackground;

@property (strong, nonatomic) IBOutlet UIImageView *loginBg;
@property (strong, nonatomic) IBOutlet UIButton *getStartedBtn;
@property (strong, nonatomic) IBOutlet UIButton *takeTourbtn;
@property (strong, nonatomic) IBOutlet UIImageView *logo;

@end
