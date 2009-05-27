//
//  ReverseGeoCodeOperation.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 27/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "ReverseGeoCodeOperation.h"
#import "JSON.h"

@implementation ReverseGeoCodeOperation

#pragma mark -
#pragma mark This Is Where The Download And Processing Append:

// By the way the is a reason why this method 
// is not spitted into multiple files
- (void)main
{
	if ([self isCancelled])
	{
		return;  // user cancelled this operation
	}
	
	[self startOperation];
	
	NSData *responseData = [self downloadUrl];
	
	if ([responseData length] != 0)  {
        
		if (![self isCancelled])
		{
			NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:0];
			[dictionary addEntriesFromDictionary:self.infoDictionary];
			NSString *jsonString = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
			SBJSON *json = [[SBJSON alloc]init]; 
			NSDictionary* result = (NSDictionary *)[json objectWithString:jsonString error:nil];
			
			NSArray *placemarks = [result valueForKey:@"Placemark"];
			if (placemarks && [placemarks count] > 0) {
				NSDictionary *placemark = [placemarks objectAtIndex:0];
				
				NSArray *coordinates = [placemark valueForKeyPath:@"Point.coordinates"];
				if (coordinates && [coordinates count] > 1) {
					[dictionary setValue:[NSNumber numberWithDouble:[[NSString stringWithFormat:@"%@", 
																	  [coordinates objectAtIndex:1]]doubleValue]] 
								  forKey:@"latitude"];	
					[dictionary setValue:[NSNumber numberWithDouble:[[NSString stringWithFormat:@"%@", 
																	  [coordinates objectAtIndex:0]]doubleValue]]
								  forKey:@"longitude"];	
				}
				
			}
			[jsonString release];
			[json release];
			
			[self finishOperationWithObject:dictionary];
		}
	} else {
		[self failOperationWithErrorString:@"Unable to retrieve coordinate"];
	}
}

@end
