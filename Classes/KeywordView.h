//
//  KeywordView.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 6/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ShouldShowKeywordDeleteButtonNotification @"ShouldShowKeywordDeleteButtonNotification"
#define ShouldHideKeywordDeleteButtonNotification @"ShouldHideKeywordDeleteButtonNotification"

@class Fact;
@class ViewWithAction;

@interface KeywordView : UIView <UITextFieldDelegate>{
	UITextField *_textField;
	
	Fact *_fact;
	ForgetMeNotAppDelegate *_appDelegate;
	
	UIImage *_backgroundImage;
	
	ViewWithAction *_deleteButton;
	
	NSMutableArray *_addedKeywords;
}


@property (nonatomic, retain) ForgetMeNotAppDelegate *appDelegate;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) Fact *fact;
@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, retain) ViewWithAction *deleteButton;
@property (nonatomic, retain) NSMutableArray *addedKeywords;

- (void)loadAppDelegate;

- (void)showDeleteButton:(id)sender;
- (void)hideDeleteButton:(id)sender;

- (void)deleteFirstResponderLabel:(id)sender;

@end
