//
//  RoundedUnitView.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 20/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RoundedLabelView : UIView  <UITextInputTraits>{
	CGFloat _offset;
	UILabel *_label;
	UIImage *_backgroundImage;
	UIImage *_selectedBackgroundImage;
}

@property CGFloat offset;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, retain) UIImage *selectedBackgroundImage;

+ (id)roundedLabelViewWithFrame:(CGRect)frame;

@end
