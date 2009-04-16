//
//  FriendsController.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 9/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "FriendsController.h"
#import "Group.h"
#import "Person.h"
#import "TitleImageCell.h"
#import "FriendDetailsController.h"

@implementation FriendsController

@synthesize group=_group;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.tableView.rowHeight = ROW_HEIGHT;
}

- (void)setupNavigationBar
{	
	// Let user add row
	UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																		 target:self 
																		 action:@selector(addPerson:)];
	self.navigationItem.rightBarButtonItem = item;
	[item release];
	
	self.navigationItem.title = self.group.name;
}

- (void)setupToolbar
{	
	[self.navigationController setToolbarHidden:FALSE animated:FALSE];
	
	// create a special tab bar item with a custom image and title
	UIBarButtonItem *settingsItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbar_settings.png"]
																	 style:UIBarButtonItemStylePlain
																	target:self
																	action:@selector(showSettings:)];
	
	// flex item used to separate the left groups items and right grouped items
	UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																			  target:nil
																			  action:nil];
	
	// create a special tab bar item with a custom image and title
	UIBarButtonItem *mapItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbar_map.png"]
																style:UIBarButtonItemStylePlain
															   target:self
															   action:@selector(showMap:)];
	
	NSArray *items = [NSArray arrayWithObjects:settingsItem, flexItem, mapItem, nil];
	[self setToolbarItems:items animated:FALSE];
	[settingsItem release];
	[flexItem release];
	[mapItem release];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[super viewDidUnload];
}


#pragma mark Table view methods


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
   TitleImageCell *cell = (TitleImageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[[TitleImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	// Set up the cell...
	Person *person = (Person *)[fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.cellView.title = person.first_name;
	cell.cellView.subtitle = @"Kelvin Grove, QLD, Australia";
	
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	Person *person = (Person *)[fetchedResultsController objectAtIndexPath:indexPath];
	
	FriendDetailsController *controller = [[FriendDetailsController alloc] initWithNibName:@"FriendDetailsController" bundle:nil];
	controller.person = person;
	[self.navigationController pushViewController:controller animated:TRUE];
	[controller release];
}

- (NSFetchedResultsController *)fetchedResultsController {
    
	if (fetchedResultsController != nil) {
        return fetchedResultsController;
    }
    
    /*
	 Set up the fetched results controller.
	 */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.appDelegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Filter by group name
	// Only if group is not All
	if (![self.group.name isEqualToString:@"All"]) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"group = %@", self.group]; 
		[fetchRequest setPredicate:predicate]; 
	}
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"first_name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
	self.fetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	return fetchedResultsController;
} 

#pragma mark -
#pragma mark People Picker

- (IBAction)addPerson:(id)sender
{ 
	ABPeoplePickerNavigationController *picker = 
	[[ABPeoplePickerNavigationController alloc] init]; 
	picker.peoplePickerDelegate = self;
	[self presentModalViewController:picker animated:YES]; 
	[picker release]; 
} 

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker 
{ 
	[self dismissModalViewControllerAnimated:YES]; 
	//[self.appDelegate addTabBarOverlayInRect:CGRectMake(0.0, 422.0, 320.0, 9.0)];
} 

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker 
	  shouldContinueAfterSelectingPerson:(ABRecordRef)personRef 
{ 
	NSInteger recordID = ABRecordGetRecordID(personRef);
	
	NSString *firstName = (NSString *)ABRecordCopyValue(personRef, kABPersonFirstNameProperty); 
	NSString *lastName = (NSString *)ABRecordCopyValue(personRef, kABPersonLastNameProperty);
	
	// Get Mangaged object context
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	
	Person *person = [Person personWithRecordID:[NSNumber numberWithInteger:recordID] forContext:context];
	if (!person) {
		// Create a new instance of the entity managed by the fetched results controller.
		NSEntityDescription *entity = [[fetchedResultsController fetchRequest] entity];
		person = (Person *)[NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
		person.recordID = [NSNumber numberWithInteger:recordID];
	}
	
	// If appropriate, configure the new managed object.
	person.first_name = firstName;
	person.last_name = lastName;
	
	person.group = self.group;
	
	// Save the context.
    NSError *error;
    if (![context save:&error]) {
		// Handle the error...
    }
	
    [self.tableView reloadData];
	
	[firstName release];
	[lastName release];
	
	[self dismissModalViewControllerAnimated:YES]; 
	
	return NO; 
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person 
								property:(ABPropertyID)property 
							  identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
}


- (void)dealloc {
	[_group release];
	
    [super dealloc];
}


@end

