//
//  RoundedUnitView.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 20/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "RoundedLabelView.h"
#import "KeywordView.h"

@implementation RoundedLabelView

@synthesize offset=_offset;
@synthesize label=_label;
@synthesize backgroundImage=_backgroundImage;
@synthesize selectedBackgroundImage=_selectedBackgroundImage;
@synthesize objectID=_objectID;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		self.offset = 4.0;
		
		UIImage *backgroundImage = [UIImage imageNamed:@"label_background.png"];
		backgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:15.0 topCapHeight:0.0];
		self.backgroundImage = backgroundImage;
		
		UIImage *selectedBackgroundImage = [UIImage imageNamed:@"label_background_selected.png"];
		selectedBackgroundImage = [selectedBackgroundImage stretchableImageWithLeftCapWidth:15.0 topCapHeight:0.0];
		self.selectedBackgroundImage = selectedBackgroundImage;
    }
    return self;
}

+ (id)roundedLabelViewWithFrame:(CGRect)frame 
{
	RoundedLabelView *unitView = [[[RoundedLabelView alloc]initWithFrame:frame]autorelease];
	UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
	unitView.label = label;
	label.backgroundColor = [UIColor clearColor];
	label.textAlignment = UITextAlignmentCenter;
	label.font = [UIFont systemFontOfSize:14.0];
	[label release];
	
	[unitView addSubview:label];
	
	return unitView;
}

- (BOOL)canBecomeFirstResponder {
	return YES;
}

- (BOOL)becomeFirstResponder
{
	self.label.textColor = [UIColor whiteColor];
	[self setNeedsDisplay];
	[[NSNotificationCenter defaultCenter] postNotificationName:ShouldShowKeywordDeleteButtonNotification object:self];
	return [super becomeFirstResponder];
}

- (BOOL)resignFirstResponder
{
	self.label.textColor = [UIColor blackColor];
	[self setNeedsDisplay];
	
	[self performSelector:@selector(checkIfNoMoreFirstResponder:) withObject:self afterDelay:0.1];
	
	return [super resignFirstResponder];;
}

- (void)checkIfNoMoreFirstResponder:(id)sender
{
	if (![self isFirstResponder]) {
		[[NSNotificationCenter defaultCenter] postNotificationName:ShouldHideKeywordDeleteButtonNotification object:nil];
	} else {
		[self performSelector:@selector(checkIfNoMoreFirstResponder:) withObject:self afterDelay:0.1];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self becomeFirstResponder];
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
	// Retrieve the graphics context 
	CGContextRef context = UIGraphicsGetCurrentContext(); 
	CGContextSaveGState(context);
	CGRect backgroundRect = CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, self.bounds.size.height);
	if (![self isFirstResponder]) {
		[self.backgroundImage drawInRect:backgroundRect];
	} else {
		[self.selectedBackgroundImage drawInRect:backgroundRect];
	}
	
	CGContextRestoreGState(context);
}

- (void)layoutSubviews
{
	CGRect newBounds = CGRectZero;
	for (UILabel *label in self.subviews) {
		CGFloat newBoundsWidth = [label textRectForBounds:CGRectMake(0.0, 0.0, FLT_MAX, self.bounds.size.height)limitedToNumberOfLines:1].size.width;
		if (newBoundsWidth > 0.0 && newBoundsWidth < 26.0) {
			newBoundsWidth = 26.0;
		}
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
	[_objectID release];
	[_selectedBackgroundImage release];
	[_backgroundImage release];
	[_label release];
	
    [super dealloc];
}


@end
