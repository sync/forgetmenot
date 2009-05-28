//
//  FactOneRowEditController.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 18/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "FactOneRowEditController.h"
#import "Person.h"
#import "FactType.h"
#import "KeywordView.h"

@implementation FactOneRowEditController

@synthesize person=_person;
@synthesize factType=_factType;
@synthesize scrollView=_scrollView;
@synthesize keywordView=_keywordView;
@synthesize createdTemporaryObject=_createdTemporaryObject;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	
	// create a fact
	if (!self.object) {
		// should state that this object has to be removed on cancel
		NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
		// Create a new instance of the entity managed by the fetched results controller.
		NSEntityDescription *entity = [NSEntityDescription entityForName:self.entityName inManagedObjectContext:context];
		self.object = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
		
		// Save the context.
		NSError *error;
		if (![context save:&error]) {
			// Handle the error...
		}
		
		self.createdTemporaryObject = TRUE;
	} else {
		self.createdTemporaryObject = FALSE;
	}
	self.keywordView.fact = (Fact *)self.object;
	
	[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(layoutSubviews:) name:ShouldLayoutFactOneLayoutController object:nil];
}

- (void)layoutSubviews:(id)sender
{
	// Check the height of the Keyword view
	CGFloat keywordHeightDiff = self.keywordView.frame.size.height - 42.0;
	
	// Move the deleteButton frame origin y
	self.deleteButton.frame = CGRectMake(self.deleteButton.frame.origin.x, 134.0 + 21.0 + keywordHeightDiff, self.deleteButton.frame.size.width, self.deleteButton.frame.size.height);
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
	[self.object setValue:self.factType forKey:@"fact_type"];
	
	self.keywordView.fact = (Fact *)self.object;
	
	[self.person addFactObject:(Fact *)self.object];
	
	// Save the context.
    NSError *error;
    if (![context save:&error]) {
		// Handle the error...
    }
	
	[[NSNotificationCenter defaultCenter] postNotificationName:self.notificationName object:nil];
	
    [self dismissModalViewControllerAnimated:TRUE];
}

- (IBAction)cancelEditing:(id)sender
{
	if (self.object && self.createdTemporaryObject) {
		// Remove
		NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
		[context deleteObject:self.object];
		
		// Save the context.
		NSError *error;
		if (![context save:&error]) {
			// Handle the error...
		}
	}
	
	
	[self dismissModalViewControllerAnimated:TRUE];
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
	[_factType release];
	[_person release];
	[_scrollView release];
	[_keywordView release];
	
    [super dealloc];
}


@end
