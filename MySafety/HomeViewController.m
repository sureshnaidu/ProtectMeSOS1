//
//  HomeViewController.m
//  MySafety
//
//  Created by Naidu on 9/30/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "HomeViewController.h"
#import "GRAlertView.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "SaveAlaramDelayTime.h"
@interface HomeViewController ()
@end
static int i;
@implementation HomeViewController
{
    NSMutableArray *alertviewArray,*array;
    int checkedVaue,fakeCheck;
    UIAlertView *fakeAlert;
    AVAudioPlayer *player;
}
GRAlertView *alert2,*mysafetyAlert;


int checkingdeactivate,checkingMysafetydeactivate;

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
//    self.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"HOMEEE" image:[UIImage imageNamed:@"home-Tab"] selectedImage:[UIImage imageNamed:@"home-white"]];
   
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 340, 50)];;
    imageview.image = [UIImage imageNamed:@"background.png"];
    [self.navigationController.navigationBar addSubview:imageview];
    [self.navigationController setNavigationBarHidden:YES];

    //[self.navigationController setNavigationBarHidden:YES];
    
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sos:)];
    gesture.numberOfTapsRequired = 1;
    [self.sosImage addGestureRecognizer:gesture];
    
    alertviewArray = [[NSMutableArray alloc]initWithObjects:@"all",@"Gurdian1",@"Gurdian2", nil];
    array = [[NSMutableArray alloc]init];
    
    if ([[UIScreen mainScreen] bounds].size.height==480) {
        
        self.mainBg.frame = CGRectMake(0, 0, 320, 480);
        
        self.sosImage.frame =  CGRectMake(102,12,116,107);
        
        ((UIButton*)[self.view viewWithTag:10]).frame =  CGRectMake(253,7,38,37);
        
        
        ((UIButton*)[self.view viewWithTag:11]).frame =  CGRectMake(20,141,104,72);
        
        ((UIButton*)[self.view viewWithTag:12]).frame =  CGRectMake(187,141,104,72);
        
        ((UIButton*)[self.view viewWithTag:13]).frame =  CGRectMake(20,262,104,72);
        
        ((UIButton*)[self.view viewWithTag:14]).frame =  CGRectMake(187,262,104,72);
    }
    locationManager=[[CLLocationManager alloc]init];

    locationManager.delegate=self;
    [self getLocation];
    [locationManager startUpdatingLocation];
    
    SBTableAlert *t=[[SBTableAlert alloc]init];
    t.delegate=self;
    t.dataSource=self;
    
    //*******
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}

