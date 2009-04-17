//
//  OneRowOneImageEditController.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 17/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "OneRowOneImageEditController.h"
#import "TouchImageView.h"

@implementation OneRowOneImageEditController

@synthesize imagePropertyName=_imagePropertyName;
@synthesize pickerViews=_pickerViews;
@synthesize pickerView=_pickerView;
@synthesize imageView=_imageView;

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
	
	self.pickerView = [NSMutableArray arrayWithCapacity:0];
	
	self.imageView.selector = @selector(showPicker:);
	self.imageView.target = self;
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
		title = @"color";
	}
	return title;
}

// tell the picker the width of each row for a given component (in our case we have one component)
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
	UIView *viewToUse = [self.pickerViews objectAtIndex:0];
	return viewToUse.bounds.size.width;
}

// tell the picker the height of each row for a given component (in our case we have one component)
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
	UIView *viewToUse = [self.pickerViews objectAtIndex:0];
	return viewToUse.bounds.size.height;
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
