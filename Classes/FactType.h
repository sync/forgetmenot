//
//  FactType.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 13/04/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Fact;

@interface FactType :  NSManagedObject  
{
}

@property (retain) NSString * name;
@property (retain) NSDate * created_at;
@property (retain) NSNumber * online_id;
@property (retain) NSDate * upated_at;
@property (retain) NSNumber * priority;
@property (retain) NSString * id;
@property (retain) NSSet* fact;

- (NSString *) getId;
- (NSString *) getObjectIdString;

@end

@interface FactType (CoreDataGeneratedAccessors)
- (void)addFactObject:(Fact *)value;
- (void)removeFactObject:(Fact *)value;
- (void)addFact:(NSSet *)value;
- (void)removeFact:(NSSet *)value;

@end
