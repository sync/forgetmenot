//
//  ForgetMeNotAppDelegate.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 7/04/09.
//  Copyright Anthony Mittaz 2009. All rights reserved.
//

#import "ForgetMeNotAppDelegate.h"


@implementation ForgetMeNotAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize remoteHostStatus;
@synthesize internetConnectionStatus;
@synthesize localWiFiConnectionStatus;
@synthesize hasValidNetworkConnection=_hasValidNetworkConnection;
@synthesize noConnectionAlertShowing=_noConnectionAlertShowing;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];

	/*
	 You can use the Reachability class to check the reachability of a remote host
	 by specifying either the host's DNS name (www.apple.com) or by IP address.
	 */
	self.hasValidNetworkConnection = FALSE;
	self.noConnectionAlertShowing = FALSE;
	
	[[Reachability sharedReachability] setHostName:[self hostName]];
	[[Reachability sharedReachability] setNetworkStatusNotificationsEnabled:YES];
	[self updateStatus];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kNetworkReachabilityChangedNotification object:nil];
	
//	[[UIApplication sharedApplication] registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
	NSLog(@"deviceToken: %@", deviceToken); 
} 

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error 
{
    NSLog(@"Error in registration. Error: %@", error); 
}

- (void)alertNoNetworkConnection
{
	if (!self.noConnectionAlertShowing) {
		// open an alert with just an OK button
		self.noConnectionAlertShowing = TRUE;
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Network Found." message:@"Would you like to try again?"
													   delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
		[alert show];	
		[alert release];
	}	
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	self.noConnectionAlertShowing = FALSE;
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == 0)
	{
		DLog(@"Cancel");
		// Do nothing
	}
	else
	{
		DLog(@"OK");
		[self updateStatus];
	}
}

- (void)reachabilityChanged:(NSNotification *)note
{
    [self updateStatus];
}

- (void)updateStatus
{
	// Query the SystemConfiguration framework for the state of the device's network connections.
	self.remoteHostStatus           = [[Reachability sharedReachability] remoteHostStatus];
	self.internetConnectionStatus	= [[Reachability sharedReachability] internetConnectionStatus];
	self.localWiFiConnectionStatus	= [[Reachability sharedReachability] localWiFiConnectionStatus];
	
	if ((self.remoteHostStatus == ReachableViaWiFiNetwork) || (self.remoteHostStatus == ReachableViaCarrierDataNetwork))  {
		self.hasValidNetworkConnection = TRUE;
	} else {
		self.hasValidNetworkConnection = FALSE;
	}
	
	
}

- (BOOL)isCarrierDataNetworkActive
{
	return (self.remoteHostStatus == ReachableViaCarrierDataNetwork);
}

- (NSString *)hostName
{
	// Don't include a scheme. 'http://' will break the reachability checking.
	// Change this value to test the reachability of a different host.
	return @"www.realestate.com.au";
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSError *error;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			// Handle error.
			DLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);  // Fail
        } 
    }
}

#pragma mark -
#pragma mark Saving

/**
 Performs the save action for the application, which is to send the save:
 message to the application's managed object context.
 */
- (IBAction)saveAction:(id)sender {
	
    NSError *error;
    if (![[self managedObjectContext] save:&error]) {
		// Handle error
		DLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
    }
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"ForgetMeNot.sqlite"]];
	
	NSError *error;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        // Handle error
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's documents directory

/**
 Returns the path to the application's documents directory.
 */
- (NSString *)applicationDocumentsDirectory 
{
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

