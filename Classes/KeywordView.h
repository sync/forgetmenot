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

@interface KeywordView : UIView <UITextFieldDelegate>{
	UITextField *_textField;
	
	Fact *_fact;
	ForgetMeNotAppDelegate *_appDelegate;
	
	UIImage *_backgroundImage;
}


@property (nonatomic, retain) ForgetMeNotAppDelegate *appDelegate;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) Fact *fact;
@property (nonatomic, retain) UIImage *backgroundImage;

- (void)textDidChange:(id)sender;
- (void)loadAppDelegate;

- (void)showDeleteButton:(id)sender;
- (void)hideDeleteButton:(id)sender;

@end
