//
//  ProtectmeEventClass.h
//  ProtectMeSOS
//
//  Created by trilok kumar reddy munagala on 16/11/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"
#import "SaveAlaramDelayTime.h"

@interface ProtectmeEventClass : NSObject<CLLocationManagerDelegate,NSXMLParserDelegate,MBProgressHUDDelegate,NSURLConnectionDelegate>{
    
   
    CLLocationManager *locationManager;
    CLLocationCoordinate2D *coordinate;
    MBProgressHUD *HUD;
    NSMutableData * webData;

}

-(void)getsoapMessageParameters:(NSString *)userid settingstype:(NSString *)setType relationType:(NSString*)relType mobileNum:(NSString *)pno IMEINo:(NSString*)IMEI latitude:(NSString*)latitude longitude:(NSString *)longitude;
-(void)getSocialNetworkParameters:(NSString *)userid
    MapUserIDwithSocialNetworksID:(NSString *)mapuserid
        SocialNetworkEmailAddress:(NSString *)emailAddress SocialNetwok:(NSString *)social API_Key:(NSString*)apiKey AccessToken:(NSString *)AcessToken MobileNo:(NSString*)mobnum IMEINo:(NSString*)iemi latitude:(NSString*)latitude  longitude:(NSString*)longitude;


@property (strong,nonatomic) NSMutableURLRequest *request;
@property (strong,nonatomic) NSURLConnection *con;
@property (strong,nonatomic) NSMutableData * webData;
@end
