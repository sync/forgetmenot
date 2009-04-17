//
//  FriendDetails.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 14/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseFetchedViewController.h"

@class TitleImageCellView;
@class Person;

@interface FriendDetailsController : BaseFetchedViewController <UIScrollViewDelegate>{
	TitleImageCellView *_personView;
	UIScrollView *_scrollView;
	
	Person *_person;
	NSInteger _selectItemIndex;
	
	NSArray *_factTypes;
}

@property (nonatomic, retain) IBOutlet TitleImageCellView *personView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) Person *person;
@property (nonatomic) NSInteger selectItemIndex;
@property (nonatomic, retain) NSArray *factTypes;

- (void)loadFactTypes;
- (IBAction)addNewFactType:(id)sender;

- (IBAction)addNewFact:(id)sender;

- (void)selectedItemIndexChanged:(id)sender;

@end
