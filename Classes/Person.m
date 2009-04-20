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

@dynamic street;
@dynamic state;
@dynamic last_name;
@dynamic modified_at;
@dynamic middle_names;
@dynamic online_id;
@dynamic country;
@dynamic latitude;
@dynamic image_url;
@dynamic local_image_url;
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

@synthesize fullName;
@synthesize fullAddress;
@synthesize partialAddress;

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

#pragma mark -
#pragma mark Full Name

- (NSString *)fullName
{
	if (self.first_name && self.last_name) {
		return [NSString stringWithFormat:@"%@ %@", self.first_name, self.last_name];
	} else if (self.first_name) {
		return	[NSString stringWithFormat:@"%@", self.first_name];
	} else if (self.last_name) {
		return	[NSString stringWithFormat:@"%@", self.last_name];
	}
	return @"n/a";
}

#pragma mark -
#pragma mark Address

- (NSString *)fullAddress
{
	if (!self.street && !self.state && !self.city && !self.post_code && !self.country) {
		return @"n/a";
	}
	
	NSString *street = self.street;
	NSString *city = self.city;
	NSString *state = self.state;
	NSString *post_code = self.post_code;
	NSString *country = self.country;
	
	if (!street) {
		street = @"";
	} else {
		street = [NSString stringWithFormat:@"%@, ", street];
	}
	
	if (!city) {
		city = @"";
	} else {
		city = [NSString stringWithFormat:@"%@, ", city];
	}
	
	if (!state) {
		state = @"";
	} else {
		state = [NSString stringWithFormat:@"%@, ", state];
	}
	
	if (!post_code) {
		post_code = @"";
	} else if (!country) {
		post_code = [NSString stringWithFormat:@"%@", post_code];
	} else {
		post_code = [NSString stringWithFormat:@"%@, ", post_code];
	}
	
	if (!country) {
		country = @"";
	}
	return [NSString stringWithFormat:@"%@%@%@%@%@", street, city, state, post_code, country];
}

- (NSString *)partialAddress
{
	if (!self.state && !self.city && !self.country) {
		return @"n/a";
	}
	
	NSString *city = self.city;
	NSString *state = self.state;
	NSString *country = self.country;
	
	if (!city) {
		city = @"";
	} else {
		city = [NSString stringWithFormat:@"%@, ", city];
	}
	
	if (!state) {
		state = @"";
	} else if (!country) {
		state = [NSString stringWithFormat:@"%@", state];
	} else {
		state = [NSString stringWithFormat:@"%@, ", state];
	}
	
	if (!country) {
		country = @"";
	}
	
	return [NSString stringWithFormat:@"%@%@%@", city, state, country];
}

#pragma mark -
#pragma mark Before Deleting

- (void)prepareForDeletion
{
	if (self.local_image_url) {
		// Remove the image 
		NSString *imageURL = [[self applicationDocumentsDirectory]stringByAppendingPathComponent:self.local_image_url];
		/*
		 Set up the store.
		 For the sake of illustration, provide a pre-populated default store.
		 */
		NSFileManager *fileManager = [NSFileManager defaultManager];
		// If the expected store doesn't exist, copy the default store.
		if ([fileManager fileExistsAtPath:imageURL]) {
			[fileManager removeItemAtPath:imageURL error:nil];
		}
	}
}

#pragma mark -
#pragma mark Application's documents directory

/**
 Returns the path to the application's documents directory.
 */
- (NSString *)applicationDocumentsDirectory 
{
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

@end
