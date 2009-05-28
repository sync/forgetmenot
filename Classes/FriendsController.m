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
@synthesize reverseOperationQueue=_reverseOperationQueue;
@synthesize searchBar=_searchBar;
@synthesize searchPredicate=_searchPredicate;
@synthesize searchFetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSOperationQueue *queue =  [[NSOperationQueue alloc]init];
	queue.maxConcurrentOperationCount = 1;
	self.reverseOperationQueue = queue;
	[queue release];
	
	self.tableView.rowHeight = ROW_HEIGHT;
	
	// Setup search bar
	self.searchBar.tintColor = [UIColor	colorWithRed:156.0/255.0 green:157.0/255.0 blue:156.0/255.0 alpha:1.0];	
	self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo; // Don't get in the way of user typing.
	self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone; // Don't capitalize each word.
	self.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"All", @"Friend", @"Fact", nil];
	self.searchBar.delegate = self; // Become delegate to detect changes in scope.
	
	// Setup tableview search result controller
	self.searchDisplayController.searchResultsTableView.rowHeight = ROW_HEIGHT;
	self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor darkGrayColor];
	self.searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	NSError *error;
	if (![[self searchFetchedResultsController] performFetch:&error]) {
		// Handle the error...
	}
	
	// Reload tableview when this notifiation fire
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableview:) name:ShouldReloadFriendsController object:nil];
}


- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
	// Setup tableview search result controller
	self.searchDisplayController.searchResultsTableView.rowHeight = ROW_HEIGHT;
	self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor darkGrayColor];
	self.searchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	/*
	 Set up the fetched results controller.
	 */
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.appDelegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Filter by group name
	if ([scope isEqualToString:@"All"]) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(city contains[cd] %@) OR (country contains[cd] %@) OR (first_name contains[cd] %@) OR (last_name contains[cd] %@) OR (middle_names contains[cd] %@) OR (post_code contains[cd] %@) OR (state contains[cd] %@) OR (street contains[cd] %@) OR (fact.fact contains[cd] %@) OR (fact.fact_type.name contains[cd] %@)", searchText, searchText, searchText, searchText, searchText, searchText, searchText, searchText, searchText, searchText, searchText]; 
		[fetchRequest setPredicate:predicate]; 
		self.searchPredicate = predicate;
	} else if ([scope isEqualToString:@"Friend"]) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(city contains[cd] %@) OR (country contains[cd] %@) OR (first_name contains[cd] %@) OR (last_name contains[cd] %@) OR (middle_names contains[cd] %@) OR (post_code contains[cd] %@) OR (state contains[cd] %@) OR (street contains[cd] %@)", searchText, searchText, searchText, searchText, searchText, searchText, searchText, searchText, searchText]; 
		[fetchRequest setPredicate:predicate]; 
		self.searchPredicate = predicate;
	} else if ([scope isEqualToString:@"Fact"]) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(fact.fact contains[cd] %@) OR (fact.fact_type.name contains[cd] %@)", searchText, searchText]; 
		[fetchRequest setPredicate:predicate]; 
		self.searchPredicate = predicate;
	} else if ([scope isEqualToString:@"Keyword"]) {
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY fact.keyword.name contains[cd] %@", searchText]; 
		[fetchRequest setPredicate:predicate]; 
		self.searchPredicate = predicate;
	}
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"first_name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	
	// Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
	NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.appDelegate.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
	self.searchFetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	NSError *error;
	if (![[self searchFetchedResultsController] performFetch:&error]) {
		// Handle the error...
	}
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
	 [[self.searchBar scopeButtonTitles] objectAtIndex:[self.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchBar text] scope:
	 [[self.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)reloadTableview:(id)sender
{
	[self.tableView reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [[searchFetchedResultsController sections] count];
    }
    return [[fetchedResultsController sections] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (tableView == self.searchDisplayController.searchResultsTableView) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[searchFetchedResultsController sections] objectAtIndex:section];
		return [sectionInfo numberOfObjects];
    }
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
   TitleImageCell *cell = (TitleImageCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
    if (cell == nil) {
        cell = [[[TitleImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Set up the cell...
	Person *person = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView) {
       person = (Person *)[searchFetchedResultsController objectAtIndexPath:indexPath];
    } else {
		person = (Person *)[fetchedResultsController objectAtIndexPath:indexPath];
	}
	
	
	cell.cellView.title = person.fullName;
	cell.cellView.subtitle = person.partialAddress;
	NSString *imageURL = [self.appDelegate applicationDocumentsDirectory];
	if (person.local_image_url) {
		imageURL = [imageURL stringByAppendingPathComponent:person.local_image_url];
	}
	UIImage *image = [UIImage imageWithContentsOfFile:imageURL];
	if (!image) {
		image = [UIImage imageNamed:@"empty_friend.png"];
	}
	cell.cellView.imagePreview = image;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	Person *person = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView) {
		person = (Person *)[searchFetchedResultsController objectAtIndexPath:indexPath];
    } else {
		person = (Person *)[fetchedResultsController objectAtIndexPath:indexPath];
	}
	
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

- (NSFetchedResultsController *)searchFetchedResultsController {
    
	if (searchFetchedResultsController != nil) {
        return searchFetchedResultsController;
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
	self.searchFetchedResultsController = aFetchedResultsController;
	
	[aFetchedResultsController release];
	[fetchRequest release];
	[sortDescriptor release];
	[sortDescriptors release];
	
	return searchFetchedResultsController;
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
	
	// Single Values
	NSString *firstName = (NSString *)ABRecordCopyValue(personRef, kABPersonFirstNameProperty); 
	NSString *lastName = (NSString *)ABRecordCopyValue(personRef, kABPersonLastNameProperty);
	NSString *middleName = (NSString *)ABRecordCopyValue(personRef, kABPersonMiddleNameProperty);
	NSDate *birthday = (NSDate *)ABRecordCopyValue(personRef, kABPersonBirthdayProperty);
	
	// Multiple Values
	ABMultiValueRef addressesRef = ABRecordCopyValue(personRef, kABPersonAddressProperty);
	NSArray *addresses = (NSArray *)ABMultiValueCopyArrayOfAllValues(addressesRef);
	// Set up an NSDictionary to hold the contents of the array.
	NSDictionary *address = nil;
	if ([addresses count] > 0) {
		address = [addresses objectAtIndex:0];
		DLog(@"address: %@", address);
	}
	
	if (addressesRef != NULL) {
		CFRelease(addressesRef);
	}
	
	// Image
	BOOL hasImageData = ABPersonHasImageData(personRef);
	NSString *imagePath = nil;
	if (hasImageData) {
		NSData *imageData = (NSData *)ABPersonCopyImageData(personRef);
		// save the image somewhere
		//Build the path we want the file to be at 
		NSString *imageURL = [self.appDelegate applicationDocumentsDirectory];
		NSString *guid = [[NSProcessInfo processInfo] globallyUniqueString]; 
		imagePath = [NSString stringWithFormat:@"%@.jpeg", guid];
		imageURL = [imageURL stringByAppendingPathComponent:imagePath];
		[imageData writeToFile:imageURL atomically:FALSE];
		[imageData release];
	}
	
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
	person.middle_names = middleName;
	person.birthday = birthday;
	person.local_image_url = imagePath;
	person.street = [address valueForKey:(NSString *)kABPersonAddressStreetKey];
	person.city = [address valueForKey:(NSString *)kABPersonAddressCityKey];
	person.state = [address valueForKey:(NSString *)kABPersonAddressStateKey];
	person.post_code = [address valueForKey:(NSString *)kABPersonAddressZIPKey];
	person.country = [address valueForKey:(NSString *)kABPersonAddressCountryKey];
	
	person.group = self.group;
	
	// Save the context.
    NSError *error;
    if (![context save:&error]) {
		// Handle the error...
    }
	
    [self.tableView reloadData];
	
	[firstName release];
	[lastName release];
	[middleName release];
	[birthday release];
	[addresses release];
	
	[self dismissModalViewControllerAnimated:YES]; 
	
	// Find user location
	NSString *urlString = [self urlEncodeValue:[NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=json&key=ABQIAAAA4yFxsxoDDepDo3ro17yA1hTjOjqphGs0Y9m3nFH3QZboM8-tuxRd5uNAoXEI-bEFHhLbT33JcyYACA", person.fullAddress]];
	
	ReverseGeoCodeOperation *operation = [[ReverseGeoCodeOperation alloc]initWithURL:[NSURL URLWithString:urlString] 
																	  infoDictionary:[NSDictionary dictionaryWithObject:person.objectID forKey:@"objectID"]];
	operation.delegate = self;
	[self.reverseOperationQueue addOperation:operation];
	[operation release];
	
	return NO; 
}

- (NSString *)urlEncodeValue:(NSString *)string
{
	CFStringRef originalURLString = (CFStringRef)string;
	CFStringRef preprocessedString = CFURLCreateStringByAddingPercentEscapes(NULL, originalURLString, NULL, (CFStringRef)@"", kCFStringEncodingUTF8);
	//CFStringRef urlString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, preprocessedString, NULL, (CFStringRef)@";/?:@&=+$", kCFStringEncodingUTF8);
	NSString *stringToReturn = [NSString stringWithString:(NSString *)preprocessedString];
	CFRelease(preprocessedString);
	return stringToReturn;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person 
								property:(ABPropertyID)property 
							  identifier:(ABMultiValueIdentifier)identifier
{
	return NO;
}

- (void)defaultOperationDidStartLoadingWithInfo:(NSDictionary *)info
{
	[[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:TRUE];
}

- (void)defaultOperationDidFailWithInfo:(NSDictionary *)info
{
	[[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:FALSE];
}

- (void)defaultOperationDidFinishLoadingWithInfo:(NSDictionary *)info
{
	if ([info valueForKey:@"objectID"]) {
		NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
		
		NSDictionary *objectDict = [info valueForKey:@"object"];
		
		Person *person = (Person *)[context objectWithID:[info valueForKey:@"objectID"]];
		person.latitude = [objectDict valueForKey:@"latitude"];
		person.longitude = [objectDict valueForKey:@"longitude"];
		
		// Save the context.
		NSError *error;
		if (![context save:&error]) {
			// Handle the error...
		}
	}
	
	
	[[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:FALSE];
}


- (void)dealloc {
	[[NSNotificationCenter defaultCenter]removeObserver:self];
	
	[searchFetchedResultsController release];
	[_searchPredicate release];
	[_searchBar release];
	[_reverseOperationQueue release];
	[_group release];
	
    [super dealloc];
}


@end

