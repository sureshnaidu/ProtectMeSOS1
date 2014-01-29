//
//  TableviewCell.h
//  MySafety
//
//  Created by trilok kumar reddy munagala on 04/10/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GurdiansViewController;
@interface TableviewCell : UITableViewCell<UIAlertViewDelegate,NSURLConnectionDelegate,NSXMLParserDelegate>
{
    NSXMLParser *deleteGuardianParser;
}
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *phonenumber;
- (IBAction)btn1:(id)sender;
- (IBAction)btn2:(id)sender;
- (IBAction)deleteGurdian:(id)sender;
- (IBAction)editGurdian:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) GurdiansViewController *gurdiansAccess;
@property (strong, nonatomic) IBOutlet UIButton *editButton;
@property (strong, nonatomic) IBOutlet UIImageView *bgImage;
@property (strong, nonatomic) IBOutlet UIButton *sms;
@property (strong, nonatomic) IBOutlet UIButton *call;
-(void)changeImages;
@end
