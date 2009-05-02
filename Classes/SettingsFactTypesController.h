//
//  SettingsFactTypesController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 22/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseFetchedTableViewController.h"

@interface SettingsFactTypesController : BaseFetchedTableViewController {
	NSArray *_factTypes;
}

@property (nonatomic, retain) NSArray *factTypes;

@end
