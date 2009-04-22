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
	UINavigationController *_navigationController;
	UITableView *_tableView;
	
	NSArray *_content;
}

@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *content;

- (IBAction)doneSettings:(id)sender;
- (void)setupNavigationBar;

@end
