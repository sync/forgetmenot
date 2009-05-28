//
//  MapController.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 26/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "MapController.h"
#import <MapKit/MapKit.h>
#import "FriendPinAnnotation.h"
#import "Person.h"
#import "FriendDetailsController.h"


@implementation MapController

@synthesize mapView=_mapView;
@synthesize selectedIndex=_selectedIndex;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.mapView.showsUserLocation = TRUE;
	
	self.selectedIndex = -1;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	if (self.mapView.annotations) {
		[self updateAnnotations];
	} else {
		[self addAnnotations];
	}
	
	// here we should update the annotation dict
}

- (void)updateAnnotations
{	
	// remove all
	[self.mapView removeAnnotations:self.mapView.annotations];
	
	self.mapView.showsUserLocation = TRUE;
	
	// add the all
	[self addAnnotations];
}

- (void)addAnnotations
{
	// Fetch all friends
	// Create the fetch request for the entity.
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	// Edit the entity name as appropriate.
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.appDelegate.managedObjectContext];
	[fetchRequest setEntity:entity];
	
	// Edit the sort key as appropriate.
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"last_name" ascending:YES];
	NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
	[sortDescriptor release];
	
	[fetchRequest setSortDescriptors:sortDescriptors];
	[sortDescriptors release];
	
	NSArray *friends = [self.appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:NULL];
	[fetchRequest release];
	
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	for (Person *person in friends) {
		if (person.latitude && person.longitude) {
			CLLocationCoordinate2D coordinate;
			coordinate.latitude = [person.latitude doubleValue];
			coordinate.longitude = [person.longitude doubleValue];
			
			FriendPinAnnotation *annotation = [[FriendPinAnnotation alloc]initWithCoordinate:coordinate];
			annotation.objectID = person.objectID;
			annotation.title = person.fullName;
			// check if brithday
			if (person.birthday) {
				annotation.subtitle = [dateFormatter stringFromDate:person.birthday];
			}
			[self.mapView addAnnotation:annotation];
			[annotation release];
		}
	}
	[dateFormatter release];	
}

- (void)setupNavigationBar
{
	// previous
	UIBarButtonItem *previousItem = [[UIBarButtonItem alloc]initWithTitle:@"Previous"
																   style:UIBarButtonItemStylePlain 
																  target:self
																   action:@selector(goPrevious:)];
	self.navigationItem.leftBarButtonItem = previousItem;
	[previousItem release];
	
	// next
	UIBarButtonItem *nextItem = [[UIBarButtonItem alloc]initWithTitle:@"Next"
																   style:UIBarButtonItemStylePlain 
																  target:self
																   action:@selector(goNext:)];
	self.navigationItem.rightBarButtonItem = nextItem;
	[nextItem release];
	
	[self.navigationItem.leftBarButtonItem setEnabled:FALSE];
	[self.navigationItem.rightBarButtonItem setEnabled:TRUE];
	
	self.navigationItem.title = @"Map";
}

- (IBAction)goNext:(id)sender
{
	NSInteger nextIndex = self.selectedIndex + 1;
	if ([self.mapView.annotations count] > nextIndex) {
		FriendPinAnnotation *annotation = [self.mapView.annotations objectAtIndex:nextIndex];
		[self.mapView setRegion:MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1520.0, 1520.0) animated:TRUE];
		[self.mapView selectAnnotation:annotation animated:TRUE];
		self.selectedIndex += 1;
	}
	if (self.selectedIndex == 0) {
		[self.navigationItem.leftBarButtonItem setEnabled:FALSE];
		[self.navigationItem.rightBarButtonItem setEnabled:TRUE];
	} else if (self.selectedIndex == [self.mapView.annotations count]-1) {
		[self.navigationItem.leftBarButtonItem setEnabled:TRUE];
		[self.navigationItem.rightBarButtonItem setEnabled:FALSE];
	} else {
		[self.navigationItem.leftBarButtonItem setEnabled:TRUE];
		[self.navigationItem.rightBarButtonItem setEnabled:TRUE];
	}
}