-(void)sos:(UITapGestureRecognizer*)sender {
    
    
    
    if (![self.sosImage.image isEqual:[UIImage imageNamed:@"sos-red.png"]]) {
        
   
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"SOS Alarm has been activated you have 3 seconds to deactivate it." delegate:self cancelButtonTitle:@"De activate" otherButtonTitles:nil];
    [alert setTag:52];
    [alert show];
    checkingdeactivate = 0;
    [self performSelector:@selector(redalert:) withObject:alert afterDelay:3];
    }
    
    else
    {
        alert23 = [[UIAlertView alloc]initWithTitle:nil message:@"Please Enter pincode to deactivate SOS Alarm." delegate:self cancelButtonTitle:@"De activate" otherButtonTitles:nil];
        [alert23 setTag:54];
        alert23.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alert23 show];

    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==52) {
        checkingdeactivate = 52;
    }
   else if (alertView.tag==53) {
        [self performSelector:@selector(closeredalert:) withObject:alert2 afterDelay:0];
    }
   else if (alertView.tag==54) {

       ////////////
       
       UIDevice  *myDevice = [UIDevice currentDevice];
       identifier =[[NSString alloc]init];
       identifier= [myDevice.identifierForVendor UUIDString];
       userId =[[NSString alloc]init];
       userId = [SaveAlaramDelayTime getInstance].userId;
       phoneNum=[[NSString alloc]init];
       phoneNum = [SaveAlaramDelayTime getInstance].phoneNo;
       
       NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><DeactiveAlaram xmlns=\"http://tempuri.org/\"><UserId>%@</UserId><SettingType>4</SettingType><Password>%@</Password><MobileNo>%@</MobileNo><IMEINo>%@</IMEINo><GPSLatitude>%@</GPSLatitude><GPSLongitude>%@</GPSLongitude></DeactiveAlaram></soap:Body></soap:Envelope>",userId,[[alert23 textFieldAtIndex:0] text],phoneNum, identifier,latitude,longitude];
       
       
       NSLog(@" wewewewe :%@",soapMessage);
       NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://182.18.175.194/protectmesos/MySafetyService.asmx"]];
       deactivateAlarmReq = [NSMutableURLRequest requestWithURL:url];
       NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
       
       [deactivateAlarmReq addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
       [deactivateAlarmReq addValue: @"http://tempuri.org/DeactiveAlaram" forHTTPHeaderField:@"SOAPAction"];
       [deactivateAlarmReq addValue: msgLength forHTTPHeaderField:@"Content-Length"];
       [deactivateAlarmReq setHTTPMethod:@"POST"];
       [deactivateAlarmReq setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
       deactCon = [NSURLConnection connectionWithRequest:deactivateAlarmReq delegate:self];
       
       if (deactCon)
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
       
       
       
       ///////////
       
   
       
       if (buttonIndex==0) {
           
           
          
                  }

   }
   else if (alertView.tag==55) {
       if (buttonIndex==0) {
//           [self.imherebutton setBackgroundImage:[UIImage imageNamed:@"im here.PNG"] forState:UIControlStateNormal];
       }
       else
       {
        alert = [[SBTableAlert alloc] initWithTitle:Nil cancelButtonTitle:@"Cancel" messageFormat:nil];
           [alert setType:SBTableAlertTypeMultipleSelct];
           [alert.view addButtonWithTitle:@"Confirm"];
           [alert setDelegate:self];
           [alert setDataSource:self];
           [alert show];
       }
       
   }
   else if (alertView.tag==60) {
       fakeCheck = 52;
   }
    if (alertView.tag==62) {
        checkingMysafetydeactivate = 62;
//        [self.mysafetybutton setBackgroundImage:[UIImage imageNamed:@"my safety.PNG"] forState:UIControlStateNormal];
    }
    else if (alertView.tag==63) {
        [self performSelector:@selector(mysafetycloseredalert:) withObject:mysafetyAlert afterDelay:0];
    }
    else if (alertView.tag==64) {
        self.sosImage.image = [UIImage imageNamed:@"sos.PNG"];
        self.mainBg.image = [UIImage imageNamed:@"plane-bg.png"];
        [self.mysafetybutton setBackgroundImage:[UIImage imageNamed:@"my safety.PNG"] forState:UIControlStateNormal];
        
    }
}


-(void)redalert:(UIAlertView*)alert
{
    if (checkingdeactivate!=52) {
        
    self.sosImage.image = [UIImage imageNamed:@"sos-red.png"];
    self.mainBg.image = [UIImage imageNamed:@"plane-red-bg.png"];
        
    [alert dismissWithClickedButtonIndex:0 animated:YES];
        
      alert2 = [[GRAlertView alloc] initWithTitle:nil
          message:@"SOS Alarm has been activated by jenny mathews."
          delegate:self
          cancelButtonTitle:@"Close"
          otherButtonTitles:@"Open", nil];
        alert2.style = GRAlertStyleAlert;
        [alert2 setTag:53];
        [alert2 show];
        //[alert2 release];

    }
    }
-(void)closeredalert:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    
    UIAlertView *alert3 = [[UIAlertView alloc]initWithTitle:nil message:@"SMS and Call will be directed to your Guardians." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert3 show];
}

