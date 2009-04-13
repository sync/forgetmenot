//
//  BackgroundView.m
//  Latitude
//
//  Created by Anthony Mittaz on 7/10/08.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "BackgroundViewWithImage.h"


@implementation BackgroundViewWithImage

@synthesize backgroundImage=_backgroundImage;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.opaque = YES;
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (id)backgroundViewWithFrame:(CGRect)frame andBackgroundImageName:(NSString *)imageNamed
{
	BackgroundViewWithImage *cellView = [[[BackgroundViewWithImage alloc]initWithFrame:frame]autorelease];
	cellView.backgroundImage = [UIImage imageNamed:imageNamed];
	return cellView;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	[self.backgroundImage drawInRect:rect];
}

- (void)dealloc {
    [_backgroundImage release];
	
	[super dealloc];
}


@end
