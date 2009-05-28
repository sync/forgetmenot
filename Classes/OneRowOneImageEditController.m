//
//  OneRowOneImageEditController.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 17/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "OneRowOneImageEditController.h"
#import "TouchImageView.h"
#import "OneImagePickerItem.h"

@implementation OneRowOneImageEditController

@synthesize imagePropertyName=_imagePropertyName;
@synthesize pickerViews=_pickerViews;
@synthesize pickerView=_pickerView;
@synthesize imageView=_imageView;
@synthesize priority=_priority;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
		self.priority = -1;
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.pickerViews = [NSMutableArray arrayWithCapacity:0];
	
	OneImagePickerItem *agrapheItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	agrapheItem.title = @"Agraphe";
	agrapheItem.image = [UIImage imageNamed:@"agraphe_icon_black.png"];
	agrapheItem.imageNameToSet = @"agraphe_icon.png";
	[self.pickerViews addObject:agrapheItem];
	[agrapheItem release];
	
	OneImagePickerItem *agreementItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	agreementItem.title = @"Agreement";
	agreementItem.image = [UIImage imageNamed:@"agreement_icon_black.png"];
	agreementItem.imageNameToSet = @"agreement_icon.png";
	[self.pickerViews addObject:agreementItem];
	[agreementItem release];
	
	OneImagePickerItem *basketItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	basketItem.title = @"Basket";
	basketItem.image = [UIImage imageNamed:@"basket_icon_black.png"];
	basketItem.imageNameToSet = @"basket_icon.png";
	[self.pickerViews addObject:basketItem];
	[basketItem release];
	
	OneImagePickerItem *binocularItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	binocularItem.title = @"Binocular";
	binocularItem.image = [UIImage imageNamed:@"binocular_icon_black.png"];
	binocularItem.imageNameToSet = @"binocular_icon.png";
	[self.pickerViews addObject:binocularItem];
	[binocularItem release];
	
	OneImagePickerItem *cabItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	cabItem.title = @"Cab";
	cabItem.image = [UIImage imageNamed:@"cab_icon_black.png"];
	cabItem.imageNameToSet = @"cab_icon.png";
	[self.pickerViews addObject:cabItem];
	[cabItem release];
	
	OneImagePickerItem *calculatorItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	calculatorItem.title = @"Calculator";
	calculatorItem.image = [UIImage imageNamed:@"calculator_icon_black.png"];
	calculatorItem.imageNameToSet = @"calculator_icon.png";
	[self.pickerViews addObject:calculatorItem];
	[calculatorItem release];
	
	OneImagePickerItem *chatItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	chatItem.title = @"Chat";
	chatItem.image = [UIImage imageNamed:@"chat_icon_black.png"];
	chatItem.imageNameToSet = @"chat_icon.png";
	[self.pickerViews addObject:chatItem];
	[chatItem release];
	
	OneImagePickerItem *contractItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	contractItem.title = @"Contact";
	contractItem.image = [UIImage imageNamed:@"contact_icon_black.png"];
	contractItem.imageNameToSet = @"contact_icon.png";
	[self.pickerViews addObject:contractItem];
	[contractItem release];
	
	OneImagePickerItem *dateItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	dateItem.title = @"Date";
	dateItem.image = [UIImage imageNamed:@"date_icon_black.png"];
	dateItem.imageNameToSet = @"date_icon.png";
	[self.pickerViews addObject:dateItem];
	[dateItem release];
	
	OneImagePickerItem *diplomaItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	diplomaItem.title = @"Diploma";
	diplomaItem.image = [UIImage imageNamed:@"diploma_icon_black.png"];
	diplomaItem.imageNameToSet = @"diploma_icon.png";
	[self.pickerViews addObject:diplomaItem];
	[diplomaItem release];
	
	OneImagePickerItem *favoriteItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	favoriteItem.title = @"Favorite";
	favoriteItem.image = [UIImage imageNamed:@"favorite_icon_black.png"];
	favoriteItem.imageNameToSet = @"favorite_icon.png";
	[self.pickerViews addObject:favoriteItem];
	[favoriteItem release];
	
	OneImagePickerItem *findItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	findItem.title = @"Find";
	findItem.image = [UIImage imageNamed:@"find_icon_black.png"];
	findItem.imageNameToSet = @"find_icon.png";
	[self.pickerViews addObject:findItem];
	[findItem release];
	
	OneImagePickerItem *fontItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	fontItem.title = @"Font";
	fontItem.image = [UIImage imageNamed:@"font_icon_black.png"];
	fontItem.imageNameToSet = @"font_icon.png";
	[self.pickerViews addObject:fontItem];
	[fontItem release];
	
	OneImagePickerItem *gpsItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	gpsItem.title = @"Gps";
	gpsItem.image = [UIImage imageNamed:@"gps_icon_black.png"];
	gpsItem.imageNameToSet = @"gps_icon.png";
	[self.pickerViews addObject:gpsItem];
	[gpsItem release];
	
	OneImagePickerItem *graphItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	graphItem.title = @"Graph";
	graphItem.image = [UIImage imageNamed:@"graph_icon_black.png"];
	graphItem.imageNameToSet = @"graph_icon.png";
	[self.pickerViews addObject:graphItem];
	[graphItem release];
	
	OneImagePickerItem *handcuffItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	handcuffItem.title = @"Handcuff";
	handcuffItem.image = [UIImage imageNamed:@"handcuff_icon_black.png"];
	handcuffItem.imageNameToSet = @"handcuff_icon.png";
	[self.pickerViews addObject:handcuffItem];
	[handcuffItem release];
	
	OneImagePickerItem *ideaItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	ideaItem.title = @"Idea";
	ideaItem.image = [UIImage imageNamed:@"idea_icon_black.png"];
	ideaItem.imageNameToSet = @"idea_icon.png";
	[self.pickerViews addObject:ideaItem];
	[ideaItem release];
	
	OneImagePickerItem *internetItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	internetItem.title = @"Internet";
	internetItem.image = [UIImage imageNamed:@"internet_icon_black.png"];
	internetItem.imageNameToSet = @"internet_icon.png";
	[self.pickerViews addObject:internetItem];
	[internetItem release];
	
	OneImagePickerItem *keyItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	keyItem.title = @"Key";
	keyItem.image = [UIImage imageNamed:@"key_icon_black.png"];
	keyItem.imageNameToSet = @"key_icon.png";
	[self.pickerViews addObject:keyItem];
	[keyItem release];
	
	OneImagePickerItem *lawItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	lawItem.title = @"Law";
	lawItem.image = [UIImage imageNamed:@"law_icon_black.png"];
	lawItem.imageNameToSet = @"law_icon.png";
	[self.pickerViews addObject:lawItem];
	[lawItem release];
	
	OneImagePickerItem *linkItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	linkItem.title = @"Link";
	linkItem.image = [UIImage imageNamed:@"link_icon_black.png"];
	linkItem.imageNameToSet = @"link_icon.png";
	[self.pickerViews addObject:linkItem];
	[linkItem release];
	
	OneImagePickerItem *medalItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	medalItem.title = @"Medal";
	medalItem.image = [UIImage imageNamed:@"medal_icon_black.png"];
	medalItem.imageNameToSet = @"medal_icon.png";
	[self.pickerViews addObject:medalItem];
	[medalItem release];
	
	OneImagePickerItem *moneyItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	moneyItem.title = @"Money";
	moneyItem.image = [UIImage imageNamed:@"money_icon_black.png"];
	moneyItem.imageNameToSet = @"money_icon.png";
	[self.pickerViews addObject:moneyItem];
	[moneyItem release];
	
	OneImagePickerItem *movieItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	movieItem.title = @"Movie";
	movieItem.image = [UIImage imageNamed:@"movie_icon_black.png"];
	movieItem.imageNameToSet = @"movie_icon.png";
	[self.pickerViews addObject:movieItem];
	[movieItem release];
	
	OneImagePickerItem *museumItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	museumItem.title = @"Museum";
	museumItem.image = [UIImage imageNamed:@"museum_icon_black.png"];
	museumItem.imageNameToSet = @"museum_icon.png";
	[self.pickerViews addObject:museumItem];
	[museumItem release];
	
	OneImagePickerItem *musicItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	musicItem.title = @"Music";
	musicItem.image = [UIImage imageNamed:@"music_icon_black.png"];
	musicItem.imageNameToSet = @"music_icon.png";
	[self.pickerViews addObject:musicItem];
	[musicItem release];
	
	OneImagePickerItem *phoneItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	phoneItem.title = @"Phone";
	phoneItem.image = [UIImage imageNamed:@"phone_icon_black.png"];
	phoneItem.imageNameToSet = @"phone_icon.png";
	[self.pickerViews addObject:phoneItem];
	[phoneItem release];
	
	OneImagePickerItem *pinItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	pinItem.title = @"Pin";
	pinItem.image = [UIImage imageNamed:@"pin_icon_black.png"];
	pinItem.imageNameToSet = @"pin_icon.png";
	[self.pickerViews addObject:pinItem];
	[pinItem release];
	
	OneImagePickerItem *policeItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	policeItem.title = @"Police";
	policeItem.image = [UIImage imageNamed:@"police_icon_black.png"];
	policeItem.imageNameToSet = @"police_icon.png";
	[self.pickerViews addObject:policeItem];
	[policeItem release];
	
	OneImagePickerItem *rentingItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	rentingItem.title = @"Renting";
	rentingItem.image = [UIImage imageNamed:@"renting_icon_black.png"];
	rentingItem.imageNameToSet = @"renting_icon.png";
	[self.pickerViews addObject:rentingItem];
	[rentingItem release];
	
	OneImagePickerItem *reportItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	reportItem.title = @"Report";
	reportItem.image = [UIImage imageNamed:@"report_icon_black.png"];
	reportItem.imageNameToSet = @"report_icon.png";
	[self.pickerViews addObject:reportItem];
	[reportItem release];
	
	OneImagePickerItem *runningItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	runningItem.title = @"Running";
	runningItem.image = [UIImage imageNamed:@"running_icon_black.png"];
	runningItem.imageNameToSet = @"running_icon.png";
	[self.pickerViews addObject:runningItem];
	[runningItem release];
	
	OneImagePickerItem *screenItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	screenItem.title = @"Screen";
	screenItem.image = [UIImage imageNamed:@"screen_icon_black.png"];
	screenItem.imageNameToSet = @"screen_icon.png";
	[self.pickerViews addObject:screenItem];
	[screenItem release];
	
	OneImagePickerItem *shieldItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	shieldItem.title = @"Shield";
	shieldItem.image = [UIImage imageNamed:@"shield_icon_black.png"];
	shieldItem.imageNameToSet = @"shield_icon.png";
	[self.pickerViews addObject:shieldItem];
	[shieldItem release];
	
	OneImagePickerItem *stripsItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	stripsItem.title = @"Strips";
	stripsItem.image = [UIImage imageNamed:@"strips_icon_black.png"];
	stripsItem.imageNameToSet = @"strips_icon.png";
	[self.pickerViews addObject:stripsItem];
	[stripsItem release];
	
	OneImagePickerItem *suitcaseItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	suitcaseItem.title = @"Suitcase";
	suitcaseItem.image = [UIImage imageNamed:@"suitcase_icon_black.png"];
	suitcaseItem.imageNameToSet = @"suitcase_icon.png";
	[self.pickerViews addObject:suitcaseItem];
	[suitcaseItem release];
	
	OneImagePickerItem *swimmingItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	swimmingItem.title = @"Swimming";
	swimmingItem.image = [UIImage imageNamed:@"swimming_icon_black.png"];
	swimmingItem.imageNameToSet = @"swimming_icon.png";
	[self.pickerViews addObject:swimmingItem];
	[swimmingItem release];
	
	OneImagePickerItem *travelItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	travelItem.title = @"Travel";
	travelItem.image = [UIImage imageNamed:@"travel_icon_black.png"];
	travelItem.imageNameToSet = @"travel_icon.png";
	[self.pickerViews addObject:travelItem];
	[travelItem release];
	
	OneImagePickerItem *treeItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	treeItem.title = @"Tree";
	treeItem.image = [UIImage imageNamed:@"tree_icon_black.png"];
	treeItem.imageNameToSet = @"tree_icon.png";
	[self.pickerViews addObject:treeItem];
	[treeItem release];
	
	OneImagePickerItem *writingItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	writingItem.title = @"Writing";
	writingItem.image = [UIImage imageNamed:@"writing_icon_black.png"];
	writingItem.imageNameToSet = @"writing_icon.png";
	[self.pickerViews addObject:writingItem];
	[writingItem release];
	
	self.imageView.selector = @selector(showPicker:);
	self.imageView.target = self;
	
	// Check if object was given
	if (self.object) {
		self.imageView.image = [UIImage imageNamed:[self.object valueForKey:self.imagePropertyName]];
		// Get the index of the image
		NSInteger index = 0;
		for (OneImagePickerItem *item in self.pickerViews) {
			if ([item.imageNameToSet isEqualToString:[self.object valueForKey:self.imagePropertyName]]) {
				break;
			}
			index++;
		}
		// Set the picker selected index
		[self.pickerView selectRow:index inComponent:0 animated:FALSE];
	} else {
		OneImagePickerItem *firstItem = [self.pickerViews objectAtIndex:0];
		self.imageView.image = [UIImage imageNamed:firstItem.imageNameToSet];
	}
}

