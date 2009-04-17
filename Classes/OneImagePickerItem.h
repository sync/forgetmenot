//
//  OneImagePickerItem.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 17/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface OneImagePickerItem : UIView {
	NSString *_title;
	UIImage *_image;
	NSString *_imageNameToSet;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *imageNameToSet;

@end
