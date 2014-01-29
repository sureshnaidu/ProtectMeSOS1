//
//  EditMyAccountDetailsViewController.m
//  MySafety
//
//  Created by trilok kumar reddy munagala on 07/10/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "EditMyAccountDetailsViewController.h"
#import "SaveAlaramDelayTime.h"
@interface EditMyAccountDetailsViewController ()

@end

@implementation EditMyAccountDetailsViewController
{
    UIView *ViewForValuePicker;
    UIPickerView *valuePicker;
    NSArray *pickerValueAry;
    NSString *pickerSelectedString;
    UIAlertView *alert;
    
    UIView *view2;
    UIView *view;
    NSMutableData *webData;
    NSMutableString *mutableStr;
    NSXMLParser *rssParser;
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
    
    pickerValueAry = [[NSArray alloc]initWithObjects:@"India",@"USA",@"UK", nil];
    pickerSelectedString = [[NSString alloc]init];

 
    self.name.delegate = self;
    self.surname.delegate = self;
    self.email.delegate = self;
    self.country.delegate = self;
    self.city.delegate = self;
    self.password.delegate = self;
    self.confirmpassword.delegate = self;
    
    self.old.delegate = self;
    self.kothaPassword.delegate = self;
    self.confirm.delegate = self;
    
    
    self.scrlView.contentSize = CGSizeMake(286, 350);
    self.scrlView.showsHorizontalScrollIndicator = NO;
    _scrlView.scrollEnabled = FALSE;
//
//    if ([[UIScreen mainScreen] bounds].size.height==480) {
//        
//        
//        self.scrlView.frame = CGRectMake(self.scrlView.frame.origin.x, self.scrlView.frame.origin.y, self.scrlView.frame.size.width, self.scrlView.frame.size.height+80);
//        
//        self.scrollBg.frame = CGRectMake(self.scrollBg.frame.origin.x, self.scrollBg.frame.origin.y, self.scrollBg.frame.size.width, self.scrollBg.frame.size.height-10);
//
//         self.saveButton.frame = CGRectMake(self.saveButton.frame.origin.x, self.saveButton.frame.origin.y-45, self.saveButton.frame.size.width, self.saveButton.frame.size.height-5);;
//    }
    // Do any additional setup after loading the view from its nib.
}

-(void)cancelPicker
{
    [ViewForValuePicker removeFromSuperview];
    
    self.country.text = nil;
}
-(void)doneWithPicker
{
    [ViewForValuePicker removeFromSuperview];
    if(!pickerSelectedString)
    {
        self.country.text = @"india";
    }
    else
    {
        self.country.text = pickerSelectedString;
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
    pickerSelectedString = [pickerValueAry objectAtIndex:row];
}

-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBar.hidden = NO;
    
    
    [super viewWillAppear:YES];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    imageview.image = [UIImage imageNamed:@"sub-menu.png"];
    [self.navigationController.navigationBar addSubview:imageview];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 10, 60, 30);
    [btn setImage:[UIImage imageNamed:@"back-btn.PNG"] forState:UIControlStateNormal];
    [imageview addSubview:btn];
    self.chanepassword.hidden = YES;
    
    NSLog(@"User Details :%@",[SaveAlaramDelayTime getInstance].userDetails);
     self.name.text = [[SaveAlaramDelayTime getInstance].userDetails objectForKey:@"UserName"];
     self.surname.text = [[SaveAlaramDelayTime getInstance].userDetails objectForKey:@"SurName"];
     self.email.text = [[SaveAlaramDelayTime getInstance].userDetails objectForKey:@"EmailId"];
     self.password.text = [[SaveAlaramDelayTime getInstance].userDetails objectForKey:@"UserPassword"];
     self.city.text = [[SaveAlaramDelayTime getInstance].userDetails objectForKey:@"City"];
    self.confirmpassword.text = [[SaveAlaramDelayTime getInstance].userDetails objectForKey:@"UserPassword"];
    if ([[[SaveAlaramDelayTime getInstance].userDetails objectForKey:@"CountryID"] isEqualToString:@"1"]) {
         self.country.text = @"India";
    }
    

//    self.tabBarController.tabBar.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changePassword:(id)sender {
    
    self.chanepassword.hidden = NO;
    [self.scrlView setContentOffset:CGPointMake(0, 0) animated:YES];
    [self.old becomeFirstResponder];
    
   
    [view2 removeFromSuperview];
    view2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    view2.backgroundColor = [UIColor blackColor];
    view2.alpha = 0.8;
    [self.mainBackground addSubview:view2];
    
    [view removeFromSuperview];
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.scrollBg.frame.size.width, self.scrollBg.frame.size.height)];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.8;
    [self.scrollBg addSubview:view];
    
    self.saveButton.enabled = NO;
    
    
}

- (IBAction)cancel:(id)sender {
    self.chanepassword.hidden = YES;
    [self.old resignFirstResponder];
    [self.kothaPassword resignFirstResponder];
    [self.confirm resignFirstResponder];
    
    [view removeFromSuperview];
    [view2 removeFromSuperview];
    
    self.saveButton.enabled = YES;
    
}

- (IBAction)done:(id)sender {
    
    [view removeFromSuperview];
    [view2 removeFromSuperview];
    self.saveButton.enabled = YES;
    
    [self.old resignFirstResponder];
    [self.kothaPassword resignFirstResponder];
    [self.confirm resignFirstResponder];
    
    self.chanepassword.hidden = YES;
    
    alert = [[UIAlertView alloc]initWithTitle:nil message:@"Password Changed Successfully." delegate:self cancelButtonTitle:@"close" otherButtonTitles:nil];
    [alert show];
    
}



