//
//  LocationCell.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 27/09/08.
//  Copyright 2008 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleCellView.h"

@interface TitleCell : UITableViewCell {
	TitleCellView *_cellView;
	BOOL _highlighted;
}

@property (nonatomic, retain) TitleCellView *cellView;
@property (nonatomic, getter=isHighlighted) BOOL highlighted;


@end
