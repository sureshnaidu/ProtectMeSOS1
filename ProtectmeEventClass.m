//
//  ProtectmeEventClass.m
//  ProtectMeSOS
//
//  Created by trilok kumar reddy munagala on 16/11/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "ProtectmeEventClass.h"

@implementation ProtectmeEventClass


-(void)getsoapMessageParameters:(NSString *)userid settingstype:(NSString *)setType relationType:(NSString*)relType mobileNum:(NSString *)pno IMEINo:(NSString*)IMEI latitude:(NSString*)latitude longitude:(NSString*)longitude{
    
    NSLog(@"details :%@ %@ %@ %@ %@ %@",userid,setType,relType,pno,IMEI,latitude);
    NSString *soapm=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ProtectMeEvents xmlns=\"http://tempuri.org/\"><UserID>%@</UserID><RelationShipId>%@</RelationShipId><settingType>%@</settingType><MobileNo>%@</MobileNo><IMEINo>%@</IMEINo><GPSLatitude>%@</GPSLatitude><GPSLongitude>%@</GPSLongitude></ProtectMeEvents></soap:Body></soap:Envelope>",userid,relType,setType, pno, IMEI, latitude,longitude];
    
    NSLog(@"message :%@",soapm);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://182.18.175.194/protectmesos/MySafetyService.asmx"]];
    _request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapm length]];
    
    [_request addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [_request addValue: @"http://tempuri.org/ProtectMeEvents" forHTTPHeaderField:@"SOAPAction"];
    [_request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [_request setHTTPMethod:@"POST"];
    [_request setHTTPBody: [soapm dataUsingEncoding:NSUTF8StringEncoding]];
    _con = [NSURLConnection connectionWithRequest:_request delegate:self];
    
    if (_con)
    {
        NSLog(@"Connection");
    
        _webData = [[NSMutableData alloc]init];
        
    }
    else{
        NSLog(@"not connected");
    }

}
-(void)getSocialNetworkParameters:(NSString *)userid
MapUserIDwithSocialNetworksID:(NSString *)mapuserid
        SocialNetworkEmailAddress:(NSString *)emailAddress SocialNetwok:(NSString *)social API_Key:(NSString*)apiKey AccessToken:(NSString *)AcessToken MobileNo:(NSString*)mobnum IMEINo:(NSString*)iemi latitude:(NSString*)latitude  longitude:(NSString*)longitude{
    
    
    NSString *soapm=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><MapUserIDwithSocialNetworks xmlns=\"http://tempuri.org/\"><MapUserIDwithSocialNetworksID>%@</MapUserIDwithSocialNetworksID><UserID>%@</UserID><SocialNetwork>%@</SocialNetwork><SocialNetworkEmailAddress>%@</SocialNetworkEmailAddress><API_Key>%@</API_Key><AccessToken>%@</AccessToken><MobileNo>%@</MobileNo><IMEINo>%@</IMEINo><GPSLatitude>%@</GPSLatitude><GPSLongitude>%@</GPSLongitude></MapUserIDwithSocialNetworks></soap:Body></soap:Envelope>",mapuserid,userid,social,emailAddress,apiKey,AcessToken,mobnum,iemi,latitude,longitude];
    
    
    
    
    NSLog(@"message :%@",soapm);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://182.18.175.194/protectmesos/MySafetyService.asmx"]];
    _request = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapm length]];
    
    [_request addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [_request addValue: @"http://tempuri.org/MapUserIDwithSocialNetworks" forHTTPHeaderField:@"SOAPAction"];
    [_request addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [_request setHTTPMethod:@"POST"];
    [_request setHTTPBody: [soapm dataUsingEncoding:NSUTF8StringEncoding]];
    _con = [NSURLConnection connectionWithRequest:_request delegate:self];
    
    if (_con)
    {
        NSLog(@"Connection");
        
        _webData = [[NSMutableData alloc]init];
        
    }
    else{
        NSLog(@"not connected");
    }



}






- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    
    return request;
    
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [_webData appendData:data];
    
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection{
    
   // NSMutableString * mutableSTR =[[[NSMutableString alloc]init]autorelease];
    
    
    NSString *srt=[[NSString alloc]initWithData:_webData encoding:NSUTF8StringEncoding];
    NSLog(@"responce:%@",srt);
   }


@end
