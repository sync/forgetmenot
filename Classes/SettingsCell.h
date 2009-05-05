//
//  TransparentCell.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 6/02/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    UITableViewCellPositionTop, 
    UITableViewCellPositionMiddle,
	UITableViewCellPositionBottom,
	UITableViewCellPositionUnique
} UITableViewCellPosition;


@interface SettingsCell : UITableViewCell {
	BOOL _highlighted;
	NSString *_factTypeID;
}

@property (nonatomic, getter=isHighlighted) BOOL highlighted;
@property (nonatomic, retain) NSString *factTypeID;

+ (id)cellWithStyle:(UITableViewCellStyle)style position:(UITableViewCellPosition)position;

- (void)setTitle:(NSString *)aValue;
- (void)setImage:(UIImage *)aValue;

@end