- (IBAction)doneEditing:(id)sender
{
	// Get Mangaged object context
	NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
	
	// Check if object was not given
	if (!self.object) {
		// Create a new instance of the entity managed by the fetched results controller.
		NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityName inManagedObjectContext:context];
		self.object = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
	}
	[self.object setValue:self.textField.text forKey:self.propertyName];
	
	OneImagePickerItem *selectedItem = [self.pickerViews objectAtIndex:[self.pickerView selectedRowInComponent:0]];
	[self.object setValue:selectedItem.imageNameToSet forKey:self.imagePropertyName];
	
	// Set priority
	if (self.priority != -1) {
		[self.object setValue:[NSNumber numberWithInteger:self.priority] forKey:@"priority"];
	}
	
	// Save the context.
    NSError *error;
    if (![context save:&error]) {
		// Handle the error...
    }
	
	[[NSNotificationCenter defaultCenter] postNotificationName:self.notificationName object:nil];
	
    [self dismissModalViewControllerAnimated:TRUE];
}

- (IBAction)showPicker:(id)sender
{
	[self.textField resignFirstResponder];
}

#pragma mark TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[self showPicker:self];
	return TRUE;
}

#pragma mark UIPicker datasource methods

// tell the picker how many components it will have (in our case we have one component)
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

