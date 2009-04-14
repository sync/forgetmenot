//
//  FriendDetails.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 14/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseFetchedViewController.h"

@class Person;

@interface FriendDetailsController : BaseFetchedViewController {
	
	UIScrollView *_scrollView;
	
	Person *_person;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) Person *person;

@end
