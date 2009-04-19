//
//  FriendsController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 9/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseFetchedTableViewController.h"
#import <AddressBook/AddressBook.h> 
#import <AddressBookUI/AddressBookUI.h>

@class Group;

@interface FriendsController : BaseFetchedTableViewController <ABPeoplePickerNavigationControllerDelegate>{
	Group *_group;
}

@property (nonatomic, retain) Group *group;

- (IBAction)addPerson:(id)sender;
- (void)reloadTableview:(id)sender;

@end
