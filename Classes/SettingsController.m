//
//  PreferencesController.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 20/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "SettingsController.h"
#import "SettingsCell.h"
#import "SettingsFactTypesController.h"

@implementation SettingsController

@synthesize content=_content;
@synthesize navigationController=_navigationController;
@synthesize tableView=_tableView;

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.tableView.sectionHeaderHeight = 15.0;
	
	// Color of the navigation bar
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1.0];
	
	self.tableView.backgroundColor = [UIColor clearColor];
	
	[self.view addSubview:self.navigationController.view];
	
	NSArray *sectionOne = [NSArray arrayWithObjects:@"Fact Types", @"Your Infos", @"Something Here", nil];
//	NSArray *sectionTwo = [NSArray arrayWithObjects:@"Online Credentials", @"Online Mode", nil];
	
	self.content = [NSArray arrayWithObjects:sectionOne, nil];
	
	[self setupNavigationBar];
}

- (void)setupNavigationBar
{	
	// Let user add row
	UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
																		 target:self 
																		 action:@selector(doneSettings:)];
	self.navigationController.navigationBar.topItem.rightBarButtonItem = item;
	[item release];
	
	self.navigationItem.title = @"Groups";
}

- (IBAction)doneSettings:(id)sender
{
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


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.content count];
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.content objectAtIndex:section]count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger count = [[self.content objectAtIndex:indexPath.section]count];
    
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
	
	NSString *title = [[self.content objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	
	[cell setTitle:title];
	
	NSString *imageNamed = [[title stringByReplacingOccurrencesOfString:@" " withString:@"_"]lowercaseString];
	[cell setImage:[UIImage imageNamed:[imageNamed stringByAppendingString:@".png"]]];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *title = [[self.content objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
	
	if ([title isEqual:@"Fact Types"]) {
		SettingsFactTypesController *controller = [[SettingsFactTypesController alloc]initWithNibName:@"SettingsFactTypesController" bundle:nil];
		[self.navigationController pushViewController:controller animated:TRUE];
		[controller release];
	}
	[self.tableView deselectRowAtIndexPath:indexPath animated:TRUE];
	
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
	[_tableView release];
	[_navigationController release];
	[_content release];
	
    [super dealloc];
}


@end

