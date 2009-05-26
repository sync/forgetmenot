//
//  BackgroundViewWithImage.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 7/10/08.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BackgroundViewWithImage : UIView {
	UIImage *_backgroundImage;
}

@property (nonatomic, retain) UIImage *backgroundImage;

+ (id)backgroundViewWithFrame:(CGRect)frame andBackgroundImageName:(NSString *)imageNamed;

@end
