//
//  GroupsController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 13/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseFetchedTableViewController.h"

@interface GroupsController : BaseFetchedTableViewController {

}

- (void)reloadTableview:(id)sender;

- (IBAction)addGroup:(id)sender;

@end
