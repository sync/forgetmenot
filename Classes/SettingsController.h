//
//  PreferencesController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 20/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface SettingsController : BaseViewController <UITableViewDelegate, UITableViewDataSource>{
	UINavigationBar *_navigationBar;
	UITableView *_tableView;
	
	NSArray *_content;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *content;

- (IBAction)doneSettings:(id)sender;

@end
