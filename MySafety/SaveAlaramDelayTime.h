//
//  SaveAlaramDelayTime.h
//  ProtectMeSOS
//
//  Created by trilok kumar reddy munagala on 26/10/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SaveAlaramDelayTime : NSObject<NSXMLParserDelegate , NSURLConnectionDataDelegate , NSURLConnectionDelegate>

{
    
    NSString *alaramTime ;
    
    NSString *userId ;
    
    NSXMLParser *countryParse ;
    
    NSMutableData *webData ;
    
    NSMutableArray *countreisDict ;
    
    NSString *pin ;
    
    NSDictionary *userDetails;
    
}

@property (nonatomic , strong) NSString *alaramTime ;

@property (nonatomic , strong) NSString *userId ;

@property (nonatomic , strong) NSMutableArray *countreisDict ;

@property (nonatomic , strong) NSString *pin ;
@property (nonatomic , strong) NSDictionary *userDetails;
@property (nonatomic, strong)  NSString *phoneNo;
+(SaveAlaramDelayTime *)getInstance;

-(void)getConttyListFromRequest;

@end
