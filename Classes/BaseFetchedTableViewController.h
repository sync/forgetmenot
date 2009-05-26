//
//  BaseFetchedTableViewController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 19/03/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewController.h"

@interface BaseFetchedTableViewController : BaseTableViewController {
	NSFetchedResultsController *fetchedResultsController;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@end
