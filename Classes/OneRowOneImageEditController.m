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
	
	OneImagePickerItem *chatItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	chatItem.title = @"Chat";
	chatItem.image = [UIImage imageNamed:@"chat_icon_black.png"];
	chatItem.imageNameToSet = @"chat_icon.png";
	[self.pickerViews addObject:chatItem];
	[chatItem release];
	
	OneImagePickerItem *findItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	findItem.title = @"Find";
	findItem.image = [UIImage imageNamed:@"find_icon_black.png"];
	findItem.imageNameToSet = @"find_icon.png";
	[self.pickerViews addObject:findItem];
	[findItem release];
	
	OneImagePickerItem *linkItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	linkItem.title = @"Link";
	linkItem.image = [UIImage imageNamed:@"link_icon_black.png"];
	linkItem.imageNameToSet = @"link_icon.png";
	[self.pickerViews addObject:linkItem];
	[linkItem release];
	
	OneImagePickerItem *pinItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	pinItem.title = @"Pin";
	pinItem.image = [UIImage imageNamed:@"pin_icon_black.png"];
	pinItem.imageNameToSet = @"pin_icon.png";
	[self.pickerViews addObject:pinItem];
	[pinItem release];
	
	OneImagePickerItem *treeItem = [[OneImagePickerItem alloc] initWithFrame:CGRectZero];
	treeItem.title = @"Tree";
	treeItem.image = [UIImage imageNamed:@"tree_icon_black.png"];
	treeItem.imageNameToSet = @"tree_icon.png";
	[self.pickerViews addObject:treeItem];
	[treeItem release];
	
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
	NSUInteger numRows;
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
	NSString *title;
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
