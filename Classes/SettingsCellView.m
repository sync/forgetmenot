//
//  TransparentCellView.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 6/02/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "SettingsCellView.h"


@implementation SettingsCellView

@synthesize image=_image;
@synthesize title=_title;
@synthesize selected=_selected;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.opaque = TRUE;
		self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+ (id)viewWithFrame:(CGRect)frame selected:(BOOL)selected;
{
	SettingsCellView *cellView = [[[SettingsCellView alloc]initWithFrame:frame]autorelease];
	cellView.selected = selected;
	return cellView;
}



- (void)drawRect:(CGRect)rect {
    // Drawing code
	// Retrieve the graphics context 
	CGContextRef context = UIGraphicsGetCurrentContext(); 
	NSInteger leftWidthToAdd = 0;
	
	if (self.image) {
		// Draw top image
		[self.image drawInRect:CGRectMake(self.bounds.origin.x + 20.0, self.bounds.origin.y + (self.bounds.size.height - 30) / 2.0, 30.0, 30.0) blendMode:kCGBlendModeNormal alpha:1.0];
		leftWidthToAdd = 50.0;
	} else {
		leftWidthToAdd = 0;
	}
	
	
	
	if (self.title) {
		// Draw text
		// Save the context state 
		CGContextSaveGState(context);
		UIFont *boldFont = [UIFont boldSystemFontOfSize:17.0];
		UIColor *bigColor = [UIColor colorWithRed:39.0/255.0 green:39.0/255.0 blue:39.0/255.0 alpha:1.0];
		[bigColor set];
		// Set shadow
		CGContextSetShadowWithColor(context,  CGSizeMake(0.0, -1.0), 0.5, [[UIColor whiteColor]CGColor]);
		[self.title drawInRect:CGRectMake(self.bounds.origin.x + 20.0 + leftWidthToAdd, self.bounds.origin.y + (self.bounds.size.height - 20.0) / 2.0, 230.0 - leftWidthToAdd, 20.0) withFont:boldFont lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
		CGContextRestoreGState(context);
	}
}


- (void)dealloc {
	[_image release];
	[_title release];
	
    [super dealloc];
}


@end
