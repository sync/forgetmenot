//
//  HousesCellView.h
//  Latitude
//
//  Created by Anthony Mittaz on 18/07/08.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleCellView.h"

@interface TitleImageCellView : TitleCellView {
	UIImage *_imagePreview;
}

@property (nonatomic, retain) UIImage *imagePreview;
+ (id)titleImageCellViewWithFrame:(CGRect)frame;

@end