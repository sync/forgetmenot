//
//  Fact.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 13/04/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Person;
@class FactType;

@interface Fact :  NSManagedObject  
{
}

@property (retain) NSNumber * online_id;
@property (retain) NSString * fact;
@property (retain) NSString * id;
@property (retain) Person * person;
@property (retain) FactType * fact_type;

- (NSString *) getId;
- (NSString *) getObjectIdString;

@end


