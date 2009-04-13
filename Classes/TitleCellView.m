//
//  LocationCell.m
//  Latitude
//
//  Created by Anthony Mittaz on 26/09/08.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "TitleCellView.h"


@implementation TitleCellView

@synthesize title=_title;
@synthesize editing=_editing;
@synthesize highlighted=_highlighted;


#pragma mark -
#pragma mark Initialisation:

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// Initialization code
		self.opaque = YES;
		self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

#pragma mark -
#pragma mark Set The location If Different And Redraw The String:

- (void)setTitle:(NSString *)title {
	if (_title != title) {
		[_title release];
		_title = [title retain];
		[self setNeedsDisplay];
	}
}

#pragma mark -
#pragma mark Allow The TableView To Draw Differently When Cell Is Being Edited:

- (void)setEditing:(BOOL)editing {
	if (_editing != editing) {
		_editing = editing;
		[self setNeedsDisplay];
	}
	
}

#pragma mark -
#pragma mark Allow The TableView To Draw The Accessory type if asked:

- (void)setHighlighted:(BOOL)lit {
	// If highlighted state changes, need to redisplay.
	if (_highlighted != lit) {
		_highlighted = lit;	
		[self setNeedsDisplay];
	}
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
	// Drawing code
	// Retrieve the graphics context 
	CGContextRef context = UIGraphicsGetCurrentContext(); 
	
	// Text
	// Save the context state 
	CGContextSaveGState(context);
	// Define font and color
	UIFont *boldFont = [UIFont boldSystemFontOfSize:17.0];
	UIColor *bigColor = [UIColor colorWithRed:39.0/255.0 green:39.0/255.0 blue:39.0/255.0 alpha:1.0];
	[bigColor set];
	// Set shadow
	CGContextSetShadowWithColor(context,  CGSizeMake(0.0, -1.0), 0.5, [[UIColor whiteColor]CGColor]);
	// Draw the text
	[self.title drawInRect:CGRectMake(20.0, (ROW_HEIGHT-20)/2, 260, 20.0) withFont:boldFont lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
	CGContextRestoreGState(context);
}

#pragma mark -
#pragma mark Dealloc:

- (void)dealloc {
	[_title release];
	
	[super dealloc];
}


@end
