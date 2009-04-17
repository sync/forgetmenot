//
//  OneImagePickerItem.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 17/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "OneImagePickerItem.h"

#define MAIN_FONT_SIZE 22
#define MIN_MAIN_FONT_SIZE 16

@implementation OneImagePickerItem

@synthesize title=_title;
@synthesize image=_image;
@synthesize imageNameToSet=_imageNameToSet;

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		self.frame = CGRectMake(0.0, 0.0, 260.0, 44.0);	// we know the frame size
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.backgroundColor = [UIColor clearColor];	// make the background transparent
	}
	return self;
}

- (void)drawRect:(CGRect)rect
{
	// draw the image and title using their draw methods
	CGFloat yCoord = (self.bounds.size.height - self.image.size.height) / 2;
	CGPoint point = CGPointMake(10.0, yCoord);
	[self.image drawAtPoint:point];
	
	yCoord = (self.bounds.size.height - MAIN_FONT_SIZE) / 2;
	point = CGPointMake(10.0 + self.image.size.width + 10.0, yCoord);
	[self.title drawAtPoint:point
	 forWidth:self.bounds.size.width
	 withFont:[UIFont systemFontOfSize:MAIN_FONT_SIZE]
	 minFontSize:MIN_MAIN_FONT_SIZE
	 actualFontSize:NULL
	 lineBreakMode:UILineBreakModeTailTruncation
	 baselineAdjustment:UIBaselineAdjustmentAlignBaselines];
}

- (void)dealloc
{
	[_imageNameToSet release];
	[_title release];
	[_image release];
	[super dealloc];
}


@end
