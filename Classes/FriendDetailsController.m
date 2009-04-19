//
//  FriendDetails.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 14/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "FriendDetailsController.h"
#import "Fact.h"
#import "Person.h"
#import "FactType.h"
#import "TitleCellBlack.h"
#import "OneRowOneImageEditController.h"
#import "TitleImageCellView.h"
#import "FactOneRowEditController.h"
#import "OneRowEditController.h"

#define TOP_BOTTOM_BORDER 2.0
#define LEFT_RIGHT_BORDER 10.0
#define ICON_WIDTH 50.0
#define ICON_HEIGHT 30.0
#define ICON_SPACE 12.5

@implementation FriendDetailsController

@synthesize personView=_personView;
@synthesize scrollView=_scrollView;
@synthesize person=_person;
@synthesize selectItemIndex=_selectItemIndex;
@synthesize factTypes=_factTypes;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		[self loadAppDelegate];
		[self loadFactTypes];
    }
    return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	// Table View row height
	self.tableView.rowHeight = BLACK_ROW_HEIGHT;
	
	self.personView.title = self.person.fullName;
	self.personView.subtitle = self.person.partialAddress;
	
	[self loadFactTypes];
	
	self.selectItemIndex = 0;
	
	// Reload tableview when this notifiation fire
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableview:) name:ShouldReloadFriendController object:nil];
	
	// Reload Tableview when index change
	[self addObserver:self 
		   forKeyPath:@"selectItemIndex"
			  options:NSKeyValueObservingOptionNew
			  context:@selector(selectedItemIndexChanged:)];
}

- (void)selectedItemIndexChanged:(id)sender
{
	//[[self fetchedResultsController]performFetch:nil];
	
	if (!self.factTypes) {
		[self loadFactTypes];
	}
    
    /*
	 Set up the fetched results controller.
	 */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Fact" inManagedObjectContext:self.appDelegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	FactType *factType = [self.factTypes objectAtIndex:self.selectItemIndex];
	self.navigationItem.title = factType.name;
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(person = %@) AND (fact_type = %@)", self.person, factType]; 
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
	
	[self.fetchedResultsController performFetch:nil];
	
	[self.tableView reloadData];
}

- (void)setupNavigationBar
{
	
	// Let user add row
	UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
																		 target:self 
																		 action:@selector(addNewFactType:)];
	self.navigationItem.rightBarButtonItem = item;
	[item release];
	
	if ([self.factTypes count] > 0) {
		FactType *factType = [self.factTypes objectAtIndex:self.selectItemIndex];
		self.navigationItem.title = factType.name;
	} else {
		self.navigationItem.title = @"Details";
	}
	
	
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
	
	UIBarButtonItem *newFactType = [[UIBarButtonItem alloc]initWithTitle:@"Add New Fact"
																   style:UIBarButtonItemStyleBordered
																  target:self 
																  action:@selector(addNewFact:)];
	
	
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

- (IBAction)removePerson:(id)sender
{
	[self.navigationController popViewControllerAnimated:TRUE];
	
	NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
	[context deleteObject:self.person];
	
	// Save the context.
	NSError *error;
	if (![context save:&error]) {
		// Handle the error...
	}
	
	[[NSNotificationCenter defaultCenter] postNotificationName:ShouldReloadFriendsController object:nil];
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
	for (UIImageView *icon in [self.scrollView subviews]) {
		[icon removeFromSuperview];
	}
	
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"FactType" inManagedObjectContext:self.appDelegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"priority" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	self.factTypes = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
	// Foreach fact types add it to the scrollview
	NSInteger count = [self.factTypes count];
	if (count > 0) {
		// Increase the scrollview width
		CGFloat widthToIncrease = (count - 1) * ICON_WIDTH + (count - 1) * ICON_SPACE;
		self.scrollView.contentSize = CGSizeMake(320.0 + widthToIncrease, self.scrollView.frame.size.height);
		NSInteger index = 0;
		for (FactType *fact in self.factTypes) {
			UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(LEFT_RIGHT_BORDER + (2 + index) * ICON_WIDTH + (2 + index) * ICON_SPACE, TOP_BOTTOM_BORDER, ICON_WIDTH, ICON_HEIGHT)];
			icon.image = [UIImage imageNamed:fact.image_name];
			[self.scrollView addSubview:icon];
			index++;
		}
	}
	
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
}



