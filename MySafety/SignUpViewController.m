//
//  SignUpViewController.m
//  MySafety
//
//  Created by trilok kumar reddy munagala on 02/10/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "SignUpViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController
{
    AppDelegate *appDelegate;
    CLLocationCoordinate2D coordinate;
    NSString *latitude;
    NSString *longitude;
    UIAlertView *alert;
    UIView *ViewForValuePicker;
    UIPickerView *valuePicker;
    NSMutableArray *pickerValueAry;
    NSString *pickerSelectedString;
    NSMutableURLRequest *registerRequest,*registerRequest2;
    NSMutableString *mutableStr;
    
}

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
    //    _scrlView.delegate = self;
    
    
    [self getLocation];
    pickerValueAry = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in [[SaveAlaramDelayTime getInstance] countreisDict]) {
        [pickerValueAry addObject:[dic objectForKey:@"countryName"]];
    }
    
    

    
    self.name.delegate = self;
    self.phone.delegate = self;
    self.surname.delegate = self;
    self.email.delegate = self;
    self.country.delegate = self;
    self.city.delegate = self;
    self.password.delegate = self;
    self.confirmPassword.delegate = self;
    
    
    self.scrlView.contentSize = CGSizeMake(286, 450);
    self.scrlView.showsHorizontalScrollIndicator = NO;
    _scrlView.scrollEnabled = FALSE;
    
    
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
//    if ([[UIScreen mainScreen] bounds].size.height==480) {
    
//        self.scrollBackground.frame = CGRectMake(self.scrollBackground.frame.origin.x, self.scrollBackground.frame.origin.y,  self.scrollBackground.frame.size.width, self.scrollBackground.frame.size.height-50);
//        
//        self.finishButton.frame = CGRectMake(self.finishButton.frame.origin.x, self.finishButton.frame.origin.y-50,  self.finishButton.frame.size.width, self.finishButton.frame.size.height);
//        
//        self.scrlView.frame = CGRectMake(self.scrlView.frame.origin.x, self.scrlView.frame.origin.y,  self.scrlView.frame.size.width, self.scrlView.frame.size.height+40);
        
        
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarStyleBlackTranslucent;
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                               nil];
        [numberToolbar sizeToFit];
        self.phone.inputAccessoryView = numberToolbar;
        
        
        
        
        
        
//    }
    
    
    // Do any additional setup after loading the view from its nib.
}

-(void)cancelNumberPad{
    
    [self.phone resignFirstResponder];
    self.phone.text = @"";
}

-(void)doneWithNumberPad
{
    //    NSString *numberFromTheKeyboard1 = self.phone.text;
    
    [self.phone resignFirstResponder];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    [self scrollViewToCenterOfScreen:textField];
	_scrlView.scrollEnabled = TRUE;
    
    if ([textField isEqual:self.country]) {
        
        [self.country resignFirstResponder];
        [self.name resignFirstResponder];
        [self.surname resignFirstResponder];
        [self.email resignFirstResponder];
        [self.city resignFirstResponder];
        [self.password resignFirstResponder];
        [self.phone resignFirstResponder];
        [self.confirmPassword resignFirstResponder];
        
        [ViewForValuePicker removeFromSuperview];
        ViewForValuePicker = [[UIView alloc]initWithFrame:CGRectMake(0, 219, 320, 266)];
        
        UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
        toolBar.barStyle = UIBarStyleBlackOpaque;
        
        toolBar.items = [NSArray arrayWithObjects:
                         [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPicker)],
                         [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                         [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithPicker)],
                         nil];
        
        [ViewForValuePicker addSubview:toolBar];
        
        
        valuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
        valuePicker.delegate=self;
        valuePicker.dataSource=self;
        valuePicker.showsSelectionIndicator=YES;
        
        [ViewForValuePicker addSubview:valuePicker];
        
        [self.view addSubview:ViewForValuePicker];
        
    }
    else
    {
        [ViewForValuePicker removeFromSuperview];
    }
    
}

