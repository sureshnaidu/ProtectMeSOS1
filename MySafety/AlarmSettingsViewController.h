//
//  AlarmSettingsViewController.h
//  MySafety
//
//  Created by trilok kumar reddy munagala on 03/10/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaveAlaramDelayTime.h"
#import "MBProgressHUD.h"
#import "ProtectmeEventClass.h"
#import <CoreLocation/CoreLocation.h>
@interface AlarmSettingsViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate,UIGestureRecognizerDelegate,UIAlertViewDelegate,UINavigationControllerDelegate,MBProgressHUDDelegate,CLLocationManagerDelegate,NSXMLParserDelegate,CLLocationManagerDelegate>{
        NSString *identifier;
        NSString *userId;
        NSString *phoneNum;
    

    NSMutableURLRequest *settingsRequest;
    MBProgressHUD *HUD;
    NSMutableData *webData;
    CLLocationCoordinate2D coordinate;
    CLLocationManager *locationManager;
    NSString *latitude;
    NSString *longitude;
    NSMutableString *mutableSTR;
    NSMutableArray *mainarray;


}
@property (strong,nonatomic) ProtectmeEventClass *message;

@property (nonatomic,strong) NSMutableURLRequest *settingsRequest;
@property (nonatomic,strong) NSURLConnection *settingsConn;
@property (strong, nonatomic) IBOutlet UITextField *alarmPassword;
@property (strong, nonatomic) IBOutlet UISlider *sliderChanging;
@property (strong, nonatomic) IBOutlet UILabel *secondsLabel;

@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
- (IBAction)PinChange:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *changePin;
- (IBAction)sliderChanging:(UISlider *)sender;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *chagepinText;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;
@property (strong, nonatomic) IBOutlet UITextView *alarmMessage;
- (IBAction)back:(UIButton *)sender;

@property (strong, nonatomic) UINavigationController *nav;

@end
