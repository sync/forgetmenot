//
//  FriendDetails.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 14/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "FriendDetailsController.h"
#import "Group.h"
#import "Person.h"
#import "TitleCellBlack.h"
#import "OneRowOneImageEditController.h"
#import "TitleImageCellView.h"

@implementation FriendDetailsController

@synthesize personView=_personView;
@synthesize scrollView=_scrollView;
@synthesize person=_person;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Table View row height
	self.tableView.rowHeight = BLACK_ROW_HEIGHT;
	
	self.personView.title = self.person.first_name;
	self.personView.subtitle =  @"Kelvin Grove, QLD, Australia";
	
	// Reload tableview when this notifiation fire
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableview:) name:ShouldReloadFriendController object:nil];
}

- (void)setupNavigationBar
{
	
	// Let user add row
	UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																		 target:self 
																		 action:@selector(addNewFact:)];
	self.navigationItem.rightBarButtonItem = item;
	[item release];
	
	self.navigationItem.title = @"Details";
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
	UIBarButtonItem *flexItemLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																			  target:nil
																			  action:nil];
	
	UIBarButtonItem *newFactType = [[UIBarButtonItem alloc]initWithTitle:@"New Fact Type"
																   style:UIBarButtonItemStyleBordered
																  target:self 
																  action:@selector(addNewFactType:)];
	
	
	// flex item used to separate the left groups items and right grouped items
	UIBarButtonItem *flexItemRight = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																			  target:nil
																			  action:nil];
	
	// create a special tab bar item with a custom image and title
	UIBarButtonItem *mapItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbar_map.png"]
																style:UIBarButtonItemStylePlain
															   target:self
															   action:@selector(showMap:)];
	
	
	NSArray *items = [NSArray arrayWithObjects:settingsItem, flexItemLeft, newFactType, flexItemRight, mapItem, nil];
	[self setToolbarItems:items animated:FALSE];
	[settingsItem release];
	[flexItemLeft release];
	[newFactType release];
	[flexItemRight release];
	[mapItem release];
}

- (IBAction)addNewFactType:(id)sender
{
	// Make sure the tableview is not currently in edit mode
	[self setEditing:FALSE];
	
	// Present modal view controller, were you can enter the group name
	OneRowOneImageEditController *controller = [[OneRowOneImageEditController alloc]initWithNibName:@"OneRowOneImageEditController" bundle:nil];
	controller.entityName = @"FactType";
	controller.propertyName = @"name";
	controller.imagePropertyName = @"image_name";
	controller.notificationName = ShouldReloadFriendController;
	controller.title = @"New Facty Type";
	[self.navigationController presentModalViewController:controller animated:TRUE];
	[controller release];
}

- (void)loadFactTypes
{
	
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

#pragma mark Add Fact

- (IBAction)addNewFact:(id)sender
{
	// Make sure the tableview is not currently in edit mode
	[self setEditing:FALSE];
	
	// Present modal view controller, were you can enter the group name
	OneRowEditController *controller = [[OneRowEditController alloc]initWithNibName:@"OneRowEditController" bundle:nil];
	controller.entityName = @"Fact";
	controller.propertyName = @"fact";
	controller.notificationName = ShouldReloadFriendController;
	controller.title = @"New Fact";
	[self.navigationController presentModalViewController:controller animated:TRUE];
	[controller release];
}



#pragma mark Table view methods

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    TitleCellBlack *cell = (TitleCellBlack *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TitleCellBlack alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	Group *group = (Group *)[fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.cellView.title = group.name;
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
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
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Fact" inManagedObjectContext:self.appDelegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"person = %@", self.person]; 
	[fetchRequest setPredicate:predicate]; 
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"fact" ascending:YES];
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
	[_personView release];
	[_person release];
	[_scrollView release];
	
    [super dealloc];
}


@end
