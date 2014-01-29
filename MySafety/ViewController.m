//
//  ViewController.m
//  MySafety
//
//  Created by Naidu on 9/30/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "SignUpViewController.h"
#import "AppDelegate.h"
#import "TakeTourViewController.h"
#import "SaveAlaramDelayTime.h"
#import "ProtectmeEventClass.h"
@interface ViewController ()
@end

@implementation ViewController
{
    CLLocationCoordinate2D coordinate;
    NSString *latitude;
    NSString *longitude;
    MBProgressHUD *HUD ;
    NSMutableString *mutableStr;
    
    UIView *view2;
    UIView *view;
    UIView *view3;
}
AppDelegate *appDelegate;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[SaveAlaramDelayTime getInstance] getConttyListFromRequest];
    
    
      appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
//    if ([[UIScreen mainScreen] bounds].size.height==480) {
//        
//        self.getStartedBtn.frame = CGRectMake(self.getStartedBtn.frame.origin.x, self.getStartedBtn.frame.origin.y-30,  self.getStartedBtn.frame.size.width, self.getStartedBtn.frame.size.height);
//        
//        self.takeTourbtn.frame = CGRectMake(self.takeTourbtn.frame.origin.x, self.takeTourbtn.frame.origin.y-30,  self.takeTourbtn.frame.size.width, self.takeTourbtn.frame.size.height);
//        
//        self.GetStartedView.frame = CGRectMake(self.GetStartedView.frame.origin.x, self.GetStartedView.frame.origin.y-80,  self.GetStartedView.frame.size.width, self.GetStartedView.frame.size.height);
//        
//        self.loginView.frame = CGRectMake(self.loginView.frame.origin.x, self.loginView.frame.origin.y-50,  self.loginView.frame.size.width, self.loginView.frame.size.height);
//        
//        self.forgotPassword.frame = CGRectMake(self.forgotPassword.frame.origin.x, self.loginView.frame.origin.y,  self.forgotPassword.frame.size.width, self.forgotPassword.frame.size.height);
//        
//        
//    }
    
    
    //[pro getsoapMessage:@"hi ra jaffa"];
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBar.hidden = YES;
    self.GetStartedView.hidden = YES;
    self.loginView.hidden = YES;
    self.forgotPassword.hidden = YES;
    self.recovertextfield.delegate = self;
    self.email.delegate = self;
    self.password.delegate = self;
    
  
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getStarted:(id)sender {
        
  self.logo.frame = CGRectMake(55, 60, self.logo.frame.size.width,self.logo.frame.size.height);
    
    self.mainBackground.image = [UIImage imageNamed:@"Login Screen-bg.png"];
    
    self.GetStartedView.hidden = NO;
    
}

- (IBAction)takeTour:(id)sender {
    
    TakeTourViewController *takeTour = [[TakeTourViewController alloc]initWithNibName:@"TakeTourViewController" bundle:nil];
    [self.navigationController pushViewController:takeTour animated:YES];
}


- (IBAction)SignIn:(id)sender {
    
    self.loginView.hidden = NO;
    
    [view2 removeFromSuperview];
    view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    view2.backgroundColor = [UIColor blackColor];
    view2.alpha = 0.8;
    [self.mainBackground addSubview:view2];
    
    [view removeFromSuperview];
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.GetStartedView.frame.size.width, self.GetStartedView.frame.size.height)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.8;
    [self.GetStartedView addSubview:view];
    
    self.logo.alpha = 0.4;
    self.email.text = nil;
    self.password.text = nil;
    
//    self.mainBackground.alpha = 0.4;
//    self.getStartedBtn.alpha = 0;
//    self.takeTourbtn.alpha = 0;
//    self.loginBg.alpha = 0.4;
    
}

- (IBAction)signUp:(id)sender {
    
    SignUpViewController *signUp = [[SignUpViewController alloc]initWithNibName:@"SignUpViewController" bundle:nil];
    
    [self.navigationController pushViewController:signUp animated:YES];
}
- (IBAction)cancel:(id)sender {
}

