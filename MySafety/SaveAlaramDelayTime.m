//
//  SaveAlaramDelayTime.m
//  ProtectMeSOS
//
//  Created by trilok kumar reddy munagala on 26/10/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "SaveAlaramDelayTime.h"

static SaveAlaramDelayTime *instance = nil ;

@implementation SaveAlaramDelayTime

@synthesize alaramTime , countreisDict;

@synthesize userId,pin,userDetails;

+(SaveAlaramDelayTime *)getInstance

{
    
    @synchronized(self)
    
    {
        
        if (instance == nil)
            
        {
            
            instance = [SaveAlaramDelayTime new];
            
        }
        
        
        
    }
    
    return instance ;
    
}

-(void)getConttyListFromRequest

{
    
    NSString *postStr =@"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:soap=\"http://schemas.xmlsoap.org/wsdl/soap/\" xmlns:tm=\"http://microsoft.com/wsdl/mime/textMatching/\" xmlns:soapenc=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:mime=\"http://schemas.xmlsoap.org/wsdl/mime/\" xmlns:tns=\"http://tempuri.org/\" xmlns:s1=\"http://microsoft.com/wsdl/types/\" xmlns:s=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://schemas.xmlsoap.org/wsdl/soap12/\" xmlns:http=\"http://schemas.xmlsoap.org/wsdl/http/\" xmlns:wsdl=\"http://schemas.xmlsoap.org/wsdl/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" ><SOAP-ENV:Body><tns:BindMasters xmlns:tns=\"http://tempuri.org/\">"
    
    "<tns:MobileNo>99487</tns:MobileNo>"
    
    "<tns:IMEINo>45678</tns:IMEINo>"
    
    "<tns:GPSLatitude>98.98</tns:GPSLatitude>"
    
    "<tns:GPSLongitude>78.87</tns:GPSLongitude>"
    
    "</tns:BindMasters></SOAP-ENV:Body></SOAP-ENV:Envelope>";
    
    
    
    NSLog(@"Registering: %@",postStr);
    
    
    
    NSURL *url=[NSURL URLWithString:@"http://182.18.175.194/protectmesos/MySafetyService.asmx"];
    
    NSString *postLength = [NSString stringWithFormat:@"%d", [postStr length]];
    
    NSMutableURLRequest *registerRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    
    [registerRequest setURL:url];
    
    [registerRequest setHTTPMethod:@"POST"];
    
    [registerRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    [registerRequest setValue:@"http://tempuri.org/UserRegistration" forHTTPHeaderField:@"SOAPAction"];
    
    [registerRequest setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [registerRequest setHTTPBody:[postStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    
    
    
    
    
    
    
    
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:registerRequest delegate:self];
    
    
    
    if( theConnection)
        
    {
        
        webData = [NSMutableData data];
        
    }
    
}





- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response

{
    
    return request;
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response

{
    
    
    
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data

{
    
    [webData appendData:data];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection

{
    
    NSLog(@"%@" ,[[NSString alloc]initWithData:webData encoding:NSUTF8StringEncoding]);
    
    countryParse=[[NSXMLParser alloc]initWithData:webData];
    
    [countryParse setDelegate:self];
    
    [countryParse parse];
    
}

- (void)parserDidStartDocument:(NSXMLParser *)parser

{
    
    
    
}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict

{
    
    
    
}



-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string

{
    
    
    
    NSLog(@"%@" , string);
    
    
    
    
    NSDictionary *json2 = [NSJSONSerialization
                           JSONObjectWithData:[[[string componentsSeparatedByString:@"^^^" ] objectAtIndex:0]  dataUsingEncoding:NSUTF8StringEncoding]
                           options:kNilOptions
                           error:nil];
    if (countreisDict)
    {
        
    }
    else
    {
    countreisDict = [[NSMutableArray alloc] init];
    }
    
    for (NSDictionary *dict in [json2 objectForKey:@"CountriesList"])
    {

        [countreisDict addObject:[[NSDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"CountryName"],@"countryName",[dict objectForKey:@"CountryId"],@"countryId",nil] copy]];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName

{
    
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
    
    
}

@end
    

