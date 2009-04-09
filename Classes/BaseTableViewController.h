//
//  BaseTableViewController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 5/02/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>{
	ForgetMeNotAppDelegate *_appDelegate;
}


@property (nonatomic, retain) ForgetMeNotAppDelegate *appDelegate;

- (void)loadAppDelegate;

- (void)restoreLevelWithSelectionArray:(NSArray *)selectionArray;

@end
