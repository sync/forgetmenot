//
//  HousesCell.h
//  Latitude
//
//  Created by Anthony Mittaz on 18/07/08.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleImageCellView.h"

@interface TitleImageCell : UITableViewCell {
	TitleImageCellView *_cellView;
	BOOL _highlighted;
}

@property (nonatomic, retain) TitleImageCellView *cellView;
@property (nonatomic, getter=isHighlighted) BOOL highlighted;

@end