- (IBAction)done:(id)sender {
    
//    screenItem = 1;
//    
//    HomeViewController *home = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
//    
//    [self.navigationController pushViewController:home animated:YES];

    
    
    NSString *postStr =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:soap=\"http://schemas.xmlsoap.org/wsdl/soap/\" xmlns:tm=\"http://microsoft.com/wsdl/mime/textMatching/\" xmlns:soapenc=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:mime=\"http://schemas.xmlsoap.org/wsdl/mime/\" xmlns:tns=\"http://tempuri.org/\" xmlns:s1=\"http://microsoft.com/wsdl/types/\" xmlns:s=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://schemas.xmlsoap.org/wsdl/soap12/\" xmlns:http=\"http://schemas.xmlsoap.org/wsdl/http/\" xmlns:wsdl=\"http://schemas.xmlsoap.org/wsdl/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" ><SOAP-ENV:Body><tns:UserLogin xmlns:tns=\"http://tempuri.org/\"><tns:AppOrSocialUser>1</tns:AppOrSocialUser><tns:UserEmailAddress>%@</tns:UserEmailAddress><tns:Password>%@</tns:Password><tns:API_Key>0</tns:API_Key><tns:AccessToken>0</tns:AccessToken><tns:AccountNo>0</tns:AccountNo><tns:MobileNo>45678</tns:MobileNo><tns:IMEINumber>456789</tns:IMEINumber><tns:GPSLatitude>%@</tns:GPSLatitude><tns:GPSLongitude>%@</tns:GPSLongitude></tns:UserLogin></SOAP-ENV:Body></SOAP-ENV:Envelope>",self.email.text ,self.password.text,@"1.0",@"1.0"];
    

    NSLog(@"Registering: %@",postStr);
    
    NSURL *url=[NSURL URLWithString:@"http://182.18.175.194/protectmesos/MySafetyService.asmx"];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postStr length]];

    NSMutableURLRequest *loginRequest = [[NSMutableURLRequest alloc] initWithURL:url];
    [loginRequest setURL:url];
    [loginRequest setHTTPMethod:@"POST"];
    [loginRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [loginRequest setValue:@"http://tempuri.org/UserLogin" forHTTPHeaderField:@"SOAPAction"];
    [loginRequest setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [loginRequest setHTTPBody:[postStr dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSURLConnection *loginConnection = [[NSURLConnection alloc] initWithRequest:loginRequest delegate:self];;
    
    if( loginConnection )
    {
        webData = [NSMutableData data];
        
        if (HUD)
        {
            [HUD removeFromSuperview];
        }
        HUD = [[MBProgressHUD alloc] initWithView:self.view.superview];
        [self.view.superview addSubview:HUD];
        HUD.delegate = self;
        [HUD show:YES];
        
        
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }
    
}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    return request ;
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
       
    [webData appendData:data];
    
}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection{
    
    
      mutableStr = [[NSMutableString alloc] init];
    loginXmlParser=[[NSXMLParser alloc]initWithData:webData];
    [loginXmlParser setDelegate:self];
    [loginXmlParser parse];
    
  
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
 
    [mutableStr appendString:string];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser

{
    NSLog(@"Found Character: %@",mutableStr);
    
    NSDictionary *json2 = [NSJSONSerialization
                           JSONObjectWithData:[mutableStr dataUsingEncoding:NSUTF8StringEncoding]
                           options:kNilOptions
                           error:nil];
    
    NSLog(@"  %@  ",[[[json2 objectForKey:@"LoginDetails"] objectAtIndex:0] objectForKey:@"UserID"]);
    
    [SaveAlaramDelayTime getInstance].userId = [[[json2 objectForKey:@"LoginDetails"] objectAtIndex:0] objectForKey:@"UserID"];
    [SaveAlaramDelayTime getInstance].userDetails = [[json2 objectForKey:@"LoginDetails"] objectAtIndex:0];
    
    [SaveAlaramDelayTime getInstance].phoneNo=[[[json2 objectForKey:@"LoginDetails"] objectAtIndex:0]objectForKey:@"MobileNo"];
    
    NSString *password=[[[json2 objectForKey:@"LoginDetails"]objectAtIndex:0]valueForKey:@"UserPassword"];
    
    NSLog(@"our password is %@",self.password.text);
    
    if (![[[[json2 objectForKey:@"LoginDetails"] objectAtIndex:0] objectForKey:@"Result"] isEqualToString:@"Invalid UserName"] && [password isEqualToString:self.password.text]) {
        [appDelegate TabbarCreation];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Invalid Username or Password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        [HUD setHidden:YES];
    }

}

- (IBAction)forgotPassword:(id)sender {
    
    [view2 removeFromSuperview];
    view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    view2.backgroundColor = [UIColor blackColor];
    view2.alpha = 0.8;
    //[self.GetStartedView addSubview:view2];

    [self.mainBackground addSubview:view2];
    
    [view removeFromSuperview];
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.GetStartedView.frame.size.width, self.GetStartedView.frame.size.height)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.8;
    [self.GetStartedView addSubview:view];


    self.loginView.hidden = YES;
    self.forgotPassword.hidden = NO;
    self.recovertextfield.text = nil;


}
- (IBAction)forgotCancel:(id)sender {
    
    [self.recovertextfield resignFirstResponder];
    self.forgotPassword.hidden = YES;
    //self.loginView.hidden = NO;
    [view removeFromSuperview];

    [view2 removeFromSuperview];

}

- (IBAction)loginCancel:(id)sender {
    
    self.forgotPassword.hidden = YES;
    self.loginView.hidden = YES;
    [self.email resignFirstResponder];
    [self.password resignFirstResponder];
    [view removeFromSuperview];
    [view2 removeFromSuperview];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (![textField isEqual:self.recovertextfield]) {
        [self.email resignFirstResponder];
        [self.password resignFirstResponder];
    }
    else
    {
    [self.recovertextfield resignFirstResponder];
    self.forgotPassword.hidden = YES;
        [self.view addSubview:self.recoverView];
        
//    
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please check your email and follow the instructions to reset password" delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil];
//        [alert setTag:52];
//    [alert show];
//    [alert release];
   
    }
     return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    
if (self.email.text.length>0 && self.password.text.length>0)
{
 self.loginDone.enabled = YES;
 }
 else
 {
 self.loginDone.enabled = NO;
 }
    return YES;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==52) {
        [view removeFromSuperview];
        [view2 removeFromSuperview];
    }
    
}
- (IBAction)cancelRecoverView:(id)sender {
    
    [self.recoverView removeFromSuperview];
    [view removeFromSuperview];
    
    [view2 removeFromSuperview];
}
@end