-(void)cancelPicker
{
    [ViewForValuePicker removeFromSuperview];
    
    self.country.text = nil;
}
-(void)doneWithPicker
{
    [ViewForValuePicker removeFromSuperview];
    if(pickerNumber==0)
    {
        self.country.text = @"india";
    }
    else
    {
        self.country.text = [pickerValueAry objectAtIndex:pickerNumber];
    }
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [pickerValueAry count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    
    return [pickerValueAry objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"selectedRowInPicker >> %d",row);
    
    self.country.text = [pickerValueAry objectAtIndex:row];
    pickerNumber = row;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[self.scrlView setContentOffset:CGPointMake(0, 0) animated:YES];
	[textField resignFirstResponder];
	_scrlView.scrollEnabled = FALSE;
   	return TRUE;
    
}





- (void)scrollViewToCenterOfScreen:(UIView *)theView {
    
	CGFloat viewCenterY = theView.center.y;
	CGRect applicationFrame = self.scrlView.frame;
    
	CGFloat availableHeight = applicationFrame.size.height -100;
    
	CGFloat y = viewCenterY - availableHeight / 2.0;
	if (y < 0) {
		y = 0;
	}
    [self.scrlView setContentOffset:CGPointMake(0, y) animated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [_activity setHidden:YES];
    
    
}

- (IBAction)finish:(id)sender
{
    
    
    //    screenItem = 1;
    //
    //    HomeViewController *home = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    //
    //    [self.navigationController pushViewController:home animated:YES];
    
    
    
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if (self.name.text.length==0) {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide Name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else if (![[self.name.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString: self.name.text] || ![[self.name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString: self.name.text] )
        
    {
        
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide valid Name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    
    else if (self.surname.text.length==0)
    {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide Surname." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else  if (![[self.surname.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString:self.surname.text])
        
    {
        
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide valid Surname." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    
    else if (self.email.text.length==0)
    {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide Email." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else if ([emailTest evaluateWithObject:self.email.text] == NO) {
        
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Enter Valid Email." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        
    }
    
    
    else if (self.phone.text.length==0)
    {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide Phone." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else  if ([[self.phone.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString:self.phone.text])
        
    {
        
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide valid Phone number." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    
    
    else if (self.country.text.length==0)
    {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide country." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    //    else  if (![[self.country.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString:self.country.text])
    //
    //    {
    //
    //        alert = [[UIAlertView alloc]initWithTitle:nil message:@"please provide valid country" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //        [alert show];
    //        [alert release];
    //
    //    }
    //
    else if (self.city.text.length==0)
    {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide city." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else  if (![[self.city.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString:self.city.text])
        
    {
        
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide valid city." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }
    
    else if (self.password.text.length==0)
    {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide password." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else if (![self.confirmPassword.text isEqualToString:self.password.text])
    {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Password Re-entry does not match." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    
    else if ([((UIButton*)[self.view viewWithTag:100]).imageView.image isEqual:[UIImage imageNamed:@"checkbox.png"]])
    {
    
    alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please accept the Agreement." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    
    }
    else
    {
        
        [_activity setHidden:NO];
        [_activity startAnimating];
        
        UIDevice *myDevice =[[UIDevice alloc]init];
        myDevice=[UIDevice currentDevice];
        NSString *identifier =[[NSString alloc]init];
        identifier=[myDevice.identifierForVendor UUIDString];

        NSDate *date = [NSDate date];
        
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"MM/dd/yyyy"];
         NSString *postStr =[NSString stringWithFormat:
                            @"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:soap=\"http://schemas.xmlsoap.org/wsdl/soap/\" xmlns:tm=\"http://microsoft.com/wsdl/mime/textMatching/\" xmlns:soapenc=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:mime=\"http://schemas.xmlsoap.org/wsdl/mime/\" xmlns:tns=\"http://tempuri.org/\" xmlns:s1=\"http://microsoft.com/wsdl/types/\" xmlns:s=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://schemas.xmlsoap.org/wsdl/soap12/\" xmlns:http=\"http://schemas.xmlsoap.org/wsdl/http/\" xmlns:wsdl=\"http://schemas.xmlsoap.org/wsdl/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" ><SOAP-ENV:Body><tns:UserRegistration xmlns:tns=\"http://tempuri.org/\"><tns:UserID>0</tns:UserID><tns:UserType>1</tns:UserType><tns:UserName>%@</tns:UserName><tns:Password>%@</tns:Password><tns:EmailAddress>%@</tns:EmailAddress><tns:SurName>%@</tns:SurName><tns:City>%@</tns:City><tns:Country>1</tns:Country><tns:AuthenticationBySocialNetwork>1</tns:AuthenticationBySocialNetwork><tns:UserPermitedPeriodFrom>%@</tns:UserPermitedPeriodFrom><tns:UserPermitedPeriodTo>%@</tns:UserPermitedPeriodTo><tns:MobileNo>%@</tns:MobileNo><tns:IMEINumber>%@</tns:IMEINumber><tns:GPSLatitude>%@</tns:GPSLatitude><tns:GPSLongitude>%@</tns:GPSLongitude></tns:UserRegistration></SOAP-ENV:Body></SOAP-ENV:Envelope>",self.name.text,self.password.text,self.email.text,self.surname.text,self.city.text,[dateformatter stringFromDate:date],[dateformatter stringFromDate:date],self.phone.text,identifier,@"1.0",@"2.0"];
        
        NSLog(@"Registering: %@",postStr);
        
        NSURL *url=[NSURL URLWithString:@"http://182.18.175.194/protectmesos/MySafetyService.asmx"];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postStr length]];
        registerRequest = [[NSMutableURLRequest alloc] initWithURL:url];
        [registerRequest setURL:url];
        [registerRequest setHTTPMethod:@"POST"];
        [registerRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [registerRequest setValue:@"http://tempuri.org/UserRegistration" forHTTPHeaderField:@"SOAPAction"];
        [registerRequest setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [registerRequest setHTTPBody:[postStr dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        
        
        NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:registerRequest delegate:self];
        
        if( theConnection )
        {
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
            NSLog(@"theConnection is NULL");
        }
   
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
    mutableStr = [[NSMutableString alloc] init];
    NSLog(@"%@" ,[[NSString alloc]initWithData:webData encoding:NSUTF8StringEncoding]);
    rssParser=[[NSXMLParser alloc]initWithData:webData];
    [rssParser setDelegate:self];
    [rssParser parse];
}
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    [HUD hide:YES];
    
    [mutableStr appendString:string];
       
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser

{
    
    NSDictionary *json2 = [NSJSONSerialization
                           JSONObjectWithData:[mutableStr dataUsingEncoding:NSUTF8StringEncoding]
                           options:kNilOptions
                           error:nil];
    if ([[[[json2 objectForKey:@"UserRegistration"] objectAtIndex:0] objectForKey:@"UserId"] intValue] > 0)
    {
        
        [SaveAlaramDelayTime getInstance].userId = [[[json2 objectForKey:@"UserRegistration"] objectAtIndex:0] objectForKey:@"UserId"]
        ;
       [SaveAlaramDelayTime getInstance].userDetails = [NSDictionary dictionaryWithObjectsAndKeys:self.name.text,@"UserName",
                              self.email.text,@"EmailId",
                              self.surname.text,@"SurName",
                              self.city.text,@"City",
                              self.country.text,@"CountryID",
                              self.password.text,@"UserPassword",
                              self.surname.text,@"SurName",nil];
        [appDelegate TabbarCreation];
        
        
        
        
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Sign up has ben successfull you can manage your personal details in the account settings using settings Tab enjoy the app and stay safe." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        
        
        [alert show];
    }
    else
        if ([[[[json2 objectForKey:@"UserRegistration"] objectAtIndex:0] objectForKey:@"Result"] intValue] < 0)
        {
            alert = [[UIAlertView alloc]initWithTitle:nil message:@"Already Existed User Try With Another Email." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            alert = [[UIAlertView alloc]initWithTitle:nil message:@"Give Valid Values" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(220, 10, 40, 40)];
            
            NSString *path = [[NSString alloc] initWithString:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"registration bg.png"]];
            UIImage *bkgImg = [[UIImage alloc] initWithContentsOfFile:path];
            [imageView setImage:bkgImg];
            
            [alert addSubview:imageView];
            
            [alert show];
        }
    

}

- (IBAction)checkmark:(UIButton*)sender
{
    
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"checkbox.png"]])
    {
        [sender setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
         
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    }
}

-(void) getLocation{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
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

- (IBAction)dropDown:(id)sender {
    
    
    [self scrollViewToCenterOfScreen:self.country];
	_scrlView.scrollEnabled = TRUE;
    
    [self.name resignFirstResponder];
    [self.surname resignFirstResponder];
    [self.email resignFirstResponder];
    [self.city resignFirstResponder];
    [self.password resignFirstResponder];
    [self.phone resignFirstResponder];
    [self.confirmPassword resignFirstResponder];
    
    [ViewForValuePicker removeFromSuperview];
    ViewForValuePicker = [[UIView alloc]initWithFrame:CGRectMake(0, 219, 320, 266)];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    toolBar.items = [NSArray arrayWithObjects:
                     [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPicker)],
                     [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                     [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithPicker)],
                     nil];
    
    [ViewForValuePicker addSubview:toolBar];
    
    valuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 216)];
    valuePicker.delegate=self;
    valuePicker.dataSource=self;
    valuePicker.showsSelectionIndicator=YES;
    valuePicker.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"registration bg.png"]];
    
    [ViewForValuePicker addSubview:valuePicker];
    
    [self.view addSubview:ViewForValuePicker];
    
    
}
- (IBAction)signupSucessClose:(id)sender {
    
    [self.signupSucess removeFromSuperview];
    
}
@end
