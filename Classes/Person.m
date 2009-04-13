// 
//  Person.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 13/04/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
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
@dynamic post_code;
@dynamic recordID;
@dynamic first_name;
@dynamic city;
@dynamic birthday;
@dynamic created_at;
@dynamic longitude;
@dynamic id;
@dynamic fact;
@dynamic group;

- (NSString *)getId
{
	[self willAccessValueForKey:@"id"];
	if ([self primitiveValueForKey:@"id"] == nil)
		[self getObjectIdString];
	[self didAccessValueForKey:@"id"];
	
	return [self primitiveValueForKey:@"id"];
}

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
