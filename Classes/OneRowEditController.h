//
//  OneRowEditController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 13/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface OneRowEditController : BaseViewController <UITextFieldDelegate>{
	UINavigationBar *_navigationBar;
	
	UITextField *_textField;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UITextField *textField;

- (IBAction)cancelEditing:(id)sender;
- (IBAction)doneEditing:(id)sender;

@end
