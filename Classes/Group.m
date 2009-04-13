// 
//  Group.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 13/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "Group.h"

#import "Person.h"

@implementation Group 

@dynamic name;
@dynamic updated_at;
@dynamic created_at;
@dynamic online_id;
@dynamic id;
@dynamic color;
@dynamic person;

#pragma mark -
#pragma mark Retrieve a person from it's id

+ (Group *)groupWidthID:(NSString *)group_id forContext:(NSManagedObjectContext *)context
{
	NSString *key = @"id";
	
	NSString *template = [NSString stringWithFormat: @"%@_with_%@",[self description],key];
    
	return (Group *)[context
					  fetchUniqueObjectWithTemplate: template
					  parameters: mkdict({key,group_id})];
}

#pragma mark -
#pragma mark Give you the person id

- (NSString *)getId
{
	[self willAccessValueForKey:@"id"];
	if ([self primitiveValueForKey:@"id"] == nil)
		[self getObjectIdString];
	[self didAccessValueForKey:@"id"];
	
	return [self primitiveValueForKey:@"id"];
}

#pragma mark -
#pragma mark Generate the person id

- (NSString *)getObjectIdString
{
	[self willAccessValueForKey:@"id"];
	NSString * objId = [self primitiveValueForKey:@"id"];
	[self didAccessValueForKey:@"id"];
	
	if (objId == nil || [objId isEqualToString:@""])
	{
		CFUUIDRef uuid = CFUUIDCreate (kCFAllocatorDefault);
		NSString * uuidString = (NSString *) CFUUIDCreateString (kCFAllocatorDefault, uuid);
		
		[self setPrimitiveValue:uuidString forKey:@"id"];
		
		return [self valueForKey:@"id"];
	}
	
	return objId;
}

@end
