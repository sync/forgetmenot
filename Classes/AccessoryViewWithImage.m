//
//  AccessoryViewWithImage.m
//  Latitude
//
//  Created by Anthony Mittaz on 7/10/08.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "AccessoryViewWithImage.h"


@implementation AccessoryViewWithImage

@synthesize accessoryImage=_accessoryImage;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.opaque = YES;
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(id)accessoryViewWithFrame:(CGRect)frame andImage:(NSString *)imageNamed
{
	AccessoryViewWithImage *accessoryViewWithImage = [[[AccessoryViewWithImage alloc]initWithFrame:frame]autorelease];
	accessoryViewWithImage.accessoryImage = [UIImage imageNamed:imageNamed];
	return accessoryViewWithImage;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	[self.accessoryImage drawInRect:rect];
}


- (void)dealloc {
    [_accessoryImage release];
	
	[super dealloc];
}


@end
