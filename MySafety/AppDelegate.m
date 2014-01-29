//
//  AppDelegate.m
//  MySafety
//
//  Created by Naidu on 9/30/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

#import "HomeViewController.h"
#import "GurdiansViewController.h"
#import "ShareViewController.h"
#import "SettingsViewController.h"
#import "UpgradeViewController.h"

@implementation AppDelegate
{
    HomeViewController *home;
    GurdiansViewController *gurdian;
    ShareViewController *share;
    SettingsViewController *setting;
    UpgradeViewController *upgrade;
    
    
    NSString *latitude;
    NSString *longitude;
}

//@synthesize isFBLoginAlertRequired;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    locationManager =[[CLLocationManager alloc]init];
    locationManager.delegate=self;

    [locationManager startUpdatingLocation];
    [self getLocation];

     _userPin=[NSUserDefaults standardUserDefaults];
    
    return YES;
}

-(void)facebookLogout {
    
    
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
}

-(void)TabbarCreation
{
    home = [[HomeViewController alloc]init];
    UINavigationController *homeNaviCon =[[UINavigationController alloc]initWithRootViewController:home];
    home.title = @"Home";
    
    gurdian = [[GurdiansViewController alloc]init];
    UINavigationController *scanNaviCon =[[UINavigationController alloc]initWithRootViewController:gurdian];
    gurdian.title = @"Guardians";
    share =[[ShareViewController alloc]init];
   UINavigationController *myCardNaviCon =[[UINavigationController alloc]initWithRootViewController:share];
   share.title=@"Share";
    setting = [[SettingsViewController alloc]init];
    UINavigationController *eventsNaviCon =[[UINavigationController alloc]initWithRootViewController:setting];
    setting.title = @"Settings";
    
    upgrade  =[[UpgradeViewController alloc]init];
    UINavigationController *contactsNaviCon =[[UINavigationController alloc]initWithRootViewController:upgrade];
   upgrade.title = @"Upgrade";
    
    
    NSArray *viewControllers = [NSArray arrayWithObjects:homeNaviCon,scanNaviCon,myCardNaviCon, eventsNaviCon,contactsNaviCon,nil];
    UITabBarController *tabBarController=[[UITabBarController alloc] init];
    [tabBarController setViewControllers:viewControllers animated:NO];
    UITabBar *tabbarAppearence = [UITabBar appearance];
    
    [tabbarAppearence setBackgroundImage:[UIImage imageNamed:@"menu-back.PNG"]];
    [tabbarAppearence setSelectionIndicatorImage:[UIImage imageNamed:@"icon-back-btn.PNG"]];
    [tabbarAppearence setFrame:CGRectMake(0, 520, 320,50)];
    
    NSArray *unselectedImages = [NSArray arrayWithObjects:@"home-Tab.png",@"guardians-Tab.png",@"share-Tab.png",@"settings-Tab.png",@"upgrade-Tab.png", nil];
    
    NSArray *selectedImages = [NSArray arrayWithObjects:@"home-white.png",@"guardians-white.png",@"share-white.png",@"settings-white.png",@"upgrade-white.png", nil];
   
   NSArray *items = tabBarController.tabBar.items;
    
   // [tabBarController.tabBarItem setAccessibilityFrame:cg
    
    for (int idx=0; idx<items.count; idx++) {
        
        UITabBarItem *item = [items objectAtIndex:idx];
      [item setFinishedSelectedImage:[UIImage imageNamed:[selectedImages objectAtIndex:idx]] withFinishedUnselectedImage:[UIImage imageNamed:[unselectedImages objectAtIndex:idx]]];

           }
    
    _window.rootViewController = tabBarController;
    [_window makeKeyAndVisible];
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




-(void) getLocation{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    coordinate = [location coordinate];
    
    
    
    //    return coordinate;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation: (CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //[manager stopUpdatingLocation];
    
    latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    
    NSLog(@"*dLatitude : %@", latitude);
    NSLog(@"*dLongitude : %@",longitude);
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");
    [manager stopUpdatingLocation];
}

@end
