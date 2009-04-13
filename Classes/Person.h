//
//  Person.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 13/04/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Fact;
@class Group;

@interface Person :  NSManagedObject  
{
}

@property (retain) NSString * address;
@property (retain) NSString * last_name;
@property (retain) NSDate * modified_at;
@property (retain) NSString * middle_names;
@property (retain) NSNumber * online_id;
@property (retain) NSString * country;
@property (retain) NSNumber * latitude;
@property (retain) NSString * image_url;
@property (retain) NSString * post_code;
@property (retain) NSNumber * recordID;
@property (retain) NSString * first_name;
@property (retain) NSString * city;
@property (retain) NSDate * birthday;
@property (retain) NSDate * created_at;
@property (retain) NSNumber * longitude;
@property (retain) NSString * id;
@property (retain) NSSet* fact;
@property (retain) NSSet* group;

@end

@interface Person (CoreDataGeneratedAccessors)
- (void)addFactObject:(Fact *)value;
- (void)removeFactObject:(Fact *)value;
- (void)addFact:(NSSet *)value;
- (void)removeFact:(NSSet *)value;

- (void)addGroupObject:(Group *)value;
- (void)removeGroupObject:(Group *)value;
- (void)addGroup:(NSSet *)value;
- (void)removeGroup:(NSSet *)value;

@end

