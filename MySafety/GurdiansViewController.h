//
//  GurdiansViewController.h
//  MySafety
//
//  Created by Naidu on 9/30/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"
#import "ProtectmeEventClass.h"


#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@class TableviewCell;
@interface GurdiansViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,NSXMLParserDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    NSMutableData *webData;
    CLLocationManager *locationManager ;
    CLLocation *location;
}
- (IBAction)addGurdian:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *addGurdianView;
- (IBAction)SaveGurdian:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *headerLaBEL;
@property (strong, nonatomic) IBOutlet UIButton *addGurdianButton;

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *surname;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSMutableArray *gurdiansArray,*gurdiansPhoneArray,*AlertBySMSArray,*AlertByCallArray,*surNAmeArray,*emailArray,*guardianIdArray,*mainArray;
- (IBAction)alertMySMS:(id)sender;
- (IBAction)alertByPhone:(id)sender;
-(void)showingGuardians;
-(void)settingTheValues:(int)sender;
@property (strong,nonatomic) ProtectmeEventClass *message;

@end
