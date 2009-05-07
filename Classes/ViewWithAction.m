//
//  ViewWithAction.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 7/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "ViewWithAction.h"


@implementation ViewWithAction

@synthesize target=_target;
@synthesize selector=_selector;
@synthesize backgroundImage=_backgroundImage;
@synthesize backgroundImageSelected=_backgroundImageSelected;
@synthesize selected=_selected;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.selected = FALSE;
		self.opaque = YES;
		self.backgroundColor = [UIColor clearColor];
		self.userInteractionEnabled = TRUE;
    }
    return self;
}

- (BOOL)canBecomeFirstResponder {
	return NO;
}

+ (ViewWithAction *)viewWithFrame:(CGRect)frame target:(id)target action:(SEL)selector backgroundImage:(UIImage *)backgroundImage selectedBackgroundImage:(UIImage *)backgroundImageSelected
{
	ViewWithAction *view = [[[ViewWithAction alloc]initWithFrame:frame]autorelease];
	view.target = target;
	view.selector = selector;
	view.backgroundImage = backgroundImage;
	view.backgroundImageSelected = backgroundImageSelected;
	view.selected = FALSE;
	
	return view;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	
	if (self.backgroundImage && self.backgroundImageSelected) {
		if (self.selected) {
			[self.backgroundImageSelected drawInRect:rect];
		} else {
			[self.backgroundImage drawInRect:rect];
		}
	}
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
	if (self.target && self.selector) {
		[self.target performSelector:self.selector withObject:self];
	}
	self.selected = FALSE;
	[self setNeedsDisplay];
}


- (void)dealloc {
	[_target release];
	[_backgroundImage release];
	
    [super dealloc];
}


@end
