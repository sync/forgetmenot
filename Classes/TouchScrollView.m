//
//  TouchScrollView.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 20/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "TouchScrollView.h"


@implementation TouchScrollView

#define ICON_WIDTH 50.0
#define ICON_SPACE 12.5
#define LEFT_RIGHT_BORDER 10.0

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	if (!self.dragging) {
		UITouch* touch = [[event touchesForView:self] anyObject];
		CGPoint touchLocation = [touch locationInView:self];
		
		CGFloat defaultOffset = LEFT_RIGHT_BORDER + 2 * ICON_WIDTH + 2 * ICON_SPACE + ICON_WIDTH / 2.0;
		
		CGFloat currentPosition = touchLocation.x - defaultOffset;
		
		CGFloat itemWidth = ICON_WIDTH + ICON_SPACE;
		CGFloat itemLocation = (currentPosition / itemWidth);
		NSInteger itemIndex =  round(itemLocation);
		
		NSInteger subviewsCount =[self.subviews count];
		
		if (itemIndex >= 0 && itemIndex < subviewsCount) {
			[self setContentOffset:CGPointMake(itemIndex * itemWidth, 0.0) animated:TRUE];
			if (touch.tapCount != 2) {
				if ([self.delegate respondsToSelector:@selector(scrollViewDoubleTappedAtIndex:)]) {
					[self.delegate performSelector:@selector(scrollViewDoubleTappedAtIndex:) withObject:[NSNumber numberWithInt:itemIndex]];
				}
			}
		}
		
	}		
	[super touchesEnded: touches withEvent: event];
}

- (void)dealloc {
    [super dealloc];
}


@end
