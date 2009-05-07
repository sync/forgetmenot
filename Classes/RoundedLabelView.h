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
	NSManagedObjectID *_objectID;
}

@property CGFloat offset;
@property (nonatomic, retain) UILabel *label;
@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, retain) UIImage *selectedBackgroundImage;
@property (nonatomic, retain) NSManagedObjectID *objectID;

+ (id)roundedLabelViewWithFrame:(CGRect)frame;
- (void)checkIfNoMoreFirstResponder:(id)sender;

@end
