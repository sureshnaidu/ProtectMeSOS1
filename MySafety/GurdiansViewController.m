//
//  GurdiansViewController.m
//  MySafety
//
//  Created by Naidu on 9/30/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "GurdiansViewController.h"
#import "TableviewCell.h"
#import "SaveAlaramDelayTime.h"
@interface GurdiansViewController ()

@end

@implementation GurdiansViewController
{
    TableviewCell *cell;
    UIAlertView *alert;
    CLLocationCoordinate2D coordinate;
    NSString *latitude;
    NSString *longitude;
    NSString *AlertBySMS;
    NSString *AlertByCall;
    NSXMLParser *showGuardianParser,*addGuardianrssParser;
    NSMutableURLRequest *showGuardianRequest,*addGuardianRequest;
    NSURLConnection *showGuardianConnection,*addGuardianConnection;
    NSMutableString *mutableStr;
    NSInteger selecetedIndex;
    int relationshipId;
    
}

int gettingValue;

@synthesize gurdiansArray,gurdiansPhoneArray,AlertBySMSArray,AlertByCallArray,surNAmeArray,emailArray,guardianIdArray,mainArray;

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
    
    [self getLocation];
    locationManager.delegate=self;
    [self.navigationController setNavigationBarHidden:YES];

    
    AlertBySMS = @"0";
    AlertByCall = @"0";
    
    gurdiansArray = [[NSMutableArray alloc]init];
    gurdiansPhoneArray = [[NSMutableArray alloc]init];
    
    AlertBySMSArray = [[NSMutableArray alloc]init];
    AlertByCallArray = [[NSMutableArray alloc]init];
    
    surNAmeArray = [[NSMutableArray alloc]init];
    emailArray = [[NSMutableArray alloc]init];
    
    guardianIdArray = [[NSMutableArray alloc]init];
    mainArray = [[NSMutableArray alloc]init];
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];;
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    self.phone.inputAccessoryView = numberToolbar;
    
   
    

   
    
    // Do any additional setup after loading the view from its nib.
}
-(void)cancelNumberPad{
    
    [self.phone resignFirstResponder];
    self.phone.text = @"";
}

-(void)doneWithNumberPad
{
    [self.phone resignFirstResponder];
}