// tell the picker how many rows are available for a given component (in our case we have one component)
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	NSUInteger numRows = 0;
	if (component == 0)
	{
		numRows = (NSUInteger)[self.pickerViews count];
	}
	return numRows;
}

#pragma mark UIPicker delegate methods

// tell the picker which view to use for a given component and row, we have an array of color views to show
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
		  forComponent:(NSInteger)component reusingView:(UIView *)view
{
	UIView *viewToUse = nil;
	if (component == 0)
	{
		viewToUse = [self.pickerViews objectAtIndex:row];
	}
	return viewToUse;
}



// tell the picker the title for a given component (in our case we have one component)
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSString *title = nil;
	if (component == 0)
	{
		title = @"icon";
	}
	return title;
}

// tell the picker the width of each row for a given component (in our case we have one component)
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	OneImagePickerItem *viewToUse = [self.pickerViews objectAtIndex:0];
	return viewToUse.bounds.size.width;
}

// tell the picker the height of each row for a given component (in our case we have one component)
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	OneImagePickerItem *viewToUse = [self.pickerViews objectAtIndex:0];
	return viewToUse.bounds.size.height;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	OneImagePickerItem *viewToUse = nil;
	if (component == 0)
	{
		viewToUse = [self.pickerViews objectAtIndex:row];
		NSString *imageName = viewToUse.imageNameToSet;
		self.imageView.image = [UIImage imageNamed:imageName];
		
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
	[[NSNotificationCenter defaultCenter]removeObserver:self];
	
	[_pickerViews release];
	[_imageView release];
	[_pickerView release];
	[_imagePropertyName release];
	
    [super dealloc];
}


@end
