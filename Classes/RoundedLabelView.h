//
//  RoundedUnitView.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 20/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RoundedLabelView : UIView {
	CGFloat _offset;
}

@property CGFloat offset;

+ (id)unitViewWithFrame:(CGRect)frame;

@end
