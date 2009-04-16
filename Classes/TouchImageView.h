//
//  TouchImageView.h
//  ForgetMeNot
//
//  Created by Anthony Mittaz on 17/04/09.
//  Copyright 2009 Anthony Mittaz. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TouchImageView : UIImageView {
	BOOL _selected;
	SEL _selector;
	
	id _target;
}

@property (nonatomic) BOOL selected;
@property (nonatomic) SEL selector;
@property (nonatomic, retain) id target;

@end
