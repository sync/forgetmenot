//
//  TouchImageView.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 17/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "TouchImageView.h"


@implementation TouchImageView

@synthesize selected=_selected;
@synthesize selector=_selector;
@synthesize target=_target;


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.selected = FALSE;
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	self.selected = TRUE;
	[self setNeedsDisplay];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	self.selected = FALSE;
	[self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	self.selected = FALSE;
	[self setNeedsDisplay];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.target performSelector:self.selector withObject:self];
	self.selected = FALSE;
	[self setNeedsDisplay];
}


- (void)dealloc {
	[_target release];
	
    [super dealloc];
}


@end
