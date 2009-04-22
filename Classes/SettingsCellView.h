//
//  TransparentCellView.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 6/02/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsCellView : UIView {
	UIImage *_image;
	NSString *_title;
	BOOL _selected;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *title;
@property BOOL selected;

+ (id)viewWithFrame:(CGRect)frame selected:(BOOL)selected;

@end
