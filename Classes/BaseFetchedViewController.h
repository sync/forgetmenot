//
//  BaseFetchedViewController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 14/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface BaseFetchedViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>{
	NSFetchedResultsController *fetchedResultsController;
	
	UITableView *_tableView;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
