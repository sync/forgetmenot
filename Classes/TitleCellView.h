//
//  LocationCell.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 26/09/08.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleCellView : UIView {
	NSString *_title;
	
	BOOL _editing;
	BOOL _highlighted;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, getter=isEditing) BOOL editing;
@property (nonatomic, getter=isHighlighted) BOOL highlighted;


@end
