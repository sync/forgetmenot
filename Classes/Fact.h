//
//  Fact.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 6/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Person;
@class FactType;

@interface Fact :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * fact;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) Person * person;
@property (nonatomic, retain) FactType * fact_type;
@property (nonatomic, retain) NSSet* keyword;

+ (Fact *)factWithID:(NSString *)fact_id forContext:(NSManagedObjectContext *)context;

@end


@interface Fact (CoreDataGeneratedAccessors)
- (void)addKeywordObject:(NSManagedObject *)value;
- (void)removeKeywordObject:(NSManagedObject *)value;
- (void)addKeyword:(NSSet *)value;
- (void)removeKeyword:(NSSet *)value;

@end

