//
//  FriendPinAnnotation.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 27/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "FriendPinAnnotation.h"


@implementation FriendPinAnnotation

@synthesize objectID=_objectID;
@synthesize coordinate=_coordinate;
@synthesize title=_title;
@synthesize subtitle=_subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate
{
	if ([self init]) {
		self.coordinate = coordinate;
	}
	return self;
}

- (void)dealloc
{
	[_subtitle release];
	[_title release];
	[_objectID release];
	
	[super dealloc];
}

@end
