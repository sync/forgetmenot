//
//  TitleCellBlack.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 14/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "TitleCellBlack.h"
#import "BackgroundViewWithImage.h"
#import "AccessoryViewWithImage.h"

@implementation TitleCellBlack

#pragma mark -
#pragma mark Initialisation:

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		// Initialization code
		self.opaque = YES;
		self.backgroundColor = [UIColor clearColor];
		// ContentView
		CGRect cellFrame = CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
		TitleCellViewBlack *aCell = [[TitleCellViewBlack alloc] initWithFrame:cellFrame];
		self.cellView = aCell;
		[aCell release];
		self.cellView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
		[self.contentView addSubview:self.cellView];
		// BackgroundView
		BackgroundViewWithImage *backgroundView = [BackgroundViewWithImage backgroundViewWithFrame:cellFrame andBackgroundImageName:@"itemView_black.png"];
		self.backgroundView = backgroundView;
		// AccessoryView
		AccessoryViewWithImage *accessoryView = [AccessoryViewWithImage accessoryViewWithFrame:CGRectMake(290.0, (ROW_HEIGHT-23)/2, 16.0, 23.0) 
																					  andImage:@"accessoryLight.png"];
		self.accessoryView = accessoryView;
	}
	return self;
}


@end
