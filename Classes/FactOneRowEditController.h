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

@interface FactOneRowEditController : OneRowEditController {
	Person *_person;
	FactType *_factType;
}

@property (nonatomic, retain) Person *person;
@property (nonatomic, retain) FactType *factType;

@end
