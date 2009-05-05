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
#import "BackgroundViewWithImage.h"


@implementation SettingsFactTypesController

@synthesize factTypes=_factTypes;
@synthesize lastIndexPath=_lastIndexPath;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	if (!self.factTypes) {
		// Create the fetch request for the entity.
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		// Edit the entity name as appropriate.
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"FactType" inManagedObjectContext:self.appDelegate.managedObjectContext];
		[fetchRequest setEntity:entity];
		
		self.factTypes = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
		
		[self setEditing:TRUE];
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
	
	cell.factTypeID = factType.objectID;
	
//	NSString *imageNamed = [[title stringByReplacingOccurrencesOfString:@" " withString:@"_"]lowercaseString];
//	[cell setImage:[UIImage imageNamed:[imageNamed stringByAppendingString:@".png"]]];
	
    return cell;
}






// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
	return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
	return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
	// Set up the cell...
	FactType *factType = (FactType *)[fetchedResultsController objectAtIndexPath:fromIndexPath];
	factType.priority = [NSNumber numberWithInteger:toIndexPath.row];
	
	// Check if up / down
	BOOL up = TRUE;
	if (toIndexPath.row > fromIndexPath.row) {
		up = FALSE;
		DLog(@"down");
	} else {
		DLog(@"up");
	}
	// Should rebuilt before to index path
	if (!up) {
		[self reconstructPositionUpFromIndex:toIndexPath.row];
	// Should rebuilt after the index path
	} else {
		[self reconstructPositionDownFromIndex:toIndexPath.row];
	}
	
	NSManagedObjectContext *context = [fetchedResultsController managedObjectContext];
	NSError *error;
	if (![context save:&error]) {
		// Handle the error...
	}
	
	self.lastIndexPath = nil;
}

- (void)reconstructPositionDownFromIndex:(NSInteger)index
{
	// Check the number of fact types
	NSInteger count = [self.factTypes count];
	
	for (NSInteger i=index;i<count;i++) {
		SettingsCell *cell = (SettingsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		FactType *factType = [FactType factTypeWithID:cell.factTypeID forContext:self.fetchedResultsController.managedObjectContext];
		factType.priority = [NSNumber numberWithInteger:i];
	}
}

- (void)reconstructPositionUpFromIndex:(NSInteger)index
{	
	for (NSInteger i=index;i>=0;i--) {
		SettingsCell *cell = (SettingsCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		FactType *factType = [FactType factTypeWithID:cell.factTypeID forContext:self.fetchedResultsController.managedObjectContext];
		factType.priority = [NSNumber numberWithInteger:i];
	}
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
	DLog(@"target row at index path    : %@", sourceIndexPath);
	DLog(@"target row at index path to : %@", proposedDestinationIndexPath);
	
	// Redraw the dragged cell
	SettingsCell *selectedCell = (SettingsCell *)[tableView cellForRowAtIndexPath:sourceIndexPath];
	[self modifyBackgroundForCell:selectedCell forIndexPath:proposedDestinationIndexPath];
	
	// Check if up or down
	BOOL up = TRUE;
	if (self.lastIndexPath) {
		if (proposedDestinationIndexPath.row > self.lastIndexPath.row) {
			up = FALSE;
		}
	} else {
		if (proposedDestinationIndexPath.row > sourceIndexPath.row) {
			up = FALSE;
		}
	}
	
	// Check the number of fact types
	NSInteger count = [self.factTypes count];
	
	// down
	if (!up) {
		// If down should check for source index path +1 and redraw
		// Only if source is first index
		if (sourceIndexPath.row == 0) {
			SettingsCell *cell = (SettingsCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sourceIndexPath.row+1 inSection:sourceIndexPath.section]];
			[self modifyBackgroundForCell:cell forIndexPath:[NSIndexPath indexPathForRow:0 inSection:sourceIndexPath.section]];
		}
		if (self.lastIndexPath.row == 0 && sourceIndexPath.row != 0) {
			SettingsCell *cell = (SettingsCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:sourceIndexPath.section]];
			[self modifyBackgroundForCell:cell forIndexPath:[NSIndexPath indexPathForRow:0 inSection:sourceIndexPath.section]];
		}
		if (self.lastIndexPath.row == count-2 && count > 3) {
			SettingsCell *cell = (SettingsCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:count-2 inSection:proposedDestinationIndexPath.section]];
			[self modifyBackgroundForCell:cell forIndexPath:[NSIndexPath indexPathForRow:count-2 inSection:proposedDestinationIndexPath.section]];
		}
		
		// Last bottom row should redrawn
		// Only if proposed index is last
		if (proposedDestinationIndexPath.row == count-1 && sourceIndexPath.row != count-1) {
			SettingsCell *cell = (SettingsCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:count-1 inSection:proposedDestinationIndexPath.section]];
			[self modifyBackgroundForCell:cell forIndexPath:[NSIndexPath indexPathForRow:count-2 inSection:proposedDestinationIndexPath.section]];
		}
	// up
	} else {
		// If source is last redraw source -1
		// With last Index count-1
		if (sourceIndexPath.row == count-1) {
			SettingsCell *cell = (SettingsCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:sourceIndexPath.row-1 inSection:sourceIndexPath.section]];
			[self modifyBackgroundForCell:cell forIndexPath:[NSIndexPath indexPathForRow:count-1 inSection:sourceIndexPath.section]];
		}
		if (self.lastIndexPath.row == count-1 && sourceIndexPath.row != count-1) {
			SettingsCell *cell = (SettingsCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:count-1 inSection:proposedDestinationIndexPath.section]];
			[self modifyBackgroundForCell:cell forIndexPath:[NSIndexPath indexPathForRow:count-1 inSection:proposedDestinationIndexPath.section]];
		}
		if (proposedDestinationIndexPath.row == 0 && sourceIndexPath.row != 0) {
			SettingsCell *cell = (SettingsCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:proposedDestinationIndexPath.section]];
			[self modifyBackgroundForCell:cell forIndexPath:[NSIndexPath indexPathForRow:proposedDestinationIndexPath.row+1 inSection:proposedDestinationIndexPath.section]];
		}
		if (self.lastIndexPath.row == 1) {
			SettingsCell *cell = (SettingsCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:proposedDestinationIndexPath.section]];
			[self modifyBackgroundForCell:cell forIndexPath:[NSIndexPath indexPathForRow:1 inSection:proposedDestinationIndexPath.section]];
		}
	}
	
	// Remember last index
	self.lastIndexPath = proposedDestinationIndexPath;
	
