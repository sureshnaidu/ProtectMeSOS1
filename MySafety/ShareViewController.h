//
//  ShareViewController.h
//  MySafety
//
//  Created by Naidu on 9/30/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "ProtectmeEventClass.h"

@interface ShareViewController : UIViewController<CLLocationManagerDelegate>{
    NSString *identifier;
    NSString *userId;
    NSString *phoneNum;
    NSString *latitude;
    NSString *longitude;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D coordinate;
}
- (IBAction)fb:(id)sender;
- (IBAction)twitter:(id)sender;
@property (strong,nonatomic) ProtectmeEventClass *message;

@end