- (IBAction)goPrevious:(id)sender
{
	NSInteger previousIndex = self.selectedIndex - 1;
	if (previousIndex >= 0 && [self.mapView.annotations count] > previousIndex) {
		FriendPinAnnotation *annotation = [self.mapView.annotations objectAtIndex:previousIndex];
		[self.mapView setRegion:MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1520.0, 1520.0) animated:TRUE];
		[self.mapView selectAnnotation:annotation animated:TRUE];
		self.selectedIndex -= 1;
	}
	if (self.selectedIndex == 0) {
		[self.navigationItem.leftBarButtonItem setEnabled:FALSE];
		[self.navigationItem.rightBarButtonItem setEnabled:TRUE];
	} else if (self.selectedIndex == [self.mapView.annotations count]-1) {
		[self.navigationItem.leftBarButtonItem setEnabled:TRUE];
		[self.navigationItem.rightBarButtonItem setEnabled:FALSE];
	} else {
		[self.navigationItem.leftBarButtonItem setEnabled:TRUE];
		[self.navigationItem.rightBarButtonItem setEnabled:TRUE];
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
	UIBarButtonItem *leftFlexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																			  target:nil
																			  action:nil];
	
	// previous
	UIBarButtonItem *currentItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"toolbar_current_location.png"]
																   style:UIBarButtonItemStyleBordered 
																  target:self
																   action:@selector(showCurrentLocation:)];
	// increase the size of the button
	currentItem.width = 50.0;
	
	UIBarButtonItem *rightFlexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
																				  target:nil
																				  action:nil];
	
	
	// create a special tab bar item with a custom image and title
	UIBarButtonItem *mapItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"toolbar_friends.png"]
																style:UIBarButtonItemStylePlain
															   target:self
															   action:@selector(showFriends:)];
	
	NSArray *items = [NSArray arrayWithObjects:settingsItem, leftFlexItem, currentItem, rightFlexItem, mapItem, nil];
	[self setToolbarItems:items animated:FALSE];
	[settingsItem release];
	[currentItem release];
	[leftFlexItem release];
	[rightFlexItem release];
	[mapItem release];
}

- (IBAction)showCurrentLocation:(id)sender
{
	
	CLLocation *location = self.mapView.userLocation.location;
	if (!location && self.mapView.userLocation.updating) {
		[self performSelector:@selector(showCurrentLocation:) withObject:sender afterDelay:0.5];
	} else {
		if (!self.mapView.showsUserLocation) {
			self.mapView.showsUserLocation = TRUE;
			[self performSelector:@selector(showCurrentLocation:) withObject:sender afterDelay:0.5];
		} else {
			// zoom to current location
			[self.mapView setRegion:MKCoordinateRegionMakeWithDistance(location.coordinate, 1520.0, 1520.0) animated:TRUE];
		}
	}
}

- (void)mapViewWillStartLoadingMap:(MKMapView *)mapView
{
	[[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:TRUE];
}

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView
{
	[[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:FALSE];
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)mapView withError:(NSError *)error
{
	[[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:FALSE];
}



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	if ([annotation respondsToSelector:@selector(objectID)]) {
		static NSString *defaultPinID = @"DefaultPinID";
		
		MKPinAnnotationView *mkav = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		if (mkav == nil) {
			mkav = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
			mkav.canShowCallout = TRUE;
			mkav.pinColor = MKPinAnnotationColorPurple;
			UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			mkav.rightCalloutAccessoryView = button;
		}
		
		return mkav;
	}
	return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
	FriendPinAnnotation *annotation = (FriendPinAnnotation *)view.annotation;
	
	if ([annotation respondsToSelector:@selector(objectID)] && annotation.objectID) {
		NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
		Person *person = (Person *)[context objectWithID:annotation.objectID];
		
		FriendDetailsController *controller = [[FriendDetailsController alloc] initWithNibName:@"FriendDetailsController" bundle:nil];
		controller.person = person;
		[self.navigationController pushViewController:controller animated:TRUE];
		[controller release];
	}
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[_mapView release];
	
    [super dealloc];
}


@end
