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
#import "ReverseGeoCodeOperation.h"

@class Group;

@interface FriendsController : BaseFetchedTableViewController <ABPeoplePickerNavigationControllerDelegate, DefaultOperationDelegate, UISearchDisplayDelegate, UISearchBarDelegate>{
	Group *_group;
	
	NSOperationQueue *_reverseOperationQueue;
	
	UISearchBar *_searchBar;
	
	NSFetchedResultsController *searchFetchedResultsController;
	NSPredicate *_searchPredicate;
}

@property (nonatomic, retain) Group *group;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) NSFetchedResultsController *searchFetchedResultsController;
@property (nonatomic, retain) NSPredicate *searchPredicate;

- (IBAction)addPerson:(id)sender;
- (void)reloadTableview:(id)sender;

- (NSString *)urlEncodeValue:(NSString *)string;

@property (nonatomic, retain) NSOperationQueue *reverseOperationQueue;

@end
