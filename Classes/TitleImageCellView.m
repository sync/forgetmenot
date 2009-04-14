//
//  HousesCellView.m
//  Latitude
//
//  Created by Anthony Mittaz on 18/07/08.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "TitleImageCellView.h"

@implementation TitleImageCellView

@synthesize imagePreview=_imagePreview;

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

+ (id)titleImageCellViewWithFrame:(CGRect)frame
{
	TitleImageCellView *aCellView = [[[TitleImageCellView alloc] initWithFrame:frame]autorelease];
	return aCellView;
}

#pragma mark -
#pragma mark Set The surfAndReporterConditions If Different And Redraw The String:

- (void)setImagePreview:(UIImage *)imagePreview 
{
	if (_imagePreview != imagePreview) {
		[_imagePreview release];
		_imagePreview = [imagePreview retain];
		[self setNeedsDisplay];
	}
}

#pragma mark -
#pragma mark Drawing

- (void)drawRect:(CGRect)rect {
	// Drawing code
	// Retrieve the graphics context 
	CGContextRef context = UIGraphicsGetCurrentContext(); 
	
	// Image
	if (self.imagePreview) {
		// Masked image
		CGImageRef imageRef = [self.imagePreview CGImage];
		CGContextRef alphaContext = CGBitmapContextCreate(
														  NULL,CGImageGetWidth(imageRef),
														  CGImageGetHeight(imageRef),
														  CGImageGetBitsPerComponent(imageRef),
														  CGImageGetBytesPerRow(imageRef),
														  NULL,
														  kCGImageAlphaOnly
		);
		CGContextDrawImage(alphaContext,CGRectMake(0,0,CGImageGetWidth(imageRef),-CGImageGetHeight(imageRef)),imageRef);
		CGImageRef maskRef = CGBitmapContextCreateImage(alphaContext);
		CGContextRelease(alphaContext);

		//CGImageRelease(imageRef);
		//CGImageRelease(maskRef);
		// Save the context state 
		CGContextSaveGState(context); 
		// Adjust the coordinate system so that the origin 
		// is in the lower left corner of the view and the 
		// y axis points up 
		CGContextTranslateCTM(context, 0, self.bounds.size.height); 
		CGContextScaleCTM(context, 1.0, -1.0); 
		// Create mask
		CGImageRef xMaskedImage = CGImageCreateWithMask (imageRef,maskRef);
		// Draw the image 
		CGContextDrawImage(context, CGRectMake(14.2, (ROW_HEIGHT-54.0)/2, 54.0, 54.0), xMaskedImage); 
		CGImageRelease(maskRef);
		CGImageRelease(xMaskedImage);
		CGContextRestoreGState(context);
	}
	
	
	// Border
	CGRect imgRect = CGRectMake(12.0, (ROW_HEIGHT-50.0)/2, 50.0, 50.0);
	[[UIImage imageNamed:@"imageCell.png"]drawInRect:imgRect];
	
	// Text
	// Save the context state 
	CGContextSaveGState(context);
	// Define font and color
	UIFont *boldFont = [UIFont boldSystemFontOfSize:12.0];
	UIColor *bigColor = [UIColor colorWithRed:39.0/255.0 green:39.0/255.0 blue:39.0/255.0 alpha:1.0];
	[bigColor set];
	// Set shadow
	CGContextSetShadowWithColor(context,  CGSizeMake(0.0, -1.0), 0.5, [[UIColor whiteColor]CGColor]);
	// Draw the text
	[self.title drawInRect:CGRectMake(80.0, (ROW_HEIGHT-20)/2, 210.0, 15.0) withFont:boldFont lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentLeft];
	CGContextRestoreGState(context);
}


#pragma mark -
#pragma mark Dealloc:

- (void)dealloc {
	[_imagePreview release];
	
	[super dealloc];
}


@end
