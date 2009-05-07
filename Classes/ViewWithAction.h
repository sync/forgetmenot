//
//  ViewWithAction.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 7/05/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewWithAction : UIView {
	id _target;
	SEL _selector;
	UIImage *_backgroundImage;
	UIImage *_backgroundImageSelected;
	BOOL _selected;
}

@property (nonatomic, retain) id target;
@property (nonatomic) SEL selector;
@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, retain) UIImage *backgroundImageSelected;
@property (nonatomic) BOOL selected;

+ (ViewWithAction *)viewWithFrame:(CGRect)frame target:(id)target action:(SEL)selector backgroundImage:(UIImage *)backgroundImage selectedBackgroundImage:(UIImage *)backgroundImageSelected;

@end
