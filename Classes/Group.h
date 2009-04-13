//
//  Group.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 13/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
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
@property (retain) NSSet* person;

+ (Group *)groupWidthID:(NSString *)group_id forContext:(NSManagedObjectContext *)context;

- (NSString *) getId;
- (NSString *) getObjectIdString;

@end

@interface Group (CoreDataGeneratedAccessors)
- (void)addPersonObject:(Person *)value;
- (void)removePersonObject:(Person *)value;
- (void)addPerson:(NSSet *)value;
- (void)removePerson:(NSSet *)value;

@end

