//
//  ReverseGeoCodeOperation.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 27/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "ReverseGeoCodeOperation.h"


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
	
	NSData *responseData = [self downloadUrl];
	
	if ([responseData length] != 0)  {
        
		if (![self isCancelled])
		{
			NSString *contentAsString = [[NSString alloc]initWithData:responseData encoding:<#(NSStringEncoding)encoding#>
			[self finishPostWithObject:responseData];
		}
	} else {
		[self failPostWithErrorString:@"Unable to retrieve coordinate"];
	}
}

@end
