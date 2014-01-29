//
//  AlarmSettingsViewController.m
//  MySafety
//
//  Created by trilok kumar reddy munagala on 03/10/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "AlarmSettingsViewController.h"

@interface AlarmSettingsViewController ()
{
    UIView *view2;
    UIView *view;
}

@end

@implementation AlarmSettingsViewController

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
    
    self.alarmMessage.delegate = self;
    
    self.navigationController.navigationBar.hidden = NO;
    
    
    self.alarmPassword.delegate = self;
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    gestureRecognizer.delegate = self;
    [_scroll addGestureRecognizer:gestureRecognizer];
    
    locationManager.delegate=self;
    [locationManager startUpdatingLocation];
    [self getLocation];
    

    // Do any additional setup after loading the view from its nib.
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (string.length>0) {
        
        self.doneButton.enabled = YES;
    }
    else
    {
        self.doneButton.enabled = NO;
    }
    return YES;
}

-(void) hideKeyBoard:(id) sender
{
    [self.scroll setContentOffset:CGPointMake(0, 0) animated:YES];
	[self.alarmMessage resignFirstResponder];
	_scroll.scrollEnabled = FALSE;

}

//- (void)didMoveToParentViewController:(UIViewController *)parent
//{
//    NSLog(@"View Controller : %@",self.nav);
//    if ([parent isEqual:[self.nav.viewControllers objectAtIndex:0]]) {
//        self.nav.title = nil;
//        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, -5, 320, 50)];
//        imageview.image = [UIImage imageNamed:@"Settings-Top.PNG"];
//        [self.nav.navigationBar addSubview:imageview];
//    }
//    // parent is nil if this view controller was removed
//}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBar.hidden = NO;
     self.navigationController.delegate = self;
    
    if ([[SaveAlaramDelayTime getInstance].alaramTime intValue]!=0) {
        self.sliderChanging.value =[[SaveAlaramDelayTime getInstance].alaramTime intValue] ;
        self.secondsLabel.text = [NSString stringWithFormat:@"%@ seconds",[SaveAlaramDelayTime getInstance].alaramTime];
    }
    self.alarmPassword.text =  [SaveAlaramDelayTime getInstance].pin;
    

    [super viewWillAppear:YES];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    imageview.image = [UIImage imageNamed:@"sub-menu.png"];
    [self.navigationController.navigationBar addSubview:imageview];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 10, 60, 30);
    [btn setImage:[UIImage imageNamed:@"back-btn.PNG"] forState:UIControlStateNormal];
    [imageview addSubview:btn];
    
    
    self.changePin.hidden = YES;
    
    self.chagepinText.delegate = self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self scrollViewToCenterOfScreen:textView];
}

- (void)scrollViewToCenterOfScreen:(UIView *)theView {
    
	CGFloat viewCenterY = theView.center.y;
	CGRect applicationFrame = self.scroll.frame;
    
	CGFloat availableHeight = applicationFrame.size.height -100;
    
	CGFloat y = viewCenterY - availableHeight / 2.0;
	if (y < 0) {
		y = 0;
	}
    [self.scroll setContentOffset:CGPointMake(0, y) animated:YES];
}
- (IBAction)PinChange:(id)sender {
    
     self.changePin.hidden = NO;
    [self.chagepinText becomeFirstResponder];
    self.chagepinText.text = nil;
  
    [view2 removeFromSuperview];
    view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    view2.backgroundColor = [UIColor blackColor];
    view2.alpha = 0.8;
    [((UIImageView*)[self.view viewWithTag:300]) addSubview:view2];
    
    [view removeFromSuperview];
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ((UIImageView*)[self.view viewWithTag:100]).frame.size.width, ((UIImageView*)[self.view viewWithTag:100]).frame.size.height)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.8;
    [((UIImageView*)[self.view viewWithTag:400]) addSubview:view];
    
    self.sliderChanging.userInteractionEnabled = NO;
    self.alarmMessage.userInteractionEnabled = NO;
    
    
    
}

- (IBAction)sliderChanging:(UISlider *)sender
{
    self.secondsLabel.text = [NSString stringWithFormat:@"%i seconds" , (int)(sender.value)];
    SaveAlaramDelayTime *saveAlaram = [SaveAlaramDelayTime getInstance];
    saveAlaram.alaramTime = [NSString stringWithFormat:@"%d",(int)(sender.value)];
    NSLog(@"%f",sender.value);
}

- (IBAction)cancel:(id)sender {
    
    self.sliderChanging.userInteractionEnabled = YES;
    self.alarmMessage.userInteractionEnabled = YES;
    
    [view removeFromSuperview];
    [view2 removeFromSuperview];

    
     self.changePin.hidden = YES;
     [self.chagepinText resignFirstResponder];
        
}

