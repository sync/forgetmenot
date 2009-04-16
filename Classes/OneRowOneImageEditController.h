//
//  OneRowOneImageEditController.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 17/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneRowEditController.h"

@class TouchImageView;

@interface OneRowOneImageEditController : OneRowEditController <UIPickerViewDelegate, UIPickerViewDataSource>{
	NSString *_imagePropertyName;
	
	UIPickerView *_pickerView;
	TouchImageView *_imageView;
	
	NSMutableArray *_pickerViews;
}

@property (nonatomic, copy) NSString *imagePropertyName;
@property (nonatomic, retain) NSMutableArray *pickerViews;

@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic, retain) IBOutlet TouchImageView *imageView;

- (IBAction)showPicker:(id)sender;

@end
