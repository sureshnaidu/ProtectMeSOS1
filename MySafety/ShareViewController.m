//
//  ShareViewController.m
//  MySafety
//
//  Created by Naidu on 9/30/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "ShareViewController.h"
#import <Social/Social.h>
@interface ShareViewController ()

@end

@implementation ShareViewController

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
    
    locationManager=[[CLLocationManager alloc]init];
    
    locationManager.delegate=self;
    [self getLocation];
    [locationManager startUpdatingLocation];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    imageview.image = [UIImage imageNamed:@"Share-Top.png"];
    [self.navigationController.navigationBar addSubview:imageview];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)fb:(id)sender {
    
    
    //event
    
    
    //if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
//    {
        SLComposeViewController *tweetSheetOBJ = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeFacebook];
        [tweetSheetOBJ setInitialText:@"Sharing myapp through facebook"];
        [self presentViewController:tweetSheetOBJ animated:YES completion:nil];
   // }
    
    
    
    _message =[[ProtectmeEventClass alloc]init];
    
    
    
    UIDevice  *myDevice = [UIDevice currentDevice];
    identifier =[[NSString alloc]init];
    identifier= [myDevice.identifierForVendor UUIDString];
    userId =[[NSString alloc]init];
    userId = [SaveAlaramDelayTime getInstance].userId;
    phoneNum=[[NSString alloc]init];
    phoneNum = [SaveAlaramDelayTime getInstance].phoneNo;
    
    
    [_message getSocialNetworkParameters:userId MapUserIDwithSocialNetworksID:@"0" SocialNetworkEmailAddress:@"asd@gmail.com" SocialNetwok:@"5" API_Key:@"123" AccessToken:@"s" MobileNo:phoneNum IMEINo:identifier latitude:latitude longitude:longitude];
    
    

    
}
- (IBAction)twitter:(id)sender {
    
    //event
    
   
    
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
//    {
        SLComposeViewController *tweetSheetOBJ = [SLComposeViewController
                                                  composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheetOBJ setInitialText:@"Sharing myapp through Twitter"];
        [self presentViewController:tweetSheetOBJ animated:YES completion:nil];
    //}
    
    
    
    _message =[[ProtectmeEventClass alloc]init];
    
    UIDevice  *myDevice = [UIDevice currentDevice];
    identifier =[[NSString alloc]init];
    identifier= [myDevice.identifierForVendor UUIDString];
    userId =[[NSString alloc]init];
    userId = [SaveAlaramDelayTime getInstance].userId;
    phoneNum=[[NSString alloc]init];
    phoneNum = [SaveAlaramDelayTime getInstance].phoneNo;
    
    
    [_message getSocialNetworkParameters:userId MapUserIDwithSocialNetworksID:@"0" SocialNetworkEmailAddress:NULL SocialNetwok:@"6" API_Key:NULL AccessToken:NULL MobileNo:phoneNum IMEINo:identifier latitude:latitude longitude:longitude];
}
-(void) getLocation{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    CLLocation *location = [locationManager location];
    coordinate = [location coordinate];
    }


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation: (CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    NSLog(@"*dLatitude : %@", latitude);
    NSLog(@"*dLongitude : %@",longitude);
    
}
@end
