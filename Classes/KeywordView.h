//
//  KeywordView.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 6/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Fact;

@interface KeywordView : UIView <UITextFieldDelegate>{
	UITextField *_textField;
	
	Fact *_fact;
	ForgetMeNotAppDelegate *_appDelegate;
}


@property (nonatomic, retain) ForgetMeNotAppDelegate *appDelegate;
@property (nonatomic, retain) UITextField *textField;
@property (nonatomic, retain) Fact *fact;

- (void)textDidChange:(id)sender;
- (void)loadAppDelegate;

@end