-(void)showingGuardians
{
     
    NSString *soapMessage =[NSString stringWithFormat:@"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:soap=\"http://schemas.xmlsoap.org/wsdl/soap/\" xmlns:tm=\"http://microsoft.com/wsdl/mime/textMatching/\" xmlns:soapenc=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:mime=\"http://schemas.xmlsoap.org/wsdl/mime/\" xmlns:tns=\"http://tempuri.org/\" xmlns:s1=\"http://microsoft.com/wsdl/types/\" xmlns:s=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://schemas.xmlsoap.org/wsdl/soap12/\" xmlns:http=\"http://schemas.xmlsoap.org/wsdl/http/\" xmlns:wsdl=\"http://schemas.xmlsoap.org/wsdl/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" ><SOAP-ENV:Body><tns:GaurdiansList xmlns:tns=\"http://tempuri.org/\"><tns:UserId>%@</tns:UserId><tns:MobileNo>111</tns:MobileNo><tns:IMEINo>1111</tns:IMEINo><tns:GPSLatitude>11</tns:GPSLatitude><tns:GPSLongitude>11</tns:GPSLongitude></tns:GaurdiansList></SOAP-ENV:Body></SOAP-ENV:Envelope>",[SaveAlaramDelayTime getInstance].userId] ;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://182.18.175.194/protectmesos/MySafetyService.asmx"]];;
    showGuardianRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    
    [showGuardianRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [showGuardianRequest addValue: @"http://tempuri.org/GaurdiansList" forHTTPHeaderField:@"SOAPAction"];
    [showGuardianRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [showGuardianRequest setHTTPMethod:@"POST"];
    [showGuardianRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    showGuardianConnection = [NSURLConnection connectionWithRequest:showGuardianRequest delegate:self];
    if (showGuardianConnection)
    {
        NSLog(@"Connection");
    }
    else
    {
        NSLog(@"connection is null");
    }
    
    
    
    
      webData = [NSMutableData data];
        
        if (HUD) {
            [HUD removeFromSuperview];
        }
        HUD = [[MBProgressHUD alloc] initWithView:self.view.superview];
        [self.view.superview addSubview:HUD];
        HUD.delegate = self;
        [HUD show:YES];
    
        
}


-(void)viewWillAppear:(BOOL)animated
{
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, -5, 320, 50)];;
    imageview.image = [UIImage imageNamed:@"Guardians-Top.png"];
    [self.navigationController.navigationBar addSubview:imageview];

    
    [super viewWillAppear:YES];
    
    self.addGurdianView.hidden = YES;
    
    self.table.backgroundView = nil;
    self.table.backgroundColor = nil;
    
    self.table.dataSource = self;
    self.table.delegate = self;
    
    self.name.delegate = self;
    self.surname.delegate = self;
    self.phone.delegate = self;
    self.email.delegate = self;
    
     [self showingGuardians];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addGurdian:(UIButton*)sender {
    
    gettingValue = 52;
    self.addGurdianView.hidden = NO;
    [((UIButton*)[self.view viewWithTag:500]) setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    [((UIButton*)[self.view viewWithTag:600]) setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    relationshipId=0;
    self.name.text = nil;
    self.surname.text = nil;
    self.email.text = nil;
    self.phone.text = nil;
    sender.hidden = YES;
    //self.headerLaBEL.text = @"Add Gurdian";
    
    
}


- (IBAction)SaveGurdian:(id)sender {
    
    
    
    
    
    
    NSString *emailRegEx = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];
    
    if (self.name.text.length==0) {
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide Name." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }
    else if (![[self.name.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString: self.name.text] || ![[self.name.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString: self.name.text] )
        
    {
        
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide valid Name." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
    }

       
    else if (self.phone.text.length==0) {
        
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide Phone Number." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alert show];
    }

    
    
    else if ([[self.phone.text stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]] isEqualToString: self.phone.text] || ![[self.phone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString: self.phone.text] )
        
    {
        
        alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please provide valid Phone Number." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
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
        
        alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please Enter Valid Email." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        
    }
    else
    {
        
        UIDevice *myDevice = [UIDevice currentDevice];
        NSString *identifier = [myDevice.identifierForVendor UUIDString];
        
//NSString DeviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        
        NSString *userId = [SaveAlaramDelayTime getInstance].userId;
        NSString *RelationshipType = @"3";

//        if()
//        {
//            relationshipId=0;
//        }
     NSString *postStr =[NSString stringWithFormat:
                            @"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://www.w3.org/2003/05/soap-envelope\" xmlns:soap=\"http://schemas.xmlsoap.org/wsdl/soap/\" xmlns:tm=\"http://microsoft.com/wsdl/mime/textMatching/\" xmlns:soapenc=\"http://schemas.xmlsoap.org/soap/encoding/\" xmlns:mime=\"http://schemas.xmlsoap.org/wsdl/mime/\" xmlns:tns=\"http://tempuri.org/\" xmlns:s1=\"http://microsoft.com/wsdl/types/\" xmlns:s=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap12=\"http://schemas.xmlsoap.org/wsdl/soap12/\" xmlns:http=\"http://schemas.xmlsoap.org/wsdl/http/\" xmlns:wsdl=\"http://schemas.xmlsoap.org/wsdl/\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" ><SOAP-ENV:Body><tns:AddGurdian xmlns:tns=\"http://tempuri.org/\">"
                            "<tns:RelationShipID>%d</tns:RelationShipID>"
                            "<tns:UserID>%@</tns:UserID>"
                            "<tns:RelationshipType>%@</tns:RelationshipType>"
                            "<tns:Name>%@</tns:Name>"
                            "<tns:Surname>%@</tns:Surname>"
                            "<tns:EmailAddress>%@</tns:EmailAddress>"
                            "<tns:AlertBySMS>%@</tns:AlertBySMS>"
                            "<tns:AlertByCall>%@</tns:AlertByCall>"
                            "<tns:MobileNo>%@</tns:MobileNo>"
                            "<tns:IMEINo>%@</tns:IMEINo>"
                            "<tns:GPSLatitude>%@</tns:GPSLatitude>"
                            "<tns:GPSLongitude>%@</tns:GPSLongitude>"
                            "</tns:AddGurdian>"
                            "</SOAP-ENV:Body></SOAP-ENV:Envelope>",relationshipId,userId,RelationshipType,self.name.text,self.surname.text,self.email.text,AlertBySMS,AlertByCall,self.phone.text,identifier,latitude,longitude];

       
        
        NSLog(@"Registering: %@",postStr);
        
        
        
        NSURL *url=[NSURL URLWithString:@"http://182.18.175.194/protectmesos/MySafetyService.asmx"];
        NSString *postLength = [NSString stringWithFormat:@"%d", [postStr length]];
        addGuardianRequest = [[NSMutableURLRequest alloc] initWithURL:url];
        [addGuardianRequest setURL:url];
        [addGuardianRequest setHTTPMethod:@"POST"];
        [addGuardianRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [addGuardianRequest setValue:@"http://tempuri.org/AddGurdian" forHTTPHeaderField:@"SOAPAction"];
        [addGuardianRequest setValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        [addGuardianRequest setHTTPBody:[postStr dataUsingEncoding:NSUTF8StringEncoding]];
       
        
        addGuardianConnection = [[NSURLConnection alloc] initWithRequest:addGuardianRequest delegate:self];
        
        if( addGuardianConnection )
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
    

    
    _message =[[ProtectmeEventClass alloc]init];
    
     NSString *userId = [SaveAlaramDelayTime getInstance].userId;
    UIDevice *myDevice = [UIDevice currentDevice];           NSString *identifier = [myDevice.identifierForVendor UUIDString];
    [_message getsoapMessageParameters:userId settingstype:@"4" relationType:@"18"mobileNum:@"1234" IMEINo:identifier latitude:latitude longitude:longitude];
    


}

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    
    if([addGuardianConnection isEqual:connection])
    {
    return addGuardianRequest;
    }
    else
    {
        return showGuardianRequest;
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [webData appendData:data];
    NSString *responseData=[[NSString alloc]initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"responce data%@",responseData);

}

-(void) connectionDidFinishLoading:(NSURLConnection *) connection{
    
    mutableStr = [[NSMutableString alloc] init];
    if([addGuardianConnection isEqual:connection])
    {
        
        addGuardianrssParser=[[NSXMLParser alloc]initWithData:webData];
        [addGuardianrssParser setDelegate:self];
        [addGuardianrssParser parse];
    }
    else
    {
        showGuardianParser=[[NSXMLParser alloc]initWithData:webData];
        [showGuardianParser setDelegate:self];
        [showGuardianParser parse];
    }
    
    NSString *responseData=[[NSString alloc]initWithData:webData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",responseData);
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    [mutableStr appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser

{
    
  [HUD hide:YES];
    
    if ([parser isEqual:showGuardianParser]) {
        
        
        NSDictionary *json2 = [NSJSONSerialization
                               JSONObjectWithData:[mutableStr dataUsingEncoding:NSUTF8StringEncoding]
                               options:kNilOptions
                               error:nil];
        mainArray = [json2 objectForKey:@"GaurdianList"];

        [self.table reloadData];
    }
    else
    {
        if (gettingValue==52) {

            alert = [[UIAlertView alloc]initWithTitle:nil message:@"Guardian Added successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            self.addGurdianView.hidden = YES;
            self.addGurdianButton.hidden = NO;
            self.headerLaBEL.text = @"Your safety Guardians";
            [self showingGuardians];
            [self.table reloadData];

        }
        else
        {
                    
            alert = [[UIAlertView alloc]initWithTitle:nil message:@"Guardian Updated successfully." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            self.addGurdianView.hidden = YES;
            self.addGurdianButton.hidden = NO;
            self.headerLaBEL.text = @"Your safety Guardians.";
        }
        
        selecetedIndex = gurdiansArray.count-1;
        [self.table reloadData];
        
        
    }

}
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
   
        [self scrollViewToCenterOfScreen:textField];
        _addGurdianView.scrollEnabled = TRUE;
   
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
        [textField resignFirstResponder];
   
        [self.addGurdianView setContentOffset:CGPointMake(0, 0) animated:YES];
        [textField resignFirstResponder];
        self.addGurdianView.scrollEnabled = FALSE;
   
   	return TRUE;
}

- (void)scrollViewToCenterOfScreen:(UIView *)theView {
    
	CGFloat viewCenterY = theView.center.y;
	CGRect applicationFrame = self.addGurdianView.frame;
    CGFloat availableHeight;
    if ([[UIScreen mainScreen] bounds].size.height==480) {
        
        availableHeight = applicationFrame.size.height - 120;
        
    }
    else
    {
        availableHeight = applicationFrame.size.height - 20;
        
    }
    
	CGFloat y = viewCenterY - availableHeight / 2.0;
	if (y < 0) {
		y = 0;
	}
    [self.addGurdianView setContentOffset:CGPointMake(0, y) animated:YES];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mainArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    
     cell = (TableviewCell *) [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TableviewCell" owner:self options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (TableviewCell *)currentObject;
                break;
            }
        }
    }

    cell.name.text = [[mainArray objectAtIndex:indexPath.row] objectForKey:@"Name"];
    cell.phonenumber.text = [[mainArray objectAtIndex:indexPath.row] objectForKey:@"MobileNo"];
    if ( [[[mainArray objectAtIndex:indexPath.row] objectForKey:@"AlertBySMS"] isEqual:@"True"]) {
        [cell.sms setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
    }
 
    if ([[[mainArray objectAtIndex:indexPath.row] objectForKey:@"AlertByCall"] isEqual:@"True"]) {
        [cell.call setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
    }
    
    [cell.deleteButton setTag:indexPath.row];
    [cell.editButton setTag:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.gurdiansAccess = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell =(TableviewCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell changeImages];
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (IBAction)alertMySMS:(UIButton*)sender {
    
    
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"checkbox.png"]]) {
        [sender setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
        AlertBySMS = @"1";
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
         AlertBySMS = @"0";
    }
    
    
}
- (IBAction)alertByPhone:(UIButton*)sender {
    
    
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"checkbox.png"]]) {
        [sender setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
        AlertByCall = @"1";
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
        AlertByCall = @"0";
    }
    
}

-(void)settingTheValues:(int)sender
{
    gettingValue = sender;
    relationshipId = [[[mainArray objectAtIndex:sender] objectForKey:@"RelationShipID"] intValue];
    self.addGurdianView.hidden = NO;
    self.name.text = [[mainArray objectAtIndex:sender] objectForKey:@"Name"];
    self.surname.text = [[mainArray objectAtIndex:sender] objectForKey:@"Surname"];
    self.email.text = [[mainArray objectAtIndex:sender] objectForKey:@"EmailAddress"];
    self.phone.text = [[mainArray objectAtIndex:sender] objectForKey:@"MobileNo"];
    if ([[[mainArray objectAtIndex:sender] objectForKey:@"AlertByCall"] isEqualToString:@"False"]) {
        [((UIButton*)[self.view viewWithTag:600]) setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
       AlertByCall = @"0";
    }
    else
    {
        [((UIButton*)[self.view viewWithTag:600]) setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
        AlertByCall = @"1";
    }
    if ([[[mainArray objectAtIndex:sender] objectForKey:@"AlertBySMS"] isEqualToString:@"False"]) {
        [((UIButton*)[self.view viewWithTag:500]) setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
         AlertBySMS = @"0";
    }
    else
    {
        [((UIButton*)[self.view viewWithTag:500]) setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
        AlertBySMS = @"1";
    }
    
    
}
-(void) getLocation{
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
     location = [locationManager location];
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
