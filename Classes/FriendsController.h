//
//  FriendsController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 9/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseFetchedTableViewController.h"

@class Group;

@interface FriendsController : BaseFetchedTableViewController {
	Group *_group;
}

@property (nonatomic, retain) Group *group;

@end
