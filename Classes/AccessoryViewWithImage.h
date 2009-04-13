//
//  AccessoryViewWithImage.h
//  Latitude
//
//  Created by Anthony Mittaz on 7/10/08.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AccessoryViewWithImage : UIView {
	UIImage *_accessoryImage;
}

@property (nonatomic, retain) UIImage *accessoryImage;

+(id)accessoryViewWithFrame:(CGRect)frame andImage:(NSString *)imageNamed;

@end
