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
	
	NSString *_entityName;
	NSString *_propertyName;
	NSString *_notificationName;
	
	NSManagedObject *_object;
	
	UIBarButtonItem *_doneButton;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *doneButton;

@property (nonatomic, copy) NSString *entityName;
@property (nonatomic, copy) NSString *propertyName;
@property (nonatomic, copy) NSString *notificationName;
@property (nonatomic, retain) NSManagedObject *object;

- (IBAction)cancelEditing:(id)sender;
- (IBAction)doneEditing:(id)sender;

@end
