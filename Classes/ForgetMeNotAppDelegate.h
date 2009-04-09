//
//  ForgetMeNotAppDelegate.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 7/04/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

@interface ForgetMeNotAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

