//
//  FactOneRowEditController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 18/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "OneRowEditController.h"

@class Person;
@class FactType;
@class KeywordView;

@interface FactOneRowEditController : OneRowEditController {
	Person *_person;
	FactType *_factType;
	UIScrollView *_scrollView;
	KeywordView *_keywordView;
}

@property (nonatomic, retain) Person *person;
@property (nonatomic, retain) FactType *factType;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet KeywordView *keywordView;

@end
