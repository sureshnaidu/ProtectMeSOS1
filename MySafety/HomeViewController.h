//
//  HomeViewController.h
//  MySafety
//
//  Created by Naidu on 9/30/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "SBTableAlert.h"
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"
#import "ProtectmeEventClass.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <CFNetwork/CFNetwork.h>
#import "ASIFormDataRequest.h"
@interface HomeViewController : UIViewController<UIAlertViewDelegate,SBTableAlertDelegate, SBTableAlertDataSource,UIAlertViewDelegate,NSURLConnectionDelegate,NSXMLParserDelegate,MBProgressHUDDelegate,CLLocationManagerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    NSMutableData *webData;

    NSMutableString *mutableSTR;
    
    NSString *latitude;
    NSString *longitude;
    NSMutableURLRequest *deactivateAlarmReq;
    NSURLConnection *deactCon;
    MBProgressHUD *HUD;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D coordinate;
    NSString *identifier;
    NSString *userId;
    NSString *phoneNum;
    UIAlertView *alert23;
    NSMutableString *resultString;
    SBTableAlert *alert;
    BOOL tag;
    BOOL cameraDitected;
    UIImageView *image1;
    BOOL newMedia;
    

    
    
}
-(void)sos:(id)sender;
@property (strong,nonatomic) SBTableAlert *alert;
@property (strong,nonatomic) NSString *soapm;
@property (strong,nonatomic) ProtectmeEventClass *message;
@property (strong, nonatomic) IBOutlet UIImageView *sosImage;
@property (strong, nonatomic) IBOutlet UIImageView *mainBg;
- (IBAction)imhere:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *imherebutton;
- (IBAction)fakecall:(id)sender;
- (IBAction)mysafetyTest:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *mysafetybutton;
@property (strong, nonatomic) IBOutlet UIButton *fakeCallButton;
- (IBAction)followMe:(id)sender;
- (IBAction)fileUpload:(id)sender;
@property (strong,nonatomic) NSURL *movieURL;


@end
