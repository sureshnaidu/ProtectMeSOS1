//
//  TableviewCell.m
//  MySafety
//
//  Created by trilok kumar reddy munagala on 04/10/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import "TableviewCell.h"
#import "GurdiansViewController.h"
@implementation TableviewCell

int tagvalue;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)btn1:(UIButton*)sender {
    
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"checkbox.png"]]) {
        [sender setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)btn2:(UIButton*)sender {
    
    
    if ([sender.imageView.image isEqual:[UIImage imageNamed:@"checkbox.png"]]) {
        [sender setImage:[UIImage imageNamed:@"checkbox-checked.png"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setImage:[UIImage imageNamed:@"checkbox.png"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)deleteGurdian:(UIButton*)sender {
    
   tagvalue = sender.tag;
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Are you sure you want to delete this Guardian." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1) {
        
//        [self.gurdiansAccess deleteGuardian:tagvalue];
        [self deleteGuardianService:[[self.gurdiansAccess.mainArray objectAtIndex:tagvalue] objectForKey:@"UserId"] relationShipId:[[self.gurdiansAccess.mainArray objectAtIndex:tagvalue] objectForKey:@"RelationShipID"]];
    }
    

}


-(void)deleteGuardianService:(NSString*)userID relationShipId:(NSString*)rid
{
  
    NSString *postStr =[NSString stringWithFormat:
                        @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
                        "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">"
                        "<soap:Body>"
                        "<DeleteGurdian xmlns=\"http://tempuri.org/\">"
                        "<RelationShipID>%@</RelationShipID>"
                        "<UserID>%@</UserID>"
                        "<MobileNo>12312312321</MobileNo>"
                        "<IMEINo>50d4300e756f5b44972ba354b9f9b74400000000</IMEINo>"
                        "<GPSLatitude>17.402064</GPSLatitude>"
                        "<GPSLongitude>78.484005</GPSLongitude>"
                        "</DeleteGurdian>"
                        "</soap:Body>"
                        "</soap:Envelope>",rid,userID];
    
    NSLog(@"Deleting: %@",postStr);
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://182.18.175.194/protectmesos/MySafetyService.asmx"]];;
    NSMutableURLRequest *deleGuardianRequest = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [postStr length]];
    
    [deleGuardianRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [deleGuardianRequest addValue: @"http://tempuri.org/DeleteGurdian" forHTTPHeaderField:@"SOAPAction"];
    [deleGuardianRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [deleGuardianRequest setHTTPMethod:@"POST"];
    [deleGuardianRequest setHTTPBody: [postStr dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *deleGuardianConnection  = [NSURLConnection connectionWithRequest:deleGuardianRequest delegate:self];
    
    if( deleGuardianConnection )
    {

    }
    else
    {
        NSLog(@"theConnection is NULL");
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
    deleteGuardianParser=[[NSXMLParser alloc]initWithData:data];
    [deleteGuardianParser setDelegate:self];
    [deleteGuardianParser parse];
}
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    NSLog(@"Found Character: %@",string);
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser

{
    [self.gurdiansAccess showingGuardians];
}

- (IBAction)editGurdian:(UIButton*)sender {
    
    [self.gurdiansAccess settingTheValues:sender.tag];
   
}
-(void)changeImages
{
    _bgImage.image = [UIImage imageNamed:@"caller-white-bg.png"];
    [_editButton setImage:[UIImage imageNamed:@"edit-blue.png"] forState:UIControlStateNormal];
    [_deleteButton setImage:[UIImage imageNamed:@"delete.png"] forState:UIControlStateNormal];
}
@end
