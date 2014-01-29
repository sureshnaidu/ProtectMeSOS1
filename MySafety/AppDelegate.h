//
//  AppDelegate.h
//  MySafety
//
//  Created by Naidu on 9/30/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate>
{
    NSArray* _permissions;
    NSDictionary *statuses1;
    NSMutableDictionary *facebookDetails;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D coordinate;
}
@property (strong, nonatomic) NSUserDefaults *userPin;
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) UINavigationController *navController;
-(void)TabbarCreation;
-(void)facebookLogout;


@end
