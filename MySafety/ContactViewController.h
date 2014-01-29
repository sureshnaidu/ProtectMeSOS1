//
//  ContactViewController.h
//  MySafety
//
//  Created by trilok kumar reddy munagala on 03/10/13.
//  Copyright (c) 2013 InventIT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactViewController : UIViewController<UINavigationControllerDelegate>
- (IBAction)send:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *surname;
@property (strong, nonatomic) IBOutlet UITextField *email;
- (IBAction)back:(id)sender;

@property (strong, nonatomic) IBOutlet UITextView *message;
@end