- (void)reloadTableview:(id)sender
{
	[self loadFactTypes];
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
	
	if (!self.factTypes) {
		[self loadFactTypes];
	}
	FactType *factType = [self.factTypes objectAtIndex:self.selectItemIndex];
	
	// Present modal view controller, were you can enter the group name
	FactOneRowEditController *controller = [[FactOneRowEditController alloc]initWithNibName:@"OneRowEditController" bundle:nil];
	controller.entityName = @"Fact";
	controller.propertyName = @"fact";
	controller.person = self.person;
	controller.factType = factType;
	controller.notificationName = ShouldReloadFriendController;
	controller.title = @"New Fact";
	[self.navigationController presentModalViewController:controller animated:TRUE];
	[controller release];
}

#pragma mark Scroll view delegate

//- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
//{
//	CGFloat itemWidth = ICON_WIDTH + ICON_SPACE;
//	CGFloat itemLocation = (self.scrollView.contentOffset.x / itemWidth);
//	NSInteger item =  round(itemLocation);
//	
//	DLog(@"itemLocation begin: %d", item);
//}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	
	CGFloat itemWidth = ICON_WIDTH + ICON_SPACE;
	CGFloat itemLocation = (self.scrollView.contentOffset.x / itemWidth);
	NSInteger itemIndex =  round(itemLocation);
	
	if (!self.factTypes) {
		[self loadFactTypes];
	}
	
	NSInteger factTypesCount = [self.factTypes count];
	
	if (itemIndex < 0 && itemIndex < factTypesCount) {
		itemIndex = 0;
	}
	
	if (itemIndex > factTypesCount - 1) {
		itemIndex = factTypesCount - 1;
	}
	
	if (!decelerate) {
		[self.scrollView setContentOffset:CGPointMake(itemIndex * itemWidth, 0.0) animated:TRUE];
	}
	
	if (self.selectItemIndex != itemIndex) {
		self.selectItemIndex = itemIndex;
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	CGFloat itemWidth = ICON_WIDTH + ICON_SPACE;
	CGFloat itemLocation = (self.scrollView.contentOffset.x / itemWidth);
	NSInteger itemIndex =  round(itemLocation);
	
	if (!self.factTypes) {
		[self loadFactTypes];
	}
	
	NSInteger factTypesCount = [self.factTypes count];
	
	if (itemIndex < 0 && itemIndex < factTypesCount) {
		itemIndex = 0;
	}
	
	if (itemIndex > factTypesCount - 1) {
		itemIndex = factTypesCount - 1;
	}
	
	if (self.selectItemIndex != itemIndex) {
		self.selectItemIndex = itemIndex;
	}
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
	Fact *fact = (Fact *)[fetchedResultsController objectAtIndexPath:indexPath];
	
	cell.cellView.title = fact.fact;
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSManagedObject *fact = [fetchedResultsController objectAtIndexPath:indexPath];
	
	if (!self.factTypes) {
		[self loadFactTypes];
	}
	FactType *factType = [self.factTypes objectAtIndex:self.selectItemIndex];
	
	// Present modal view controller
	FactOneRowEditController *controller = [[FactOneRowEditController alloc]initWithNibName:@"OneRowEditController" bundle:nil];
	controller.entityName = @"Fact";
	controller.propertyName = @"fact";
	controller.person = self.person;
	controller.object = fact;
	controller.factType = factType;
	controller.notificationName = ShouldReloadFriendController;
	controller.title = @"New Fact";
	[self.navigationController presentModalViewController:controller animated:TRUE];
	[controller release];	
	
	[self.tableView deselectRowAtIndexPath:indexPath animated:TRUE];
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
	
	if (!self.factTypes) {
		[self loadFactTypes];
	}
    
    /*
	 Set up the fetched results controller.
	 */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Fact" inManagedObjectContext:self.appDelegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(person = %@)", self.person];
	if ([self.factTypes count] > 0) {
		FactType *factType = [self.factTypes objectAtIndex:self.selectItemIndex];
		predicate = [NSPredicate predicateWithFormat:@"(person = %@) AND (fact_type = %@)", self.person, factType];
	}
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
	[self removeObserver:self forKeyPath:@"selectItemIndex"];
	[[NSNotificationCenter defaultCenter]removeObserver:self];
	
	[_factTypes release];
	[_personView release];
	[_person release];
	[_scrollView release];
	
    [super dealloc];
}


@end
