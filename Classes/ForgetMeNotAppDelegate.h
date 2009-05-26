//
//  ForgetMeNotAppDelegate.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 7/04/09.
//  Copyright Anthony Mittaz 2009. All rights reserved.
//

// Remote status
#import "Reachability.h"

@class MyLocationGetter;

@interface ForgetMeNotAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	
	NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
	NetworkStatus remoteHostStatus;
	NetworkStatus internetConnectionStatus;
	NetworkStatus localWiFiConnectionStatus;
	
	BOOL _hasValidNetworkConnection;
	BOOL _noConnectionAlertShowing;
	
	MyLocationGetter *_locationGetter;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property BOOL noConnectionAlertShowing;
@property BOOL hasValidNetworkConnection;

@property NetworkStatus remoteHostStatus;
@property NetworkStatus internetConnectionStatus;
@property NetworkStatus localWiFiConnectionStatus;

@property (nonatomic, readonly) MyLocationGetter *locationGetter;

- (IBAction)saveAction:sender;
- (NSString *)applicationDocumentsDirectory;

- (void)updateStatus;
- (BOOL)isCarrierDataNetworkActive;
- (NSString *)hostName;

- (void)alertNoNetworkConnection;

@end

