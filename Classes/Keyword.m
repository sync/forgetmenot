// 
//  Keyword.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 6/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "Keyword.h"

#import "Fact.h"

@implementation Keyword 

@dynamic created_at;
@dynamic name;
@dynamic updated_at;
@dynamic id;
@dynamic fact;

#pragma mark -
#pragma mark Retrieve a person from it's id

+ (Keyword *)keywordWithID:(NSString *)keyword_id forContext:(NSManagedObjectContext *)context
{
	NSString *key = @"id";
	
	NSString *template = [NSString stringWithFormat: @"%@_with_%@",[self description],key];
    
	return (Keyword *)[context
					fetchUniqueObjectWithTemplate: template
					parameters: mkdict({key,fact_id})];
}

@end
