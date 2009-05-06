// 
//  FactType.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 13/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "FactType.h"

#import "Fact.h"

@implementation FactType 

@dynamic name;
@dynamic image_name;
@dynamic created_at;
@dynamic upated_at;
@dynamic priority;
@dynamic id;
@dynamic fact;

#pragma mark -
#pragma mark Retrieve a person from it's id

+ (FactType *)factTypeWithID:(NSString *)factType_id forContext:(NSManagedObjectContext *)context
{
	NSString *key = @"id";
	
	NSString *template = [NSString stringWithFormat: @"%@_with_%@",[self description],key];
    
	return (FactType *)[context
					  fetchUniqueObjectWithTemplate: template
					  parameters: mkdict({key,factType_id})];
}

@end
