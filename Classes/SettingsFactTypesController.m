//
//  SettingsFactTypesController.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 22/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "SettingsFactTypesController.h"
#import "SettingsCell.h"
#import "FactType.h"


@implementation SettingsFactTypesController

@synthesize factTypes=_factTypes;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (!self.factTypes) {
		// Create the fetch request for the entity.
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		// Edit the entity name as appropriate.
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"FactType" inManagedObjectContext:self.appDelegate.managedObjectContext];
		[fetchRequest setEntity:entity];
		
		self.factTypes = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
	}
	
//	NSInteger index = 0;
//	for (FactType *factType in self.factTypes) {
//		factType.priority = [NSNumber numberWithInteger:index];;
//		index++;
//	}
//	
//	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
//	NSError *error;
//	if (![context save:&error]) {
//		// Handle the error...
//	}
}

- (void)setupNavigationBar
{
	// Let user delete row
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	self.navigationItem.title = @"Fact Types";
}

- (void)setupToolbar
{	
	[self.navigationController setToolbarHidden:TRUE animated:FALSE];
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
    
	if (!self.factTypes) {
		// Create the fetch request for the entity.
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		// Edit the entity name as appropriate.
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"FactType" inManagedObjectContext:self.appDelegate.managedObjectContext];
		[fetchRequest setEntity:entity];
		
		self.factTypes = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
	}
	
	NSInteger count = [self.factTypes count];
    
	UITableViewCellPosition position;
	NSString *cellIdentifier = nil;
	if (count == 1) {
		position = UITableViewCellPositionUnique;
		cellIdentifier = UniqueTransparentCell;
	} else {
		if (indexPath.row == 0) {
			position = UITableViewCellPositionTop;
			cellIdentifier = TopTransparentCell;
		} else if (indexPath.row == (count -1)) {
			position = UITableViewCellPositionBottom;
			cellIdentifier = BottomTransparentCell;
		} else {
			position = UITableViewCellPositionMiddle;
			cellIdentifier = MiddleTransparentCell;
		}
	}
	
	SettingsCell *cell = (SettingsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [SettingsCell cellWithStyle:UITableViewCellStyleDefault position:position];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	
	// Set up the cell...
	FactType *factType = (FactType *)[fetchedResultsController objectAtIndexPath:indexPath];
	
	[cell setTitle:factType.name];
	
//	NSString *imageNamed = [[title stringByReplacingOccurrencesOfString:@" " withString:@"_"]lowercaseString];
//	[cell setImage:[UIImage imageNamed:[imageNamed stringByAppendingString:@".png"]]];
	
    return cell;
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

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
	NSLog(@"commited");
	// Set up the cell...
	FactType *factType = (FactType *)[fetchedResultsController objectAtIndexPath:fromIndexPath];
	factType.priority = [NSNumber numberWithInteger:toIndexPath.row];
	
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	NSError *error;
	if (![context save:&error]) {
		// Handle the error...
	}
	
	//[self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
	
	//[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:fromIndexPath, toIndexPath, nil] withRowAnimation:reloadSections:withRowAnimation:];
}

//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
//{
//	
//}

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
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"FactType" inManagedObjectContext:self.appDelegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"priority" ascending:YES];
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
	[_factTypes release];
	
    [super dealloc];
}


@end