//	for (int i=proposedDestinationIndexPath.row;i=0;i--) {
//		SettingsCell *toCell = (SettingsCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:proposedDestinationIndexPath.section]];
//	}
	
//	SettingsCell *toCell = (SettingsCell *)[tableView cellForRowAtIndexPath:proposedDestinationIndexPath];
//	[self modifyBackgroundForCell:toCell forIndexPath:[NSIndexPath indexPathForRow:!up?proposedDestinationIndexPath.row+1:proposedDestinationIndexPath.row-1 inSection:proposedDestinationIndexPath.section]];
	
	return proposedDestinationIndexPath;
}

- (void)modifyBackgroundForCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
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
	
	NSString *imageName = nil;
	NSString *selectedImageName = nil;
	
	switch (position) {
		case UITableViewCellPositionTop:
			imageName = @"settings_cell_top.png";
			selectedImageName = @"settings_cell_top_selected.png";
			break;
		case UITableViewCellPositionBottom:
			imageName = @"settings_cell_bottom.png";
			selectedImageName = @"settings_cell_bottom_selected.png";
			break;
		case UITableViewCellPositionUnique:
			imageName = @"settings_cell_unique.png";
			selectedImageName = @"settings_cell_unique_selected.png";
			break;
		default:
			imageName = @"settings_cell_middle.png";
			selectedImageName = @"settings_cell_middle_selected.png";
			break;
	}
	
	CGRect cellFrame = CGRectMake(0.0, 0.0, cell.contentView.bounds.size.width, cell.contentView.bounds.size.height);
	
	
	// BackgroundView
	BackgroundViewWithImage *backgroundView = [BackgroundViewWithImage backgroundViewWithFrame:cellFrame andBackgroundImageName:imageName];
	cell.backgroundView = backgroundView;
	
	BackgroundViewWithImage *selectedBackgroundView = [BackgroundViewWithImage backgroundViewWithFrame:cellFrame andBackgroundImageName:selectedImageName];
	cell.selectedBackgroundView = selectedBackgroundView;
	
	[cell setNeedsDisplay];
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
	[_lastIndexPath release];
	[_factTypes release];
	
    [super dealloc];
}


@end

