//
//  PreferencesController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 20/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface PreferencesController : BaseTableViewController {
	NSArray *_content;
}

@property (nonatomic, retain) NSArray *content;

@end
