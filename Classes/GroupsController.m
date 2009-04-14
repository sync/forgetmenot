//
//  GroupsController.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 13/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "GroupsController.h"
#import "Group.h"
#import "TitleCell.h"
#import "OneRowEditController.h"
#import "FriendsController.h"

@implementation GroupsController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Table View row height
	self.tableView.rowHeight = ROW_HEIGHT;
	
	self.tableView.allowsSelectionDuringEditing = TRUE;
	
	// Reload tableview when this notifiation fire
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableview:) name:ShouldReloadGroupsController object:nil];
}

- (void)setupNavigationBar
{
	// Let user delete row
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
	
	// Let user add row
	UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																		 target:self 
																		 action:@selector(addGroup:)];
	self.navigationItem.rightBarButtonItem = item;
	[item release];
	
	self.navigationItem.title = @"Groups";
}

- (void)setupToolbar
{	
	[self.navigationController setToolbarHidden:FALSE animated:FALSE];
	
	// create a special tab bar item with a custom image and title
	UIBarButtonItem *settingsItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbar_settings.png"]
																	 style:UIBarButtonItemStylePlain
																	target:self
																	action:@selector(showSettings:)];
	
	NSArray *items = [NSArray arrayWithObjects:settingsItem, nil];
	[self setToolbarItems:items animated:FALSE];
	[settingsItem release];
}



- (void)reloadTableview:(id)sender
{
	[self.tableView reloadData];
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

#pragma mark Add Group

- (IBAction)addGroup:(id)sender
{
	// Make sure the tableview is not currently in edit mode
	[self setEditing:FALSE];
	
	// Present modal view controller, were you can enter the group name
	OneRowEditController *controller = [[OneRowEditController alloc]initWithNibName:@"OneRowEditController" bundle:nil];
	controller.entityName = @"Group";
	controller.propertyName = @"name";
	controller.notificationName = ShouldReloadGroupsController;
	controller.navigationItem.title = @"New Group";
	[self.navigationController presentModalViewController:controller animated:TRUE];
	[controller release];
}



#pragma mark Table view methods

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    TitleCell *cell = (TitleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	Group *group = (Group *)[fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.cellView.title = group.name;
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
	NSManagedObject *group = [fetchedResultsController objectAtIndexPath:indexPath];
	
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
	
	if (!cell.editing) {
		// Make sure the tableview is not currently in edit mode
		[self setEditing:FALSE];
		
		FriendsController *controller = [[FriendsController alloc] initWithNibName:@"FriendsController" bundle:nil];
		controller.group = (Group *)group;
		[self.navigationController pushViewController:controller animated:TRUE];
		[controller release];
	} else {
		// Rename modal view controller, were you can edit the group name
		OneRowEditController *controller = [[OneRowEditController alloc]initWithNibName:@"OneRowEditController" bundle:nil];
		controller.entityName = @"Group";
		controller.propertyName = @"name";
		controller.notificationName = ShouldReloadGroupsController;
		controller.object = group;
		controller.navigationItem.title = @"Edit Group";
		[self.navigationController presentModalViewController:controller animated:TRUE];
		[controller release];
	}
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// We don't want to remove the group All
	Group *group = (Group *)[fetchedResultsController objectAtIndexPath:indexPath];
	if ([group.name isEqualToString:@"All"]) {
		return NO;
	}
		
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
		NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
		[context deleteObject:[fetchedResultsController objectAtIndexPath:indexPath]];
		
		// Save the context.
		NSError *error;
		if (![context save:&error]) {
			// Handle the error...
		}
		
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
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
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Group" inManagedObjectContext:self.appDelegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
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


- (void)dealloc {
    [super dealloc];
}


@end

