// 
//  Keyword.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 8/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "Keyword.h"

#import "Fact.h"
#import "FactType.h"

@implementation Keyword 

@dynamic created_at;
@dynamic name;
@dynamic updated_at;
@dynamic id;
@dynamic fact;
@dynamic fact_type;

+ (Keyword *)keywordWithID:(NSString *)keyword_id forContext:(NSManagedObjectContext *)context
{
	NSString *key = @"id";
	
	NSString *template = [NSString stringWithFormat: @"%@_with_%@",[self description],key];
    
	return (Keyword *)[context
					   fetchUniqueObjectWithTemplate: template
					   parameters: mkdict({key,keyword_id})];
}

+ (Keyword *)keywordWithName:(NSString *)name forContext:(NSManagedObjectContext *)context
{
	NSString *key = @"name";
	
	NSString *template = [NSString stringWithFormat: @"%@_with_%@",[self description],key];
    
	return (Keyword *)[context
					   fetchUniqueObjectWithTemplate: template
					   parameters: mkdict({key,name})];
}



@end
