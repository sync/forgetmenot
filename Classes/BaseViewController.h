//
//  BaseViewController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 6/02/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController {
	ForgetMeNotAppDelegate *_appDelegate;
}

@property (nonatomic, retain) ForgetMeNotAppDelegate *appDelegate;

- (void)loadAppDelegate;

- (void)setupNavigationBar;

- (void)setupToolbar;

- (void)restoreLevelWithSelectionArray:(NSArray *)selectionArray;

- (IBAction)showSettings:(id)sender;

- (IBAction)showMap:(id)sender;
- (IBAction)showFriends:(id)sender;

@end