-(void)Fakealert:(UIAlertView*)alert
{
    if (fakeCheck!=52) {
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"DECKALRM" ofType:@"WAV"];
        NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
        player.numberOfLoops = -1; //Infinite
        
        [player play];
    }
    
    
}
- (IBAction)imhere:(UIButton*)sender {
    
//    [self.mysafetybutton setBackgroundImage:[UIImage imageNamed:@"my safety.PNG"] forState:UIControlStateNormal];
//    
//    [self.fakeCallButton setBackgroundImage:[UIImage imageNamed:@"fake-call-gray.png"] forState:UIControlStateNormal];
    
    
//    [sender setBackgroundImage:[UIImage imageNamed:@"green-im-here.png"] forState:UIControlStateNormal];
    
     _message =[[ProtectmeEventClass alloc]init];
    
    
   
    UIDevice  *myDevice = [UIDevice currentDevice];
    identifier =[[NSString alloc]init];
    identifier= [myDevice.identifierForVendor UUIDString];
    userId =[[NSString alloc]init];
    userId = [SaveAlaramDelayTime getInstance].userId;
    phoneNum=[[NSString alloc]init];
    phoneNum = [SaveAlaramDelayTime getInstance].phoneNo;


    [_message getsoapMessageParameters:userId settingstype:@"4" relationType:@"7"mobileNum:phoneNum IMEINo:identifier latitude:latitude longitude:longitude];
    
        UIAlertView *alert4 = [[UIAlertView alloc]initWithTitle:nil message:@"Send notifications to Guardian(s) that you have arrived to destination safely." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    
    
    [alert4 setTag:55];
    [alert4 show];
    
}

//- (UITableViewCell *)tableAlert:(SBTableAlert *)tableAlert cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//}
-(UITableViewCell *)tableAlert:(SBTableAlert *)tableAlert cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
    UITableViewCell *cell;
    
	
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
	
    if (checkedVaue != 52)
    {
        [array removeObject:indexPath];
        
    }
    else 
    {
        [array addObject:indexPath];
    }
    
    //cell.backgroundColor=[UIColor clearColor];
    //[cell.textLabel setText:@"a"];
    
    cell.textLabel.text=@"22";
    
	[cell.textLabel setText:[alertviewArray objectAtIndex: indexPath.row]];
	if ( [array indexOfObject:indexPath] == NSNotFound ) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
	return cell;
}

- (NSInteger)tableAlert:(SBTableAlert *)tableAlert numberOfRowsInSection:(NSInteger)section {
    
   return alertviewArray.count ;
}

- (NSInteger)numberOfSectionsInTableAlert:(SBTableAlert *)tableAlert {
		return 1;
}


#pragma mark - SBTableAlertDelegate

