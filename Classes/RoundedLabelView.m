//
//  RoundedUnitView.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 20/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "RoundedLabelView.h"

@implementation RoundedLabelView

@synthesize offset=_offset;
@synthesize label=_label;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		self.offset = 2.0;
    }
    return self;
}

+ (id)unitViewWithFrame:(CGRect)frame 
{
	RoundedLabelView *unitView = [[[RoundedLabelView alloc]initWithFrame:frame]autorelease];
	UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
	unitView.label = label;
	[label release];
	
	[unitView addSubview:label];
	
	return unitView;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	// Retrieve the graphics context 
	CGContextRef context = UIGraphicsGetCurrentContext(); 
	CGContextSaveGState(context);
	CGRect unitRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
	CGContextSetLineWidth(context, 0.0);
	CGContextBeginPath(context);
	CGContextAddRect(context, unitRect);
	CGContextDrawPath(context, kCGPathFill);
	CGContextRestoreGState(context);
}

- (void)layoutSubviews
{
	CGRect newBounds = CGRectZero;
	for (UILabel *label in self.subviews) {
		CGFloat newBoundsWidth = [label textRectForBounds:CGRectMake(0.0, 0.0, FLT_MAX, self.bounds.size.height)limitedToNumberOfLines:1].size.width;
		newBounds = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, newBoundsWidth, self.bounds.size.height);
		if (newBounds.size.width == 0) {
			self.frame = CGRectZero;
		} else {
			self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newBounds.size.width + self.offset * 2.0, self.frame.size.height);
		}
		label.frame = self.bounds;
	}
	
	
	
	[super layoutSubviews];
	
}


- (void)dealloc {
	[_label release];
	
    [super dealloc];
}


@end
