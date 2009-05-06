// 
//  Group.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 14/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "Group.h"

#import "Person.h"

@implementation Group 

@dynamic name;
@dynamic updated_at;
@dynamic created_at;
@dynamic color;
@dynamic person;
@dynamic id;

#pragma mark -
#pragma mark Retrieve a person from it's id

+ (Group *)groupWithID:(NSString *)group_id forContext:(NSManagedObjectContext *)context
{
	NSString *key = @"id";
	
	NSString *template = [NSString stringWithFormat: @"%@_with_%@",[self description],key];
    
	return (Group *)[context
					 fetchUniqueObjectWithTemplate: template
					 parameters: mkdict({key,group_id})];
}

@end
