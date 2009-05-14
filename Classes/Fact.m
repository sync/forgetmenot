// 
//  Fact.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 8/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "Fact.h"

#import "FactType.h"
#import "Person.h"
#import "Keyword.h"

@implementation Fact 

@dynamic fact;
@dynamic id;
@dynamic fact_type;
@dynamic person;
@dynamic keyword;

+ (Fact *)factWithID:(NSString *)fact_id forContext:(NSManagedObjectContext *)context
{
	NSString *key = @"id";
	
	NSString *template = [NSString stringWithFormat: @"%@_with_%@",[self description],key];
    
	return (Fact *)[context
					fetchUniqueObjectWithTemplate: template
					parameters: mkdict({key,fact_id})];
}

@end
