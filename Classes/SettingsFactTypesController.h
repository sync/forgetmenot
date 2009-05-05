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
	
	NSIndexPath *_lastIndexPath;
}

@property (nonatomic, retain) NSArray *factTypes;
@property (nonatomic, retain) NSIndexPath *lastIndexPath;
- (void)modifyBackgroundForCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath;

@end
