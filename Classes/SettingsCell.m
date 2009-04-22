//
//  TransparentCell.m
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 6/02/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import "SettingsCell.h"
#import "BackgroundViewWithImage.h"
#import "AccessoryViewWithImage.h"
#import "SettingsCellView.h"

@implementation SettingsCell

@synthesize highlighted=_highlighted;

#pragma mark -
#pragma mark Initialisation:

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		// Initialization code
		self.opaque = TRUE;
		self.backgroundColor = [UIColor clearColor];
		
		CGRect cellFrame = CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
		SettingsCellView *cellView = [SettingsCellView viewWithFrame:cellFrame selected:FALSE];
		cellView.tag = SETTINGS_CELL_VIEW;
		[self addSubview:cellView];
		
		NSString *imageName = @"";
		NSString *selectedImageName = @"";
		
		if ([self.reuseIdentifier isEqual:TopTransparentCell]) {
			imageName = @"settings_cell_top.png";
			selectedImageName = @"settings_cell_top_selected.png";
		} else if ([self.reuseIdentifier isEqual:MiddleTransparentCell]) {
			imageName = @"tsettings_cell_middle.png";
			selectedImageName = @"settings_cell_middle_selected.png";
		} else if ([self.reuseIdentifier isEqual:BottomTransparentCell]) {
			imageName = @"settings_cell_bottom.png";
			selectedImageName = @"settings_cell_bottom_selected.png";
		} else if ([self.reuseIdentifier isEqual:UniqueTransparentCell]) {
			imageName = @"settings_cell_unique.png";
			selectedImageName = @"settings_cell_unique_selected.png";
		}
		
		BackgroundViewWithImage *backgroundView = [BackgroundViewWithImage backgroundViewWithFrame:cellFrame andBackgroundImageName:imageName];
		self.backgroundView = backgroundView;
		
		BackgroundViewWithImage *selectedBackgroundView = [BackgroundViewWithImage backgroundViewWithFrame:cellFrame andBackgroundImageName:selectedImageName];
		self.selectedBackgroundView = selectedBackgroundView;
	}
	return self;
}

+ (id)cellWithStyle:(UITableViewCellStyle)style position:(UITableViewCellPosition)position
{	
	NSString *imageName = nil;
	NSString *selectedImageName = nil;
	
	SettingsCell *cell = nil;
	CGRect cellFrame = CGRectMake(0.0, 0.0, cell.contentView.bounds.size.width, cell.contentView.bounds.size.height);
	switch (position) {
		case UITableViewCellPositionTop:
			cell = [[[SettingsCell alloc] initWithStyle:style reuseIdentifier:TopTransparentCell] autorelease];
			imageName = @"settings_cell_top.png";
			selectedImageName = @"settings_cell_top_selected.png";
			break;
		case UITableViewCellPositionBottom:
			cell = [[[SettingsCell alloc] initWithStyle:style reuseIdentifier:BottomTransparentCell] autorelease];
			imageName = @"settings_cell_bottom.png";
			selectedImageName = @"settings_cell_bottom_selected.png";
			break;
		case UITableViewCellPositionUnique:
			cell = [[[SettingsCell alloc] initWithStyle:style reuseIdentifier:UniqueTransparentCell] autorelease];
			imageName = @"settings_cell_unique.png";
			selectedImageName = @"settings_cell_unique_selected.png";
			break;
		default:
			cell = [[[SettingsCell alloc] initWithStyle:style reuseIdentifier:MiddleTransparentCell] autorelease];
			imageName = @"settings_cell_middle.png";
			selectedImageName = @"settings_cell_middle_selected.png";
			break;
	}
	
	// BackgroundView
	BackgroundViewWithImage *backgroundView = [BackgroundViewWithImage backgroundViewWithFrame:cellFrame andBackgroundImageName:imageName];
	cell.backgroundView = backgroundView;
	
	BackgroundViewWithImage *selectedBackgroundView = [BackgroundViewWithImage backgroundViewWithFrame:cellFrame andBackgroundImageName:selectedImageName];
	cell.selectedBackgroundView = selectedBackgroundView;
	
	return cell;
}

- (void)setTitle:(NSString *)aValue
{
	[(SettingsCellView *)[self viewWithTag:SETTINGS_CELL_VIEW]setTitle:aValue];
}

- (void)setImage:(UIImage *)aValue
{
	[(SettingsCellView *)[self viewWithTag:SETTINGS_CELL_VIEW]setImage:aValue];
}


- (void)prepareForReuse
{
	[super prepareForReuse];
	
	[(SettingsCellView *)[self viewWithTag:SETTINGS_CELL_VIEW]removeFromSuperview];
	
	CGRect cellFrame = CGRectMake(0.0, 0.0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
	SettingsCellView *cellView = [SettingsCellView viewWithFrame:cellFrame selected:FALSE];
	cellView.tag = SETTINGS_CELL_VIEW;
	[self addSubview:cellView];
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
    
	[super dealloc];
}


@end
