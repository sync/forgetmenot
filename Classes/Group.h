//
//  Group.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 13/04/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Person;

@interface Group :  NSManagedObject  
{
}

@property (retain) NSString * name;
@property (retain) NSDate * updated_at;
@property (retain) NSDate * created_at;
@property (retain) NSNumber * online_id;
@property (retain) NSString * id;
@property (retain) NSString * color;
@property (retain) NSSet* person_id;

@end

@interface Group (CoreDataGeneratedAccessors)
- (void)addPerson_idObject:(Person *)value;
- (void)removePerson_idObject:(Person *)value;
- (void)addPerson_id:(NSSet *)value;
- (void)removePerson_id:(NSSet *)value;

@end

