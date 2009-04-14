//
//  FriendDetails.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 14/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class Person;

@interface FriendDetailsController : BaseViewController {
	UITableView *_tableView;
	UIScrollView *_scrollView;
	
	Person *_person;
}

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) Person *person;

@end
