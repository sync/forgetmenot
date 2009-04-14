//
//  TitleCellViewBlack.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 14/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "TitleCellViewBlack.h"


@implementation TitleCellViewBlack


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
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
	UIFont *boldFont = [UIFont boldSystemFontOfSize:21.0];
	UIColor *bigColor = [UIColor colorWithRed:228.0/255.0 green:229.0/255.0 blue:233.0/255.0 alpha:1.0];
	[bigColor set];
	// Draw the text
	[self.title drawInRect:CGRectMake(10.0, (BLACK_ROW_HEIGHT-27.0)/2, 260, 27.0) withFont:boldFont lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
	CGContextRestoreGState(context);
}


- (void)dealloc {
    [super dealloc];
}


@end