- (void)tableAlert:(SBTableAlert *)tableAlert didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableAlert.tableView cellForRowAtIndexPath:indexPath];
    
    
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        
        if (indexPath.row==0) {
            checkedVaue = 52;
            //[tableAlert.tableView reloadData];
        }
       
    }
    else
    {
    [cell setAccessoryType:UITableViewCellAccessoryNone];
		if (indexPath.row==0) {
            checkedVaue = 0;
            //[tableAlert.tableView reloadData];
        }
    
    }
    
    if ( [array indexOfObject:indexPath] == NSNotFound ) {
        [array addObject:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        [array removeObject:indexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

//		[tableAlert.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableAlert:(SBTableAlert *)tableAlert didDismissWithButtonIndex:(NSInteger)buttonIndex {
	NSLog(@"Dismissed: %i", buttonIndex);
    if (buttonIndex == 1) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Selected guardians will get notification with your current location." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert setTag:56];
        [alert show];
    }
	
}
- (IBAction)fakecall:(UIButton*)sender {
    
    if ([player isPlaying]) {
      [player stop];
    
    }
    else
    {
//    [sender setBackgroundImage:[UIImage imageNamed:@"fake-call-green.png"] forState:UIControlStateNormal];
        
        _message =[[ProtectmeEventClass alloc]init];
        
        
        UIDevice  *myDevice = [UIDevice currentDevice];
        identifier =[[NSString alloc]init];
        identifier= [myDevice.identifierForVendor UUIDString];
        userId =[[NSString alloc]init];
        userId = [SaveAlaramDelayTime getInstance].userId;
        phoneNum=[[NSString alloc]init];
        phoneNum = [SaveAlaramDelayTime getInstance].phoneNo;
        
        
        [_message getsoapMessageParameters:userId settingstype:@"4" relationType:@"9"mobileNum:phoneNum IMEINo:identifier latitude:latitude longitude:longitude];
        
        
    fakeAlert = [[UIAlertView alloc]initWithTitle:nil message:@"Fake call has been activated you have 3 seconds to deactivate it." delegate:self cancelButtonTitle:@"De activate" otherButtonTitles:nil];
    [fakeAlert setTag:60];
    [fakeAlert show];
    [self performSelector:@selector(Fakealert:) withObject:fakeAlert afterDelay:3];
    fakeCheck = 0;
    }
}

- (IBAction)mysafetyTest:(UIButton*)sender {
    
//    [self.fakeCallButton setBackgroundImage:[UIImage imageNamed:@"fake-call-gray.png"] forState:UIControlStateNormal];
//    
//     [self.imherebutton setBackgroundImfage:[UIImage imageNamed:@"im here.PNG"] forState:UIControlStateNormal];
//    
    if (![[sender backgroundImageForState:UIControlStateNormal] isEqual:[UIImage imageNamed:@"mysafety-green.png"]]) {
        
//        [sender setBackgroundImage:[UIImage imageNamed:@"mysafety-green.png"] forState:UIControlStateNormal];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Test SOS Alarm has been activated you have 3 seconds to deactivate it." delegate:self cancelButtonTitle:@"De activate" otherButtonTitles:nil];
        [alert setTag:62];
        [alert show];
        checkingMysafetydeactivate = 0;
        [self performSelector:@selector(GreenAlertofMysafetyTest:) withObject:alert afterDelay:3];
    }
    
    else
    {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please Enter pincode to deactivate SOS Alarm." delegate:self cancelButtonTitle:@"De activate" otherButtonTitles:nil];
        [alert setTag:64];
        alert.alertViewStyle = UIAlertViewStyleSecureTextInput;
        [alert show];
        
        
    }
}
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    if (i==2) {
        
    }
    return deactivateAlarmReq;
    
    
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
    
    NSXMLParser *parser=[[NSXMLParser alloc]initWithData:webData];;
    NSString *srt=[[NSString alloc]initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"responce:%@",srt);
    parser.delegate=self;
    [parser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
    resultString =[[NSMutableString alloc]init];
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"DeactiveAlaramResult"]) {
        tag=YES;
    }
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if (tag == YES) {
        [resultString appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if ([elementName isEqualToString:@"DeactiveAlaramResult"]) {
        tag=NO;
    }
    
}



- (void)parserDidEndDocument:(NSXMLParser *)parser

{
    NSLog(@"resu is%@",resultString);
    
    if (i==2) {
        
        NSLog(@"erddffddd");
        
    }
   
    if ([resultString isEqualToString:@"{\"DeactiveAlaram\" : [{\"Message\" : \" Wrong Password.\"}]}"]  ) {
        NSLog(@" alarm dea");
        self.sosImage.image = [UIImage imageNamed:@"SOS red icon.png"];
        
        self.mainBg.image = [UIImage imageNamed:@"plane-bg-1.png"];

    
    }
     if (![resultString isEqualToString:@"{\"DeactiveAlaram\" : [{\"Message\" : \" Wrong Password.\"}]}"]  ){
        
             NSLog(@"deactivate");
        
        UIAlertView *alert4 = [[UIAlertView alloc]initWithTitle:nil message:@"Please enter Correct Password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert4 show];

        
        
    }
    
    
    
}


-(void)GreenAlertofMysafetyTest:(UIAlertView*)alert
{
    
    if (checkingMysafetydeactivate!=62) {
        
        self.sosImage.image = [UIImage imageNamed:@"sos-red.png"];
        self.mainBg.image = [UIImage imageNamed:@"plane-red-bg.png"];
        
        [alert dismissWithClickedButtonIndex:0 animated:YES];
        
        mysafetyAlert = [[GRAlertView alloc] initWithTitle:nil
                                            message:@"This is test."
                                           delegate:self
                                  cancelButtonTitle:@"Close"
                                  otherButtonTitles:@"Open", nil];
        mysafetyAlert.style = GRAlertStyleSuccess;
        [mysafetyAlert setTag:63];
        [mysafetyAlert show];
        //[mysafetyAlert release];
        
        
        
    }
}
-(void)mysafetycloseredalert:(UIAlertView*)alert
{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    
    UIAlertView *alert3 = [[UIAlertView alloc]initWithTitle:nil message:@"Test SMS and Call will be directed to your Guardians." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert3 show];
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

- (IBAction)followMe:(id)sender {
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Every 5 seconds your Guardian will get your location." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
    

    
    NSTimer *fireEveryfiveSeconds=[NSTimer scheduledTimerWithTimeInterval:50 target:self selector:@selector(fireAfterfive) userInfo:Nil repeats:YES];
    
//    [fireEveryfiveSeconds performSelector:@selector(fireAfterfive) withObject:self afterDelay:0];
    [fireEveryfiveSeconds fire];
//    
    
   
}

- (IBAction)fileUpload:(id)sender {
    
    // events
    
    
    
    
    _message =[[ProtectmeEventClass alloc]init];
    
    
    
    UIDevice  *myDevice = [UIDevice currentDevice];
    identifier =[[NSString alloc]init];
    identifier= [myDevice.identifierForVendor UUIDString];
    userId =[[NSString alloc]init];
    userId = [SaveAlaramDelayTime getInstance].userId;
    phoneNum=[[NSString alloc]init];
    phoneNum = [SaveAlaramDelayTime getInstance].phoneNo;
    
    
    [_message getsoapMessageParameters:userId settingstype:@"4" relationType:@"13"mobileNum:phoneNum IMEINo:identifier latitude:latitude longitude:longitude];
    

    
    
    
    
    i=2;
//    if (cameraDitected) {
//        NSLog(@"b");
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
    
    
//    }else{
//        UIAlertView *cameraalert = [[UIAlertView alloc]initWithTitle:@"Camera not detected." message:@"use photo library" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil, nil];
//        [cameraalert show];
//    }
   
}


-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.movieURL = info[UIImagePickerControllerMediaURL];
    NSLog(@"movie url is %@",self.movieURL);
    
    NSLog(@"data is %@",[NSData dataWithContentsOfURL:self.movieURL]);
    
    
    UIDevice  *myDevice = [UIDevice currentDevice];
    identifier =[[NSString alloc]init];
    identifier= [myDevice.identifierForVendor UUIDString];
    userId =[[NSString alloc]init];
    userId = [SaveAlaramDelayTime getInstance].userId;
    phoneNum=[[NSString alloc]init];
    phoneNum = [SaveAlaramDelayTime getInstance].phoneNo;
    
    NSData *filename=[NSData dataWithContentsOfURL:self.movieURL];
    NSString *soapMessage=[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UploadFiles xmlns=\"http://tempuri.org/\"><UserID>%@</UserID><settingType>13</settingType><fileName>%@</fileName><MobileNo>%@</MobileNo><IMEINo>%@</IMEINo><GPSLatitude>%@</GPSLatitude><GPSLongitude>%@</GPSLongitude></UploadFiles></soap:Body></soap:Envelope>",userId,filename,phoneNum, identifier,latitude,longitude];
    
    NSLog(@" wewewewe :%@",soapMessage);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://182.18.175.194/protectmesos/MySafetyService.asmx"]];
    deactivateAlarmReq = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [deactivateAlarmReq addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [deactivateAlarmReq addValue: @"http://tempuri.org/UploadFiles" forHTTPHeaderField:@"SOAPAction"];
    [deactivateAlarmReq addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [deactivateAlarmReq setHTTPMethod:@"POST"];
    [deactivateAlarmReq setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    deactCon = [NSURLConnection connectionWithRequest:deactivateAlarmReq delegate:self];
    
    if (deactCon)
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
    
    
    [self dismissViewControllerAnimated:YES completion:nil];

}


-(void)fireAfterfive{
    
    
    UIDevice  *myDevice = [UIDevice currentDevice];
    identifier =[[NSString alloc]init];
    identifier= [myDevice.identifierForVendor UUIDString];
    userId =[[NSString alloc]init];
    userId = [SaveAlaramDelayTime getInstance].userId;
    phoneNum=[[NSString alloc]init];
    phoneNum = [SaveAlaramDelayTime getInstance].phoneNo;
    
    NSLog(@"called");
    
    _message=[[ProtectmeEventClass alloc]init];
    [_message getsoapMessageParameters:userId settingstype:@"4" relationType:@"8"mobileNum:phoneNum IMEINo:identifier latitude:latitude longitude:longitude];
}
@end
