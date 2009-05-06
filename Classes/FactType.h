//
//  FactType.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 6/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Fact;
@class Keyword;

@interface FactType :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSDate * upated_at;
@property (nonatomic, retain) NSNumber * priority;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * image_name;
@property (nonatomic, retain) NSSet* fact;
@property (nonatomic, retain) NSSet* keyword;

+ (FactType *)factTypeWithID:(NSString *)factType_id forContext:(NSManagedObjectContext *)context;

@end


@interface FactType (CoreDataGeneratedAccessors)
- (void)addFactObject:(Fact *)value;
- (void)removeFactObject:(Fact *)value;
- (void)addFact:(NSSet *)value;
- (void)removeFact:(NSSet *)value;

- (void)addKeywordObject:(Keyword *)value;
- (void)removeKeywordObject:(Keyword *)value;
- (void)addKeyword:(NSSet *)value;
- (void)removeKeyword:(NSSet *)value;

@end

