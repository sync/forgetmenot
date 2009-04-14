// 
//  Person.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 14/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "Person.h"

#import "Fact.h"
#import "Group.h"

@implementation Person 

@dynamic address;
@dynamic last_name;
@dynamic modified_at;
@dynamic middle_names;
@dynamic online_id;
@dynamic country;
@dynamic latitude;
@dynamic image_url;
@dynamic recordID;
@dynamic post_code;
@dynamic birthday;
@dynamic first_name;
@dynamic city;
@dynamic created_at;
@dynamic longitude;
@dynamic id;
@dynamic fact;
@dynamic group;

#pragma mark -
#pragma mark Retrieve a person from it's id

+ (Person *)personWithID:(NSString *)person_id forContext:(NSManagedObjectContext *)context
{
	NSString *key = @"id";
	
	NSString *template = [NSString stringWithFormat: @"%@_with_%@",[self description],key];
    
	return (Person *)[context
					  fetchUniqueObjectWithTemplate: template
					  parameters: mkdict({key,person_id})];
}

+ (Person *)personWithRecordID:(NSNumber *)recordID forContext:(NSManagedObjectContext *)context
{
	NSString *key = @"recordID";
	
	NSString *template = [NSString stringWithFormat: @"%@_with_%@",[self description],key];
    
	return (Person *)[context
					  fetchUniqueObjectWithTemplate: template
					  parameters: mkdict({key,recordID})];
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
