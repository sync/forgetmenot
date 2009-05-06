//
//  Keyword.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 6/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Fact;

@interface Keyword :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) Fact * fact;

+ (Keyword *)keywordWithID:(NSString *)keyword_id forContext:(NSManagedObjectContext *)context;

@end



