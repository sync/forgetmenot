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

- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSOperationQueue *queue =  [[NSOperationQueue alloc]init];
	queue.maxConcurrentOperationCount = 1;
	self.reverseOperationQueue = queue;
	[queue release];
	
	self.tableView.rowHeight = ROW_HEIGHT;
	
	// Reload tableview when this notifiation fire
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTableview:) name:ShouldReloadFriendsController object:nil];
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
		Person *person = (Person *)[self.appDelegate.managedObjectContext objectWithID:[info valueForKey:@"objectID"]];
		person.latitude = [info valueForKey:@"latitude"];
		person.longitude = [info valueForKey:@"longitude"];
	}
	
	
	[[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:FALSE];
}


- (void)dealloc {
	[[NSNotificationCenter defaultCenter]removeObserver:self];
	[_reverseOperationQueue release];
	[_group release];
	
    [super dealloc];
}


@end

