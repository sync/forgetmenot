//
//  Person.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 14/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Fact;
@class Group;

@interface Person :  NSManagedObject  
{
}

@property (retain) NSString * street;
@property (retain) NSString * state;
@property (retain) NSString * last_name;
@property (retain) NSDate * modified_at;
@property (retain) NSString * middle_names;
@property (retain) NSString * country;
@property (retain) NSNumber * latitude;
@property (retain) NSString * image_url;
@property (retain) NSString *local_image_url;
@property (retain) NSNumber * recordID;
@property (retain) NSString * post_code;
@property (retain) NSDate * birthday;
@property (retain) NSString * first_name;
@property (retain) NSString * city;
@property (retain) NSDate * created_at;
@property (retain) NSNumber * longitude;
@property (retain) NSString * id;
@property (retain) NSSet* fact;
@property (retain) Group * group;

@property (retain, readonly) NSString *fullName;
@property (retain, readonly) NSString *fullAddress;
@property (retain, readonly) NSString *partialAddress;

+ (Person *)personWithID:(NSString *)person_id forContext:(NSManagedObjectContext *)context;
+ (Person *)personWithRecordID:(NSNumber *)recordID forContext:(NSManagedObjectContext *)context;

- (NSString *)applicationDocumentsDirectory;

@end

@interface Person (CoreDataGeneratedAccessors)
- (void)addFactObject:(Fact *)value;
- (void)removeFactObject:(Fact *)value;
- (void)addFact:(NSSet *)value;
- (void)removeFact:(NSSet *)value;

@end

