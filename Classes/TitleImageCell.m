//
//  HousesCell.m
//  Latitude
//
//  Created by Anthony Mittaz on 18/07/08.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "TitleImageCell.h"
#import "BackgroundViewWithImage.h"
#import "AccessoryViewWithImage.h"

@implementation TitleImageCell

@synthesize cellView=_cellView;
@synthesize highlighted=_highlighted;

#pragma mark -
#pragma mark Initialisation:

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		// Initialization code
		self.opaque = YES;
		self.backgroundColor = [UIColor clearColor];
		
		CGRect cellFrame = CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
		TitleImageCellView *aCellView = [TitleImageCellView titleImageCellViewWithFrame:cellFrame];
		self.cellView = aCellView;
		self.cellView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
		[self.contentView addSubview:self.cellView];
		// BackgroundView
		BackgroundViewWithImage *backgroundView = [BackgroundViewWithImage backgroundViewWithFrame:cellFrame andBackgroundImageName:@"itemView.png"];
		self.backgroundView = backgroundView;
		// Selected backgroundView
		BackgroundViewWithImage *selectedBackgroundView = [BackgroundViewWithImage backgroundViewWithFrame:cellFrame andBackgroundImageName:@"itemView_pressed.png"];
		self.selectedBackgroundView = selectedBackgroundView;
		// AccessoryView
		AccessoryViewWithImage *accessoryView = [AccessoryViewWithImage accessoryViewWithFrame:CGRectMake(290.0, (ROW_HEIGHT-23)/2, 16.0, 23.0) 
																					  andImage:@"accessoryDark.png"];
		self.accessoryView = accessoryView;
	}
	return self;
}


#pragma mark -
#pragma mark Allow The TableView To Draw Differently When Cell Is Being Edited:

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
	self.cellView.editing = editing;
	[super setEditing:editing animated:animated];
}

#pragma mark -
#pragma mark Allow The TableView To Draw Differently When Cell Selected:

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

	[super setSelected:selected animated:animated];

	// Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)lit {
	// If highlighted state changes, need to redisplay.
	if (_highlighted != lit) {
		_highlighted = lit;	
		[self setNeedsDisplay];
	}
}

#pragma mark -
#pragma mark Dealloc:

- (void)dealloc {
	[_cellView release];
    
	[super dealloc];
}


@end