-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.old]||[textField isEqual:self.kothaPassword]||[textField isEqual:self.confirm]) {
        
        
    }
    else
    {
        [self scrollViewToCenterOfScreen:textField];
        _scrlView.scrollEnabled = TRUE;
        
        
        
        if ([textField isEqual:self.country]) {
            
            [self.country resignFirstResponder];
            [self.name resignFirstResponder];
            [self.surname resignFirstResponder];
            [self.email resignFirstResponder];
            [self.city resignFirstResponder];
            [self.password resignFirstResponder];
            [self.confirmpassword resignFirstResponder];
            
            [ViewForValuePicker removeFromSuperview];
            ViewForValuePicker = [[UIView alloc]initWithFrame:CGRectMake(0, 219, 320, 216)];
            
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
	
    
    
    
    
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    
	if ([textField isEqual:self.old]||[textField isEqual:self.kothaPassword]||[textField isEqual:self.confirm]) {
        
        [textField resignFirstResponder];
    }
    else
    {
        [self.scrlView setContentOffset:CGPointMake(0, 0) animated:YES];
        [textField resignFirstResponder];
        _scrlView.scrollEnabled = FALSE;
        
        
        
        
        if ([textField isEqual:self.country]) {
            
            [self dropdown:nil];
            
        }
        else
        {
            [ViewForValuePicker removeFromSuperview];
        }
    }
   	return TRUE;
    
}


- (void)scrollViewToCenterOfScreen:(UIView *)theView {
    
	CGFloat viewCenterY = theView.center.y;
	CGRect applicationFrame = self.scrlView.frame;
    CGFloat availableHeight;
     if ([[UIScreen mainScreen] bounds].size.height==480) {
         
          availableHeight = applicationFrame.size.height - 120;

     }
    else
    {
         availableHeight = applicationFrame.size.height - 50;

    }
	    
	CGFloat y = viewCenterY - availableHeight / 2.0;
	if (y < 0) {
		y = 0;
	}
    [self.scrlView setContentOffset:CGPointMake(0, y) animated:YES];
}
- (IBAction)save:(id)sender {
    
    
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
    
    else if (self.country.text.length==0)
    {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide country." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }

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
    else if (![self.confirmpassword.text isEqualToString:self.password.text])
    {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Password Re-entry does not match." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else{
    
        
        NSDate *date = [NSDate date];
        
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
        
        [dateformatter setDateFormat:@"MM/dd/yyyy"];
        
        NSString *postStr =[NSString stringWithFormat:
                            @"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:soap=\"http://schemas.xmlsoap.org/wsdl/soap/\" xmlns:tm=\"http://microsoft.com/wsdl/mime/textMatching/\" xmlns:soapenc=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:mime=\"http://schemas.xmlsoap.org/wsdl/mime/\" xmlns:tns=\"http://tempuri.org/\" xmlns:s1=\"http://microsoft.com/wsdl/types/\" xmlns:s=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://schemas.xmlsoap.org/wsdl/soap12/\" xmlns:http=\"http://schemas.xmlsoap.org/wsdl/http/\" xmlns:wsdl=\"http://schemas.xmlsoap.org/wsdl/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" ><SOAP-ENV:Body><tns:UserRegistration xmlns:tns=\"http://tempuri.org/\"><tns:UserID>%@</tns:UserID><tns:UserType>1</tns:UserType><tns:UserName>%@</tns:UserName><tns:Password>%@</tns:Password><tns:EmailAddress>%@</tns:EmailAddress><tns:SurName>%@</tns:SurName><tns:City>%@</tns:City><tns:Country>1</tns:Country><tns:AuthenticationBySocialNetwork>1</tns:AuthenticationBySocialNetwork><tns:UserPermitedPeriodFrom>%@</tns:UserPermitedPeriodFrom><tns:UserPermitedPeriodTo>%@</tns:UserPermitedPeriodTo><tns:GPSLatitude>%@</tns:GPSLatitude><tns:GPSLongitude>%@</tns:GPSLongitude></tns:UserRegistration></SOAP-ENV:Body></SOAP-ENV:Envelope>",[SaveAlaramDelayTime getInstance].userId,self.name.text,self.password.text,self.email.text,self.surname.text,@"1",[dateformatter stringFromDate:date],[dateformatter stringFromDate:date],@"24.0",@"35.0"];
        
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
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 52) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)back:(id)sender {
    
     [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)dropdown:(id)sender {
    
    [self scrollViewToCenterOfScreen:self.country];
	_scrlView.scrollEnabled = TRUE;
    
    [self.name resignFirstResponder];
    [self.surname resignFirstResponder];
    [self.email resignFirstResponder];
    [self.city resignFirstResponder];
    [self.password resignFirstResponder];
    [self.confirmpassword resignFirstResponder];
    [ViewForValuePicker removeFromSuperview];
    ViewForValuePicker = [[UIView alloc]initWithFrame:CGRectMake(0, 150, 320, 216)];
    
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    toolBar.items = [NSArray arrayWithObjects:
                     [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelPicker)],
                     [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                     [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithPicker)],
                     nil];
    
    [ViewForValuePicker addSubview:toolBar];
    
    
    valuePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 320, 180)];
    valuePicker.delegate=self;
    valuePicker.dataSource=self;
    valuePicker.showsSelectionIndicator=YES;
    
    [ViewForValuePicker addSubview:valuePicker];
    
    [self.view addSubview:ViewForValuePicker];
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
    NSLog(@"%@",json2);
}

@end
