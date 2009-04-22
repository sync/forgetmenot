//
//  BaseViewController.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 6/02/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "BaseViewController.h"
#import "SettingsController.h"


@implementation BaseViewController

@synthesize appDelegate=_appDelegate;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
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

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}


- (void)viewDidLoad 
{
	[super viewDidLoad];
	
	[self loadAppDelegate];
	
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1.0];
	self.navigationController.toolbar.tintColor = [UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1.0];
	
	[self setupNavigationBar];
	
	[self setupToolbar];
}

- (void)setupNavigationBar
{
	// Nothing
}

- (void)setupToolbar
{	
	// Nothing
}

- (IBAction)showSettings:(id)sender
{
	SettingsController *controller = [[SettingsController alloc]initWithNibName:@"SettingsController" bundle:nil];
	[self.navigationController presentModalViewController:controller animated:TRUE];
	[controller release];
}

- (IBAction)showMap:(id)sender
{
	
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)loadAppDelegate
{
	if (!self.appDelegate) {
		self.appDelegate = (ForgetMeNotAppDelegate *)[[UIApplication sharedApplication]delegate];
	}
}

- (void)restoreLevelWithSelectionArray:(NSArray *)selectionArray
{
	// nothing
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	//[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
   // Release anything that's not essential, such as cached data
}

//help executing a method when a notification fire
- (void)observeValueForKeyPath:(NSString *)keyPath
					  ofObject:(id)object 
						change:(NSDictionary *)change 
					   context:(void *)context
{
	[self performSelector: (SEL)context withObject: change];
}



- (void)dealloc {
	[_appDelegate release];
	
    [super dealloc];
}

@end
