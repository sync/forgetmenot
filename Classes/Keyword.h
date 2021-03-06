//
//  Keyword.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 8/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Fact;
@class FactType;

@interface Keyword :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSSet* fact;
@property (nonatomic, retain) FactType * fact_type;

+ (Keyword *)keywordWithID:(NSString *)keyword_id forContext:(NSManagedObjectContext *)context;
+ (Keyword *)keywordWithName:(NSString *)name forContext:(NSManagedObjectContext *)context;

@end


@interface Keyword (CoreDataGeneratedAccessors)
- (void)addFactObject:(Fact *)value;
- (void)removeFactObject:(Fact *)value;
- (void)addFact:(NSSet *)value;
- (void)removeFact:(NSSet *)value;

@end

