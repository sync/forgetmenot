// 
//  Fact.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 13/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "Fact.h"

#import "Person.h"
#import "FactType.h"

@implementation Fact 

@dynamic online_id;
@dynamic fact;
@dynamic id;
@dynamic person;
@dynamic fact_type;

#pragma mark -
#pragma mark Retrieve a person from it's id

+ (Fact *)factWidthID:(NSString *)fact_id forContext:(NSManagedObjectContext *)context
{
	NSString *key = @"id";
	
	NSString *template = [NSString stringWithFormat: @"%@_with_%@",[self description],key];
    
	return (Fact *)[context
					  fetchUniqueObjectWithTemplate: template
					  parameters: mkdict({key,fact_id})];
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