- (IBAction)done:(id)sender {
    
    
    // event
    
    _message =[[ProtectmeEventClass alloc]init];
    
    
    
//    UIDevice  *myDevice = [UIDevice currentDevice];
//    identifier =[[NSString alloc]init];
//    identifier= [myDevice.identifierForVendor UUIDString];
//    userId =[[NSString alloc]init];
//    userId = [SaveAlaramDelayTime getInstance].userId;
//    phoneNum=[[NSString alloc]init];
//    phoneNum = [SaveAlaramDelayTime getInstance].phoneNo;
    
    
  
    

    
    
    
    
    
    
    UIDevice *myDevice = [UIDevice currentDevice];
  
    NSString *identifier = [myDevice.identifierForVendor UUIDString];
    NSString *userId =[[NSString alloc]init];
    userId=[SaveAlaramDelayTime getInstance].userId;
    NSString *phoneNum=[[NSString alloc]init];
    phoneNum=[SaveAlaramDelayTime getInstance].phoneNo;
    
    
    
    [_message getsoapMessageParameters:userId settingstype:@"4" relationType:@"15"mobileNum:phoneNum IMEINo:identifier latitude:latitude longitude:longitude];
    
    
    self.sliderChanging.userInteractionEnabled = YES;
    self.alarmMessage.userInteractionEnabled = YES;
    
    [view removeFromSuperview];
    [view2 removeFromSuperview];

    
     self.changePin.hidden = YES;
     [self.chagepinText resignFirstResponder];
    [SaveAlaramDelayTime getInstance].pin = self.chagepinText.text;
     self.alarmPassword.text = self.chagepinText.text;

    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UserSetting xmlns=\"http://tempuri.org/\"><UserSettingID>0</UserSettingID><UserID>%@</UserID><SettingType>15</SettingType><SettingPassword>%@</SettingPassword><SettingDescription>%@</SettingDescription><MobileNo>%@</MobileNo><IMEINo>%@</IMEINo><GPSLatitude>%@</GPSLatitude><GPSLongitude>%@</GPSLongitude></UserSetting></soap:Body></soap:Envelope>",userId,self.alarmPassword.text,self.alarmMessage.text,phoneNum,identifier,latitude,longitude];

    
    NSLog(@" wewewewe :%@",soapMessage);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://182.18.175.194/protectmesos/MySafetyService.asmx"]];
    settingsRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [settingsRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [settingsRequest addValue: @"http://tempuri.org/UserSetting" forHTTPHeaderField:@"SOAPAction"];
    [settingsRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [settingsRequest setHTTPMethod:@"POST"];
    [settingsRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    _settingsConn = [NSURLConnection connectionWithRequest:settingsRequest delegate:self];
    if (_settingsConn)
    {
        NSLog(@"Connection");
        webData = [NSMutableData data];
        
        if (HUD) {
            [HUD removeFromSuperview];
        }
        HUD = [[MBProgressHUD alloc] initWithView:self.view.superview];
        [self.view.superview addSubview:HUD];
        HUD.delegate = self;
        [HUD show:YES];
    
        
    }
    else
    {
        NSLog(@"connection is null");
    }

    
}



- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    
           return settingsRequest;
    
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
    
    [HUD hide:YES];
    
    mutableSTR =[[NSMutableString alloc]init];
                 
   NSXMLParser *parser=[[NSXMLParser alloc]initWithData:webData];
    parser.delegate=self;
   [parser parse];
}


- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    [mutableSTR appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser

{
    NSLog(@"response:%@",mutableSTR);
    mainarray=[[NSMutableArray alloc]init];
    NSDictionary *json2 = [NSJSONSerialization
                           JSONObjectWithData:[mutableSTR dataUsingEncoding:NSUTF8StringEncoding]
                           options:kNilOptions
                           error:nil];
    mainarray = [json2 objectForKey:@"UserSettings"];
    NSLog(@"response:%@",[mainarray objectAtIndex:0]);
    
    if ([[[mainarray objectAtIndex:0]objectForKey:@"Result"] integerValue]==1 ) {
      UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Settings saved Successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        
        [alert show];
    }
    else{
        UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Settings not saved Successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        
        [alert show];
    }
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if ([textField isEqual:self.alarmPassword]) {
        
        [self PinChange:nil];
         return NO;
    }
    else
        return YES;
   
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.chagepinText resignFirstResponder];
    return TRUE;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
   
    
}
- (IBAction)back:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
    [manager stopUpdatingLocation];
    
    latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    
    
    NSLog(@"*dLatitude : %@", latitude);
    NSLog(@"*dLongitude : %@",longitude);
    
}


@end
